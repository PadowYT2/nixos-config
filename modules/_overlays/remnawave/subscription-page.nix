{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.remnawave.subscription-page;

  remnawaveSubpageStart = pkgs.writeShellApplication {
    name = "remnawave-subscription-page-start";
    text = ''
      ${
        if cfg.apiTokenFile != null
        then ''
          REMNAWAVE_API_TOKEN="$(< ${lib.escapeShellArg cfg.apiTokenFile})"
          export REMNAWAVE_API_TOKEN
        ''
        else ''
          export REMNAWAVE_API_TOKEN=${lib.escapeShellArg cfg.apiToken}
        ''
      }

      exec ${cfg.package}/bin/remnawave-subscription-page
    '';
  };
in {
  options.services.remnawave.subscription-page = {
    enable = lib.mkEnableOption "Remnawave Subscription Page";

    package = lib.mkPackageOption pkgs ["remnawave" "subscription-page"] {};

    user = lib.mkOption {
      type = lib.types.str;
      default = "remnawave-subpage";
      description = "User to run Remnawave Subscription Page as";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "remnawave-subpage";
      description = "Group to run Remnawave Subscription Page as";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3010;
      description = "Port to listen on";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to open the port in the firewall";
    };

    panelUrl = lib.mkOption {
      type = lib.types.str;
      example = "https://panel.example.com";
      description = "Base URL of Remnawave Panel";
    };

    apiToken = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Raw API token string from Remnawave Panel";
    };

    apiTokenFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to file containing API token";
    };

    customSubPrefix = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/sub";
      description = "Custom URL prefix for subscription routes";
    };

    environment = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional environment variables";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.apiToken == null || cfg.apiTokenFile == null;
        message = "cannot set both services.remnawave.subscription-page.apiToken and services.remnawave.subscription-page.apiTokenFile";
      }
      {
        assertion = cfg.apiToken != null || cfg.apiTokenFile != null;
        message = "must set either services.remnawave.subscription-page.apiToken or services.remnawave.subscription-page.apiTokenFile";
      }
    ];

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [cfg.port];

    systemd.services.remnawave-subscription-page = {
      description = "Remnawave Subscription Page";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      wants = ["network-online.target"];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        ExecStart = lib.getExe remnawaveSubpageStart;
        WorkingDirectory = "${cfg.package}/share/remnawave-subscription-page";
        Environment =
          [
            "NODE_ENV=production"
            "APP_PORT=${toString cfg.port}"
            "REMNAWAVE_PANEL_URL=${cfg.panelUrl}"
            "INTERNAL_JWT_SECRET=remnawave-subpage-internal-session-secret"
          ]
          ++ lib.optional (cfg.customSubPrefix != null) "CUSTOM_SUB_PREFIX=${cfg.customSubPrefix}"
          ++ cfg.environment;
        Restart = "on-failure";
      };
    };

    users.users = lib.mkIf (cfg.user == "remnawave-subpage") {
      ${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
      };
    };

    users.groups = lib.mkIf (cfg.group == "remnawave-subpage") {
      ${cfg.group} = {};
    };
  };
}
