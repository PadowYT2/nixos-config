{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.sol = inputs.nixpkgs.lib.nixosSystem {
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

          nixpkgs.hostPlatform = "aarch64-linux";

          boot = {
            initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "virtio_scsi" "usbhid"];
          };

          disko.devices = {
            disk.main = {
              device = "/dev/disk/by-id/scsi-360fb9f7032fd4f5b882ed0c2433fde99";
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

          networking.hostName = "sol";

          systemd.network.networks."10-ens3" = {
            matchConfig.Name = "ens3";
            address = ["92.5.24.97/32" "2603:c020:8024:d100::a/64"];
            routes = [
              {
                Destination = "92.5.24.1/32";
                Scope = "link";
              }
              {
                Destination = "0.0.0.0/0";
                Gateway = "92.5.24.1";
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
        }
      ];
  };
}
