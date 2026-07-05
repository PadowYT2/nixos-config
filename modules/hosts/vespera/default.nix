{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.vespera = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = with self.nixosModules;
      [
        common
        inputs.home-manager.nixosModules.home-manager
        "${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
      ]
      ++ builtins.filter builtins.pathExists (
        map (name: ./_modules + "/${name}/default.nix") (builtins.attrNames (builtins.readDir ./_modules))
      )
      ++ [
        ({
          config,
          keys,
          lib,
          pkgs,
          ...
        }: {
          system.stateVersion = "26.05";

          boot = {
            kernelPackages = pkgs.linuxPackages_latest;
            initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sr_mod"];
            kernelModules = ["kvm-amd"];
            kernelParams = ["amd_pstate=active"];
            supportedFilesystems = ["ntfs-3g"];
          };

          hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

          disko.devices.disk = {
            linux = {
              device = "/dev/disk/by-id/nvme-G932E_512G_YCSW004982T";
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    size = "1G";
                    type = "EF00";
                    label = "vespera-boot";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      extraArgs = ["-n" "NIXBOOT"];
                      mountpoint = "/boot";
                      mountOptions = ["fmask=0077" "dmask=0077"];
                    };
                  };

                  swap = {
                    size = "16G";
                    content = {
                      type = "swap";
                      discardPolicy = "both";
                    };
                  };

                  root = {
                    size = "100%";
                    label = "vespera-root";
                    content = {
                      type = "btrfs";
                      extraArgs = ["-f" "-L" "nixos"];
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                  };
                };
              };
            };
          };

          networking = {
            hostName = "vespera";
            useNetworkd = false;
            hosts = {
              "127.0.0.1" = ["wayclip.test" "api.wayclip.test"];
              "::1" = ["wayclip.test" "api.wayclip.test"];
            };
          };

          systemd.network.enable = false;

          time.timeZone = "Europe/Moscow";

          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.vespera = {
              home = {
                username = "vespera";
                homeDirectory = "/home/vespera";
                stateVersion = "26.05";
              };

              imports = builtins.filter builtins.pathExists (
                map (name: ./_modules + "/${name}/home.nix") (builtins.attrNames (builtins.readDir ./_modules))
              );
            };
          };

          services.printing.enable = true;

          programs = {
            nh.flake = "/home/vespera/nixos-config";

            appimage = {
              enable = true;
              binfmt = true;
            };

            localsend.enable = true;
            nix-ld.enable = true;

            java = {
              enable = true;
              binfmt = true;
              package = pkgs.temurin-bin-25;
            };

            git.config.user.signingkey = "/home/vespera/.ssh/id_padow.pub";
          };

          environment = {
            systemPackages = with pkgs; [
              ayugram-desktop
              showtime
              (callPackage ../../../packages/davinci-resolve-studio {})
              gradia
              libreoffice
              hunspell
              hunspellDicts.en_US
              hunspellDicts.ru_RU
              rustdesk-flutter
              blockbench
              scrcpy
              android-tools
              constrict
              decibels
              qalculate-gtk
              gnome-calendar
              snapshot
              gnome-clocks
              gnome-contacts
              gnome-disk-utility
              simple-scan
              papers
              nautilus
              gnome-font-viewer
              loupe
              audio-sharing
              binary
              curtail
              gnome-decoder
              dialect
              eyedropper
              resources
              shortwave
              switcheroo
              valuta
              file-roller
              lenspect
              ghex
              nixd
              devenv
              bun
              nodejs_24
            ];

            sessionVariables.RULES = "/home/vespera/nixos-config/modules/_secrets.nix";
          };

          users.users.vespera = {
            isNormalUser = true;
            description = "vespera";
            hashedPassword = "$y$j9T$bp8.7vS.MnKujoF60pBKD1$XQdbmd1Y/Ad84mFNVmntMmwFIQdZ.s9m.JXknDnQbb9";
            extraGroups = ["networkmanager" "wheel"];
            openssh.authorizedKeys.keys = with keys; [zorin phone padow];
          };

          nix.settings.trusted-users = ["vespera"];

          age.identityPaths = ["/home/vespera/.ssh/id_ed25519"];
        })
      ];
  };
}
