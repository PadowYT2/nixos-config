{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.padow = inputs.nixpkgs.lib.nixosSystem {
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
            initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
            kernelModules = ["kvm-amd"];
            supportedFilesystems = ["ntfs-3g"];
          };

          hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

          disko.devices.disk = {
            linux = {
              device = "/dev/disk/by-id/ata-ADATA_SU800_2K4529A62C1J";
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    size = "1G";
                    type = "EF00";
                    label = "padow-boot";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      extraArgs = ["-n" "NIXBOOT"];
                      mountpoint = "/boot";
                      mountOptions = ["fmask=0077" "dmask=0077"];
                    };
                  };

                  root = {
                    size = "100%";
                    label = "padow-root";
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

            windows = {
              device = "/dev/disk/by-id/ata-ADATA_SU800_2M3429ADE7Y1";
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    size = "1G";
                    type = "EF00";
                    label = "windows-esp";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      extraArgs = ["-n" "WINESP"];
                    };
                  };

                  MSR = {
                    size = "16M";
                    type = "0C01";
                    label = "windows-msr";
                  };

                  windows = {
                    size = "40G";
                    type = "0700";
                    label = "windows";
                    content = {
                      type = "filesystem";
                      format = "ntfs";
                      extraArgs = ["-f" "-L" "Windows"];
                      preCreateHook = ''
                        export PATH=${lib.makeBinPath [pkgs.ntfs3g]}:$PATH
                      '';
                    };
                  };

                  storage = {
                    size = "100%";
                    type = "0700";
                    label = "storage-hot";
                    content = {
                      type = "filesystem";
                      format = "ntfs";
                      extraArgs = ["-f" "-L" "storage-hot"];
                      preCreateHook = ''
                        export PATH=${lib.makeBinPath [pkgs.ntfs3g]}:$PATH
                      '';
                    };
                  };
                };
              };
            };

            hdd = {
              device = "/dev/disk/by-id/ata-WDC_WD10EZEX-22MFCA0_WD-WCC6Y2VUZAS8";
              type = "disk";
              content = {
                type = "gpt";
                partitions.storage = {
                  size = "100%";
                  type = "0700";
                  label = "storage-cold";
                  content = {
                    type = "filesystem";
                    format = "ntfs";
                    extraArgs = ["-f" "-L" "storage-cold"];
                    preCreateHook = ''
                      export PATH=${lib.makeBinPath [pkgs.ntfs3g]}:$PATH
                    '';
                  };
                };
              };
            };
          };

          networking = {
            hostName = "padow";
            useNetworkd = false;
          };

          systemd.network.enable = false;

          time.timeZone = "Europe/Moscow";

          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.padow = {
              home = {
                username = "padow";
                homeDirectory = "/home/padow";
                stateVersion = "26.05";
              };

              imports = builtins.filter builtins.pathExists (
                map (name: ./_modules + "/${name}/home.nix") (builtins.attrNames (builtins.readDir ./_modules))
              );
            };
          };

          services.printing.enable = true;

          programs = {
            nh.flake = "/home/padow/nixos-config";

            appimage = {
              enable = true;
              binfmt = true;
            };

            ente-auth.enable = true;
            localsend.enable = true;
            nix-ld.enable = true;

            java = {
              enable = true;
              binfmt = true;
              package = pkgs.temurin-bin-25;
            };

            git.config.user.signingkey = "/home/padow/.ssh/id_ed25519.pub";
          };

          environment = {
            systemPackages = with pkgs; [
              ayugram-desktop
              cinny-desktop
              showtime
              davinci-resolve
              gradia
              libreoffice
              hunspell
              hunspellDicts.en_US
              hunspellDicts.ru_RU
              keyguard
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
              ghex
              nixd
              bun
              nodejs_24
            ];

            sessionVariables.RULES = "/home/padow/nixos-config/modules/_secrets.nix";
          };

          users.users.padow = {
            isNormalUser = true;
            description = "padow";
            hashedPassword = "$y$j9T$U0pnVGJ8bEotT2ymA.XrY.$JfN56sQqFzo0lPAJXRvX6WQ5HmLmmsbKACDHGFB/CqD";
            extraGroups = ["networkmanager" "wheel"];
            openssh.authorizedKeys.keys = with keys; [zorin phone padow];
          };

          age.identityPaths = ["/home/padow/.ssh/id_ed25519"];
        })
      ];
  };
}
