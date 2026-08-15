{inputs, ...}: {
  flake.nixosModules.common = {
    pkgs,
    lib,
    config,
    keys,
    ...
  }: {
    _module.args.keys = import ./_keys.nix;

    imports = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.disko
    ];

    boot.loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      grub = {
        enable = true;
        efiSupport = true;
      };
    };

    nix = {
      package = pkgs.lixPackageSets.stable.lix;
      settings.experimental-features = ["nix-command" "flakes"];
      extraOptions = ''
        extra-deprecated-features = broken-string-escape
      '';
    };

    nixpkgs = {
      config.allowUnfree = true;
      hostPlatform = lib.mkDefault "x86_64-linux";
    };

    time.timeZone = lib.mkDefault "UTC";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };

    networking = {
      nameservers = ["127.0.0.1"] ++ lib.optional config.networking.enableIPv6 "::1";
      enableIPv6 = lib.mkDefault true;
      firewall.enable = true;
      useDHCP = lib.mkDefault false;
      useNetworkd = lib.mkDefault true;
    };

    systemd.network.enable = lib.mkDefault true;

    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        listen_addresses = ["127.0.0.1:53"] ++ lib.optional config.networking.enableIPv6 "[::1]:53";
        ipv6_servers = config.networking.enableIPv6;
        dnscrypt_servers = false;
        doh_servers = true;
        require_dnssec = true;
        require_nolog = true;
        require_nofilter = true;
        http3 = true;

        server_names =
          ["cf-ipv4-primary" "cf-ipv4-fallback"]
          ++ lib.optionals config.networking.enableIPv6 ["cf-ipv6-primary" "cf-ipv6-fallback"];

        static = {
          "cf-ipv4-primary".stamp = "sdns://AgcAAAAAAAAABzEuMC4wLjEAEmRucy5jbG91ZGZsYXJlLmNvbQovZG5zLXF1ZXJ5";
          "cf-ipv4-fallback".stamp = "sdns://AgcAAAAAAAAABzEuMC4wLjEABzEuMC4wLjEKL2Rucy1xdWVyeQ";
          "cf-ipv6-primary".stamp = "sdns://AgcAAAAAAAAAFlsyNjA2OjQ3MDA6NDcwMDo6MTExMV0AGlsyNjA2OjQ3MDA6NDcwMDo6MTExMV06NDQzCi9kbnMtcXVlcnk";
          "cf-ipv6-fallback".stamp = "sdns://AgcAAAAAAAAAFlsyNjA2OjQ3MDA6NDcwMDo6MTAwMV0AGlsyNjA2OjQ3MDA6NDcwMDo6MTAwMV06NDQzCi9kbnMtcXVlcnk";
        };
      };
    };

    programs = {
      nh = {
        enable = true;
        flake = lib.mkDefault "/root/nixos-config";
      };

      zsh = {
        enable = true;
        vteIntegration = true;
        syntaxHighlighting.enable = true;
        autosuggestions = {
          enable = true;
          async = true;
        };

        shellAliases = {
          cd = "z";
          grep = "rg";
          jq = "jaq";
          ll = "eza -l --git --group-directories-first";
          ls = "eza --group-directories-first";
          man = "tldr";
          wget = "wget -c";
        };

        ohMyZsh = {
          enable = true;
          plugins = ["git"];
        };

        promptInit = ''
          setopt prompt_sp prompt_subst

          if [[ "$TERM" != "dumb" || -n "$INSIDE_EMACS" ]]; then
            PROMPT_COLOR="1;31m"
            (( UID )) && PROMPT_COLOR="1;32m"
            if [[ -n "$INSIDE_EMACS" ]]; then
              PROMPT=$'\n%{\e[$\{PROMPT_COLOR}%}[%n@%m:%~]%(#.#.$)%{\e[0m%} '
            else
              PROMPT=$'\n%{\e[$\{PROMPT_COLOR}%}[%{\e]0;%n@%m: %~\a%}%n@%m:%~]%(#.#.$)%{\e[0m%} '
            fi
            if [[ "$TERM" == "xterm" ]]; then
              PROMPT=$'%{\e]2;%m:%n:%~\a%}'"$PROMPT"
            fi
          fi
        '';

        histSize = 10000000;
        setOptions = ["INTERACTIVE_COMMENTS" "SHARE_HISTORY" "EXTENDED_HISTORY"];
      };

      bat.enable = true;
      zoxide.enable = true;

      fzf = {
        keybindings = true;
        fuzzyCompletion = true;
      };

      mtr.enable = true;
      screen.enable = true;
      tmux.enable = true;

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      git = {
        enable = true;
        lfs.enable = true;
        config = lib.mkMerge [
          {
            user = {
              name = lib.mkDefault "PadowYT2";
              email = lib.mkDefault "me@padow.dev";
            };
          }
          (lib.optionalAttrs (builtins.hasAttr config.networking.hostName keys) {
            user.signingkey = lib.mkDefault "/root/.ssh/id_ed25519.pub";
            commit.gpgsign = true;
            gpg = {
              format = "ssh";
              ssh.allowedSignersFile = pkgs.writeText "allowedSignersFile" ''
                * ${keys."${config.networking.hostName}"}
              '';
            };
          })
        ];
      };
    };

    environment = {
      systemPackages = with pkgs; [
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
        alejandra
        (
          if config.networking.hostName == "padow"
          then btop-cuda
          else btop
        )
        deadnix
        dnsutils
        eza
        fastfetch
        fd
        ffmpeg_7
        file
        fio
        fzf
        gping
        hyperfine
        iputils
        jaq
        lsof
        ncdu
        nvme-cli
        ookla-speedtest
        openssl
        (ouch.override {enableUnfree = true;})
        pciutils
        psmisc
        ripgrep
        ripgrep-all
        sd
        smartmontools
        tcpdump
        tealdeer
        traceroute
        tree
        unzip
        wget
        zip
      ];

      sessionVariables = {
        RULES = lib.mkDefault "/root/nixos-config/modules/_secrets.nix";
        NH_BYPASS_ROOT_CHECK = "true";
        BAT_THEME = "Catppuccin Mocha";
        FZF_DEFAULT_COMMAND = "rg --files --hidden --follow";
      };

      shells = with pkgs; [zsh];
    };

    services = {
      openssh = {
        enable = true;
        openFirewall = true;
      };

      redis.package = pkgs.valkey;
    };

    users = {
      defaultUserShell = pkgs.zsh;
      users.root.openssh.authorizedKeys.keys = with keys; [zorin phone padow];
    };

    security = {
      sudo-rs.enable = true;
      pam.loginLimits = [
        {
          domain = "*";
          type = "-";
          item = "nofile";
          value = "2097152";
        }
      ];
    };

    age.identityPaths = lib.mkDefault ["/root/.ssh/id_ed25519"];
  };
}
