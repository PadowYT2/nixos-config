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
      ++ map (name: ./_modules + "/${name}") (builtins.attrNames (builtins.readDir ./_modules))
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
            firewall = {
              allowedTCPPorts = [8192 20436 24454 25600];
              allowedTCPPortRanges = [
                {
                  from = 25570;
                  to = 25575;
                }
                {
                  from = 25580;
                  to = 25585;
                }
              ];
              allowedUDPPorts = [8192 20436 24454 25600];
              allowedUDPPortRanges = [
                {
                  from = 25570;
                  to = 25575;
                }
                {
                  from = 25580;
                  to = 25585;
                }
              ];
            };
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

          services.caddy = {
            enable = true;
            openFirewall = true;

            globalConfig = ''
              servers {
                trusted_proxies static private_ranges
              }
            '';

            virtualHosts = {
              "http://cdn.magmamc.org:25575".extraConfig = ''
                reverse_proxy http://5.83.140.166:25575
              '';
            };
          };

          virtualisation.docker = {
            enable = true;
            daemon.settings = {
              default-cgroupns-mode = "private";
              exec-opts = ["native.cgroupdriver=systemd"];
            };
          };

          services.openssh.settings.PermitRootLogin = "yes";
          users.users.root.hashedPassword = "$y$j9T$OuUrUFjqMr7ryHiP1lEs2.$TK8itnRu/FesWZGJPdvA0qYeWZOmkFR4YwQQfXPw769";
        }
      ];
  };
}
