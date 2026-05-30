{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.remnawave.node;

  env = lib.filterAttrs (n: v: v != null) {
    SUPERVISORD_USER =
      if cfg.supervisordUserFile != null
      then "@SUPERVISORD_USER@"
      else cfg.supervisordUser;
    SUPERVISORD_PASSWORD =
      if cfg.supervisordPasswordFile != null
      then "@SUPERVISORD_PASSWORD@"
      else cfg.supervisordPassword;
    INTERNAL_REST_TOKEN =
      if cfg.internalRestTokenFile != null
      then "@INTERNAL_REST_TOKEN@"
      else cfg.internalRestToken;
    SECRET_KEY =
      if cfg.secretKeyFile != null
      then "@SECRET_KEY@"
      else cfg.secretKey;
  };

  setupScript = pkgs.writeShellApplication {
    name = "remnawave-node-setup";
    runtimeInputs = with pkgs; [coreutils replace-secret];
    text = ''
      install -Dm640 -o ${cfg.user} -g ${cfg.group} \
        ${pkgs.writeText "remnawave-node.env" (lib.generators.toKeyValue {} env)} \
        /var/lib/remnawave-node/node.env

      ${lib.optionalString (cfg.supervisordUserFile != null) ''
        replace-secret '@SUPERVISORD_USER@' ${lib.escapeShellArg cfg.supervisordUserFile} /var/lib/remnawave-node/node.env
      ''}

      ${lib.optionalString (cfg.supervisordPasswordFile != null) ''
        replace-secret '@SUPERVISORD_PASSWORD@' ${lib.escapeShellArg cfg.supervisordPasswordFile} /var/lib/remnawave-node/node.env
      ''}

      ${lib.optionalString (cfg.internalRestTokenFile != null) ''
        replace-secret '@INTERNAL_REST_TOKEN@' ${lib.escapeShellArg cfg.internalRestTokenFile} /var/lib/remnawave-node/node.env
      ''}

      ${lib.optionalString (cfg.secretKeyFile != null) ''
        replace-secret '@SECRET_KEY@' ${lib.escapeShellArg cfg.secretKeyFile} /var/lib/remnawave-node/node.env
      ''}
    '';
  };

  remmawaveNodeCli = pkgs.writeShellApplication {
    name = "remnawave-node-cli";
    text = ''
      exec ${cfg.package}/bin/remnawave-node-cli "$@"
    '';
  };

  cfgService = {
    User = cfg.user;
    Group = cfg.group;
    StateDirectory = "remnawave-node";
    LogsDirectory = "remnawave-node";
    RuntimeDirectory = "remnawave-node";
  };
in {
  options.services.remnawave.node = {
    enable = lib.mkEnableOption "Remnawave Node service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.remnawave.node.override {user = cfg.user;};
      defaultText = "pkgs.remnawave.node";
      description = "The Remnawave Node package to use";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "remnawave-node";
      description = "User to run Remnawave Node as";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "remnawave-node";
      description = "Group to run Remnawave Node as";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to open the node port in the firewall";
    };

    secretKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The SECRET_KEY from the Remnawave panel";
    };

    secretKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a file containing the SECRET_KEY";
    };

    supervisordUser = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Username for the supervisord HTTP API";
    };

    supervisordUserFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a file containing the supervisord username";
    };

    supervisordPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Password for the supervisord HTTP API";
    };

    supervisordPasswordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a file containing the supervisord password";
    };

    internalRestToken = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Token for the internal REST API between the node and Xray";
    };

    internalRestTokenFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a file containing the internal REST token";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 2222;
      description = "Port for the node API";
    };

    xtlsApiPort = lib.mkOption {
      type = lib.types.port;
      default = 61000;
      description = "Port for the XTLS (Xray) gRPC API";
    };

    environment = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional environment variables to pass to the service";
      example = ["XTLS_API_PORT=61000"];
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.secretKey == null || cfg.secretKeyFile == null;
        message = "cannot set both services.remnawave.node.secretKey and services.remnawave.node.secretKeyFile";
      }
      {
        assertion = cfg.secretKey != null || cfg.secretKeyFile != null;
        message = "must set either services.remnawave.node.secretKey or services.remnawave.node.secretKeyFile";
      }
      {
        assertion = cfg.supervisordUser == null || cfg.supervisordUserFile == null;
        message = "cannot set both services.remnawave.node.supervisordUser and services.remnawave.node.supervisordUserFile";
      }
      {
        assertion = cfg.supervisordUser != null || cfg.supervisordUserFile != null;
        message = "must set either services.remnawave.node.supervisordUser or services.remnawave.node.supervisordUserFile";
      }
      {
        assertion = cfg.supervisordPassword == null || cfg.supervisordPasswordFile == null;
        message = "cannot set both services.remnawave.node.supervisordPassword and services.remnawave.node.supervisordPasswordFile";
      }
      {
        assertion = cfg.supervisordPassword != null || cfg.supervisordPasswordFile != null;
        message = "must set either services.remnawave.node.supervisordPassword or services.remnawave.node.supervisordPasswordFile";
      }
      {
        assertion = cfg.internalRestToken == null || cfg.internalRestTokenFile == null;
        message = "cannot set both services.remnawave.node.internalRestToken and services.remnawave.node.internalRestTokenFile";
      }
      {
        assertion = cfg.internalRestToken != null || cfg.internalRestTokenFile != null;
        message = "must set either services.remnawave.node.internalRestToken or services.remnawave.node.internalRestTokenFile";
      }
    ];

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [cfg.port];

    systemd.services.remnawave-node-setup = {
      description = "Remnawave Node setup";
      requiredBy = ["remnawave-node-supervisor.service" "remnawave-node.service"];
      before = ["remnawave-node-supervisor.service" "remnawave-node.service"];
      restartTriggers = [cfg.package];

      serviceConfig =
        cfgService
        // {
          Type = "oneshot";
          ExecStart = lib.getExe setupScript;
          RemainAfterExit = true;
        };
    };

    systemd.services.remnawave-node-supervisor = {
      description = "Remnawave Node Supervisor";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target" "remnawave-node-setup.service"];
      wants = ["network-online.target"];
      requires = ["remnawave-node-setup.service"];

      serviceConfig =
        cfgService
        // {
          Type = "simple";
          ExecStart = "${pkgs.python3Packages.supervisor}/bin/supervisord -c ${cfg.package}/share/remnawave-node/supervisord.conf";
          EnvironmentFile = "/var/lib/remnawave-node/node.env";
          Environment = [
            "INTERNAL_SOCKET_PATH=/run/remnawave-node/internal.sock"
            "SUPERVISORD_SOCKET_PATH=/run/remnawave-node/supervisord.sock"
            "SUPERVISORD_PID_PATH=/run/remnawave-node/supervisord.pid"
          ];
          Restart = "on-failure";
          AmbientCapabilities = "CAP_NET_BIND_SERVICE";
        };
    };

    systemd.services.remnawave-node = {
      description = "Remnawave Node service";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target" "remnawave-node-setup.service" "remnawave-node-supervisor.service"];
      wants = ["network-online.target"];
      requires = ["remnawave-node-setup.service" "remnawave-node-supervisor.service"];

      serviceConfig =
        cfgService
        // {
          ExecStart = "${cfg.package}/bin/remnawave-node";
          WorkingDirectory = "${cfg.package}/share/remnawave-node";
          EnvironmentFile = "/var/lib/remnawave-node/node.env";
          Environment =
            [
              "NODE_ENV=production"
              "NODE_PORT=${toString cfg.port}"
              "XTLS_API_PORT=${toString cfg.xtlsApiPort}"
              "XRAY_CORE_VERSION=${pkgs.xray.version}"
              "INTERNAL_SOCKET_PATH=/run/remnawave-node/internal.sock"
              "SUPERVISORD_SOCKET_PATH=/run/remnawave-node/supervisord.sock"
              "SUPERVISORD_PID_PATH=/run/remnawave-node/supervisord.pid"
            ]
            ++ cfg.environment;
          Restart = "on-failure";
          AmbientCapabilities = ["CAP_NET_BIND_SERVICE" "CAP_NET_ADMIN"];
        };
    };

    environment.systemPackages = [remmawaveNodeCli];

    users.users = lib.mkIf (cfg.user == "remnawave-node") {
      ${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
      };
    };

    users.groups = lib.mkIf (cfg.group == "remnawave-node") {
      ${cfg.group} = {};
    };
  };
}
