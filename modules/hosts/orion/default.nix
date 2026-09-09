{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.orion = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        remotebuild
        "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
      ]
      ++ [
        {
          system.stateVersion = "26.05";

          boot = {
            initrd.availableKernelModules = ["uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod"];
            kernelModules = ["tcp_bbr"];
            kernel.sysctl = {
              "net.core.default_qdisc" = "fq";
              "net.ipv4.tcp_congestion_control" = "bbr";
              "net.ipv4.tcp_mtu_probing" = 1;
              "net.ipv4.tcp_fastopen" = 1;
              "net.core.rmem_max" = 16777216;
              "net.core.wmem_max" = 16777216;
              "net.ipv4.tcp_rmem" = "4096 87380 16777216";
              "net.ipv4.tcp_wmem" = "4096 65536 16777216";
              "net.core.somaxconn" = 8192;
              "net.core.netdev_max_backlog" = 10000;
            };
          };

          disko.devices = {
            disk.main = {
              device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
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

          networking.hostName = "orion";

          systemd.network = {
            networks."10-ens3" = {
              matchConfig.Name = "ens3";
              address = ["78.142.195.194/32" "2a0c:59c0:12::f6/128"];
              routes = [
                {
                  Destination = "0.0.0.0/0";
                  Gateway = "172.31.1.1";
                  GatewayOnLink = true;
                }
                {
                  Destination = "::/0";
                  Gateway = "fe80::1";
                  GatewayOnLink = true;
                  Metric = 1024;
                }
              ];
              linkConfig.RequiredForOnline = "routable";
            };

            links."10-ens3" = {
              matchConfig.MACAddress = "A4:AA:34:E0:28:AD";
              linkConfig = {
                Name = "ens3";
                MACAddressPolicy = "persistent";
              };
            };
          };
        }
      ];
  };
}
