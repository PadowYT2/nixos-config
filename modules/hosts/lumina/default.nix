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
        inputs.arion.nixosModules.arion
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
          }: let
            cloudflare = {
              ipv4 = [
                "173.245.48.0/20"
                "103.21.244.0/22"
                "103.22.200.0/22"
                "103.31.4.0/22"
                "141.101.64.0/18"
                "108.162.192.0/18"
                "190.93.240.0/20"
                "188.114.96.0/20"
                "197.234.240.0/22"
                "198.41.128.0/17"
                "162.158.0.0/15"
                "104.16.0.0/13"
                "104.24.0.0/14"
                "172.64.0.0/13"
                "131.0.72.0/22"
              ];

              ipv6 = [
                "2400:cb00::/32"
                "2606:4700::/32"
                "2803:f800::/32"
                "2405:b500::/32"
                "2405:8100::/32"
                "2a06:98c0::/29"
                "2c0f:f248::/32"
              ];
            };
          in {
            system.stateVersion = "26.05";

            boot = {
              initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sr_mod"];
              kernelModules = ["kvm-amd" "tcp_bbr" "nf_conntrack"];
              extraModprobeConfig = ''
                options nf_conntrack hashsize=524288
              '';

              swraid = {
                enable = true;
                mdadmConf = ''
                  MAILADDR root
                '';
              };

              kernel.sysctl = {
                "net.core.default_qdisc" = "fq";
                "net.ipv4.tcp_congestion_control" = "bbr";

                "net.ipv4.ip_forward" = 1;
                "net.ipv6.conf.all.forwarding" = 1;
                "net.ipv4.tcp_max_syn_backlog" = 16384;
                "net.netfilter.nf_conntrack_max" = 2097152;

                "net.ipv4.ip_local_port_range" = "16384 65535";
                "net.ipv4.tcp_tw_reuse" = 1;

                "net.core.somaxconn" = 65535;
                "net.core.netdev_max_backlog" = 65536;

                "net.core.rmem_max" = 16777216;
                "net.core.wmem_max" = 16777216;
                "net.ipv4.tcp_rmem" = "4096 87380 16777216";
                "net.ipv4.tcp_wmem" = "4096 65536 16777216";
              };
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

            services.btrfs.autoScrub = {
              enable = true;
              interval = "monthly";
              fileSystems = ["/"];
            };

            networking = {
              hostName = "lumina";
              firewall = {
                checkReversePath = "loose";
                trustedInterfaces = ["lo" "docker0"];
                extraForwardRules = ''
                  iifname {"docker0", "pterodactyl0", "br-*"} accept
                '';
                allowedTCPPortRanges = [
                  {
                    from = 41230;
                    to = 41232;
                  }
                ];
              };
              nftables.enable = true;
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
                  ];
                  linkConfig.RequiredForOnline = "routable";
                };
              };

              links."10-eth0" = {
                matchConfig.MACAddress = "50:EB:F6:22:F1:10";
                linkConfig = {
                  Name = "eth0";
                  MACAddressPolicy = "persistent";
                  RxBufferSize = 4096;
                  TxBufferSize = 4096;
                };
              };
            };

            virtualisation = {
              arion.backend = "docker";
              docker = {
                enable = true;
                daemon.settings = {
                  mtu = 1500;
                  default-cgroupns-mode = "private";
                  exec-opts = ["native.cgroupdriver=systemd"];
                };
              };
            };

            services.caddy = {
              enable = true;
              openFirewall = true;

              globalConfig = ''
                servers {
                  trusted_proxies static private_ranges ${builtins.concatStringsSep " " (cloudflare.ipv4 ++ cloudflare.ipv6)}
                }
              '';
            };

            users.users.root.openssh.authorizedKeys.keys = with keys; [djoh];
          }
        )
      ];
  };
}
