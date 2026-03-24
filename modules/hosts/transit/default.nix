{
  self,
  inputs,
  ...
}: let
  mkForward = port: proto: {
    destination = "10.0.0.2:${toString port}";
    sourcePort = port;
    inherit proto;
    loopbackIPs = ["95.135.208.17"];
  };
in {
  flake.nixosConfigurations.transit = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        remotebuild
        "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
      ]
      ++ map (name: ./_modules + "/${name}") (builtins.attrNames (builtins.readDir ./_modules))
      ++ [
        ({pkgs, ...}: {
          system.stateVersion = "25.05";

          boot = {
            initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "ahci" "sr_mod" "virtio_blk"];

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
              "net.ipv4.conf.ens3.rp_filter" = 2;
              "net.ipv4.conf.ipsec0.rp_filter" = 0;
            };
          };

          disko.devices = {
            disk.main = {
              device = "/dev/disk/by-path/virtio-pci-0000:00:07.0";
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  boot = {
                    size = "1M";
                    type = "EF02";
                  };

                  ESP = {
                    size = "1G";
                    type = "EF00";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      mountpoint = "/boot";
                      mountOptions = ["umask=0077"];
                    };
                  };

                  root = {
                    size = "100%";
                    content = {
                      type = "filesystem";
                      format = "ext4";
                      mountpoint = "/";
                    };
                  };
                };
              };
            };
          };

          networking = {
            hostName = "transit";

            firewall = {
              allowedTCPPorts = [20269];
              allowedUDPPorts = [500 4500 20269];
              checkReversePath = "loose";
              trustedInterfaces = ["ipsec0"];

              extraForwardRules = ''
                iifname "ipsec0" oifname "ens3" accept
                iifname "ens3" oifname "ipsec0" accept
              '';
            };

            nftables = {
              enable = true;
              tables = {
                mss-clamp = {
                  family = "inet";
                  content = ''
                    chain forward {
                      type filter hook forward priority mangle; policy accept;
                      tcp flags syn / syn,rst tcp option maxseg size set rt mtu
                    }
                  '';
                };
                transit-nat = {
                  family = "ip";
                  content = ''
                    chain postrouting {
                      type nat hook postrouting priority srcnat; policy accept;
                      ip saddr 5.9.109.0/27 ip daddr 10.0.0.2 masquerade
                    }
                  '';
                };
              };
            };

            iproute2.enable = true;

            nat = {
              enable = true;
              enableIPv6 = true;
              externalInterface = "ens3";
              internalInterfaces = ["ipsec0"];
              internalIPs = ["5.9.109.0/27" "10.0.0.0/24"];

              forwardPorts =
                (map (port: mkForward port "tcp") [
                  80
                  443
                  445
                  5555
                  2222
                  6001
                  20411
                  25565
                ])
                ++ (map (port: mkForward port "udp") [
                  443
                ])
                ++ [
                  {
                    destination = "10.0.0.2:26000-27000";
                    sourcePort = "26000:27000";
                    proto = "tcp";
                    loopbackIPs = ["95.135.208.17"];
                  }
                  {
                    destination = "10.0.0.2:26000-27000";
                    sourcePort = "26000:27000";
                    proto = "udp";
                    loopbackIPs = ["95.135.208.17"];
                  }
                ];
            };
          };

          systemd.network = {
            networks = {
              "10-ens3" = {
                matchConfig.Name = "ens3";
                address = ["95.135.208.17/24" "2a12:bec4:1821:61f::a/64"];
                gateway = ["95.135.208.1"];
                routes = [
                  {
                    Destination = "::/0";
                    Gateway = "2a12:bec4:1821::";
                    GatewayOnLink = true;
                    Metric = 1024;
                  }
                ];
                xfrm = ["ipsec0"];
                linkConfig.RequiredForOnline = "routable";
              };

              "20-ipsec0" = {
                matchConfig.Name = "ipsec0";
                address = ["10.0.0.1/24" "fd00:1337::1/64"];
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

            package = pkgs.caddy.withPlugins {
              plugins = ["github.com/mholt/caddy-l4@v0.1.0"];
              hash = "sha256-Q3Og34QO9Zbecf5jZCj+cr8riGW4/T44uJcRc3gU5aE=";
            };

            globalConfig = ''
              layer4 {
                :20269 {
                  route {
                    proxy {
                      upstream 144.31.167.137:25585
                      proxy_protocol v2
                    }
                  }
                }

                udp/:20269 {
                  route {
                    proxy udp/144.31.167.137:25585
                  }
                }
              }
            '';
          };
        })
      ];
  };
}
