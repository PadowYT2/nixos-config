{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.flopux = inputs.nixpkgs.lib.nixosSystem {
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

          networking = {
            hostName = "flopux";
            enableIPv6 = false;
          };

          systemd.network.networks = {
            "10-ens3" = {
              matchConfig.Name = "ens3";
              address = ["185.205.194.15/24"];
              gateway = ["185.205.194.1"];
              linkConfig.RequiredForOnline = "routable";
            };
          };

          services.caddy = {
            enable = true;
            openFirewall = true;
          };

          programs.git.config.user = {
            name = "Flop4ik";
            email = "avl2010503@gmail.com";
          };

          users.users.root.openssh.authorizedKeys.keys = [keys.flop4ik];
        })
      ];
  };
}
