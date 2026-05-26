{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.noctis = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        remotebuild
        "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
      ]
      ++ map (name: ./_modules + "/${name}") (builtins.attrNames (builtins.readDir ./_modules))
      ++ [
        ({keys, ...}: {
          system.stateVersion = "26.05";

          nixpkgs.hostPlatform = "aarch64-linux";

          boot = {
            initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "virtio_scsi" "usbhid"];
          };

          disko.devices = {
            disk.main = {
              device = "/dev/disk/by-id/scsi-36080de25ca00484b934951069174a17d";
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

          networking.hostName = "noctis";

          systemd.network = {
            networks."10-ens3" = {
              matchConfig.Name = "ens3";
              address = ["10.0.0.2/24" "2603:c020:8026:6800::a/64"];
              routes = [
                {
                  Destination = "0.0.0.0/0";
                  Gateway = "10.0.0.1";
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
              matchConfig.MACAddress = "02:00:17:19:9C:6C";
              linkConfig = {
                Name = "ens3";
                MACAddressPolicy = "persistent";
              };
            };
          };

          services.caddy = {
            enable = true;
            openFirewall = true;

            globalConfig = ''
              servers {
                trusted_proxies static private_ranges
              }
            '';
          };

          users.users.root.openssh.authorizedKeys.keys = [keys.djoh];
        })
      ];
  };
}
