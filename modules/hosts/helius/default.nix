{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.helius = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        remotebuild
        "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
      ]
      ++ map (name: ./_modules + "/${name}") (builtins.attrNames (builtins.readDir ./_modules))
      ++ [
        {
          system.stateVersion = "26.05";

          boot = {
            initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "ahci" "sd_mod" "sr_mod" "virtio_blk"];
            kernelModules = ["kvm-intel"];
            kernel.sysctl = {
              "net.core.default_qdisc" = "fq";
              "net.ipv4.tcp_congestion_control" = "bbr";
              "net.ipv4.tcp_fastopen" = 3;
              "net.ipv4.tcp_mtu_probing" = 1;
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

          networking.hostName = "helius";

          systemd.network.networks."10-ens3" = {
            matchConfig.Name = "ens3";
            address = ["87.229.95.109/32" "2a12:bec4:1821:46f::a/64"];
            routes = [
              {
                Destination = "87.229.95.1/32";
                Scope = "link";
              }
              {
                Destination = "0.0.0.0/0";
                Gateway = "87.229.95.1";
                GatewayOnLink = true;
              }
              {
                Destination = "::/0";
                Gateway = "2a12:bec4:1821::";
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
