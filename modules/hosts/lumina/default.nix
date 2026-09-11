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
          }: {
            system.stateVersion = "26.05";

            boot = {
              initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sr_mod"];
              kernelModules = ["kvm-amd"];

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

                "net.ipv4.tcp_syn_retries" = 2;
                "net.ipv4.tcp_synack_retries" = 2;
                "net.ipv4.tcp_max_syn_backlog" = 65536;

                "net.core.somaxconn" = 65535;
                "net.core.netdev_max_backlog" = 250000;
                "net.ipv4.ip_local_port_range" = "1024 65535";
                "net.ipv4.tcp_tw_reuse" = 1;
                "net.ipv4.tcp_fin_timeout" = 15;

                "net.core.rmem_max" = 16777216;
                "net.core.wmem_max" = 16777216;
                "net.ipv4.tcp_rmem" = "4096 87380 16777216";
                "net.ipv4.tcp_wmem" = "4096 65536 16777216";

                "net.netfilter.nf_conntrack_max" = 2000000;
                "net.netfilter.nf_conntrack_tcp_loose" = 0;
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
            };

            users.users.root.openssh.authorizedKeys.keys = with keys; [djoh];
          }
        )
      ];
  };
}
