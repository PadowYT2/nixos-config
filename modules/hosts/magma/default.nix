{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.magma = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
      ]
      ++ [
        {
          system.stateVersion = "26.05";

          boot = {
            initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "ahci" "sr_mod" "virtio_blk"];
            kernelModules = ["kvm-amd"];
            loader = {
              efi.canTouchEfiVariables = false;
              grub = {
                devices = ["nodev"];
                efiInstallAsRemovable = true;
              };
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
            hostName = "magma";
            enableIPv6 = false;
          };

          systemd.network.networks."10-ens3" = {
            matchConfig.Name = "ens3";
            address = ["5.83.140.166/32"];
            routes = [
              {
                Destination = "10.0.0.1/32";
                Scope = "link";
              }
              {
                Destination = "0.0.0.0/0";
                Gateway = "10.0.0.1";
                GatewayOnLink = true;
              }
            ];
            linkConfig.RequiredForOnline = "routable";
          };

          users.users.root.hashedPassword = "$y$j9T$AXEaCIfhaJHlBTK57bFcE1$C8yWgyNnz3/SuG20ZPWDjF/MrDRn/VhHHKykk.JEjW8";
        }
      ];
  };
}
