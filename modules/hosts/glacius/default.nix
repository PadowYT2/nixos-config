{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.glacius = inputs.nixpkgs.lib.nixosSystem {
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
            initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "ahci" "sd_mod" "sr_mod" "virtio_blk"];
            kernelModules = ["kvm-intel"];
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

          networking.hostName = "glacius";

          systemd.network.networks."10-ens3" = {
            matchConfig.Name = "ens3";
            address = ["45.9.2.186/24" "2a12:bec4:1821:3fb::a/64"];
            gateway = ["45.9.2.1"];
            routes = [
              {
                Destination = "2a12:bec4:1821::1/128";
                Scope = "link";
              }
              {
                Destination = "::/0";
                Gateway = "2a12:bec4:1821::1";
                Metric = 1024;
              }
            ];
            linkConfig.RequiredForOnline = "routable";
          };
        }
      ];
  };
}
