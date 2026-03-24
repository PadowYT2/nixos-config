{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.lumina = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        "${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
      ]
      ++ map (name: ./_modules + "/${name}") (builtins.attrNames (builtins.readDir ./_modules))
      ++ [
        (
          {
            config,
            lib,
            keys,
            ...
          }: {
            system.stateVersion = "25.05";

            boot = {
              initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sr_mod"];
              kernelModules = ["kvm-amd"];

              swraid = {
                enable = true;
                mdadmConf = ''
                  MAILADDR root
                '';
              };

              loader = {
                efi.canTouchEfiVariables = false;
                grub = {
                  devices = ["nodev"];
                  efiInstallAsRemovable = true;
                };
              };

              kernel.sysctl = {
                "net.ipv4.ip_forward" = 1;
                "net.ipv6.conf.all.forwarding" = 1;
                "net.ipv4.tcp_syncookies" = 1;
                "net.ipv4.tcp_max_syn_backlog" = 2048;
                "net.netfilter.nf_conntrack_max" = 262144;
                "net.netfilter.nf_conntrack_tcp_loose" = 0;
                "net.ipv4.tcp_abort_on_overflow" = 1;

                "net.ipv4.conf.all.rp_filter" = 2;
                "net.ipv4.conf.default.rp_filter" = 2;
                "net.ipv4.conf.eth0.rp_filter" = 2;
                "net.ipv4.conf.ipsec0.rp_filter" = 0;
              };

              kernelPatches = [
                {
                  name = "cgroups-v1-for-jvm";
                  patch = null;
                  structuredExtraConfig = {
                    CPUSETS_V1 = lib.kernel.yes;
                    MEMCG_V1 = lib.kernel.yes;
                  };
                }
              ];
            };

            hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

            disko.devices = {
              disk =
                lib.mapAttrs (name: disk: {
                  device = "/dev/disk/by-id/${disk.id}";
                  type = "disk";
                  content = {
                    type = "gpt";
                    partitions = {
                      boot = {
                        size = "1M";
                        type = "EF02";
                        priority = 1;
                      };

                      ESP = {
                        size = "1G";
                        type = "EF00";
                        content = {
                          type = "mdraid";
                          name = "boot";
                        };
                      };

                      root =
                        {
                          size = "100%";
                          label = disk.rootLabel;
                        }
                        // lib.optionalAttrs (name == "nvme1") {
                          content = {
                            type = "btrfs";
                            extraArgs = ["-d" "raid1" "/dev/disk/by-partlabel/root0"];
                            subvolumes."/".mountpoint = "/";
                          };
                        };
                    };
                  };
                })
                {
                  nvme0 = {
                    id = "nvme-eui.36344830544049260025384500000007";
                    rootLabel = "root0";
                  };
                  nvme1 = {
                    id = "nvme-eui.36344830541166580025384500000001";
                    rootLabel = "root1";
                  };
                };

              mdadm.boot = {
                type = "mdadm";
                level = 1;
                metadata = "1.0";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
            };

            networking = {
              hostName = "lumina";

              firewall = {
                checkReversePath = "loose";
                trustedInterfaces = ["ipsec0" "lo" "docker0" "pterodactyl0"];

                extraInputRules = ''
                  iifname "eth0" tcp dport 22 accept
                  iifname "eth0" icmp type echo-request accept
                  iifname "eth0" icmpv6 type echo-request accept
                  iifname "eth0" ip saddr 95.135.208.17 udp dport {500, 4500} accept
                  iifname "eth0" drop
                '';

                extraForwardRules = ''
                  iifname {"docker0", "pterodactyl0", "br-*"} oifname {"docker0", "pterodactyl0", "br-*"} accept
                  iifname {"docker0", "pterodactyl0", "br-*"} oifname "ipsec0" accept
                  iifname "ipsec0" oifname {"docker0", "pterodactyl0", "br-*"} accept
                  iifname {"docker0", "pterodactyl0", "br-*"} oifname "eth0" drop
                '';
              };

              nftables = {
                enable = true;
                tables.storage-box = {
                  family = "inet";
                  content = ''
                    set storage_box_ipv4 {
                      type ipv4_addr
                      flags interval
                    }

                    set storage_box_ipv6 {
                      type ipv6_addr
                      flags interval
                    }

                    chain mangle_output {
                      type route hook output priority mangle; policy accept;
                      ip daddr @storage_box_ipv4 meta mark set 0x64
                      ip6 daddr @storage_box_ipv6 meta mark set 0x64
                    }

                    chain mangle_prerouting {
                      type filter hook prerouting priority mangle; policy accept;
                      ip daddr @storage_box_ipv4 meta mark set 0x64
                      ip6 daddr @storage_box_ipv6 meta mark set 0x64
                    }
                  '';
                };
              };

              iproute2 = {
                enable = true;
                rttablesExtraConfig = ''
                  200 direct
                '';
              };
            };

            systemd.network = {
              networks = {
                "10-eth0" = {
                  matchConfig.Name = "eth0";
                  address = ["5.9.109.12/27" "2a01:4f8:162:502e::2/64"];
                  gateway = ["5.9.109.1"];
                  routes = [
                    {
                      Destination = "::/0";
                      Gateway = "fe80::1";
                      GatewayOnLink = true;
                    }
                    {
                      Destination = "2a12:bec4:1821:61f::a/128";
                      Gateway = "fe80::1";
                      GatewayOnLink = true;
                    }
                    {
                      Gateway = "5.9.109.1";
                      Table = 200;
                    }
                    {
                      Gateway = "fe80::1";
                      GatewayOnLink = true;
                      Table = 200;
                    }
                  ];
                  routingPolicyRules = [
                    {
                      To = "5.9.109.0/27";
                      Table = 200;
                      Priority = 5;
                    }
                    {
                      Family = "ipv6";
                      To = "2a01:4f8:162:502e::/64";
                      Table = 200;
                      Priority = 5;
                    }
                    {
                      From = "5.9.109.12";
                      Table = 200;
                      Priority = 10;
                    }
                    {
                      Family = "ipv6";
                      From = "2a01:4f8:162:502e::2";
                      Table = 200;
                      Priority = 10;
                    }
                    {
                      FirewallMark = 100;
                      Table = 200;
                      Priority = 1;
                    }
                  ];
                  xfrm = ["ipsec0"];
                  linkConfig.RequiredForOnline = "routable";
                };

                "20-ipsec0" = {
                  matchConfig.Name = "ipsec0";
                  address = ["10.0.0.2/24" "fd00:1337::2/64"];
                  routes = [
                    {
                      Destination = "0.0.0.0/0";
                      Scope = "global";
                    }
                    {
                      Destination = "::/0";
                      Scope = "global";
                    }
                  ];
                  linkConfig.RequiredForOnline = "no";
                };
              };

              netdevs = {
                "20-ipsec0" = {
                  netdevConfig = {
                    Name = "ipsec0";
                    Kind = "xfrm";
                  };
                  xfrmConfig.InterfaceId = 42;
                };
              };
            };

            services.caddy = {
              enable = true;

              globalConfig = ''
                servers {
                  trusted_proxies static private_ranges
                }
              '';

              virtualHosts = {
                "2fa.tvrz.dev".extraConfig = ''
                  reverse_proxy http://144.31.167.137:25582
                '';
              };
            };

            users.users.root.openssh.authorizedKeys.keys = [keys.djoh];
          }
        )
      ];
  };
}
