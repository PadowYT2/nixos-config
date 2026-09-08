{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.remnawave.node;

  xrayRun = pkgs.writeShellApplication {
    name = "xray-run";
    runtimeInputs = with pkgs; [xray];
    text = ''
      exec 2>&1

      if [ -z "$INTERNAL_REST_TOKEN" ] && [ -n "$CREDENTIALS_DIRECTORY" ] && [ -f "$CREDENTIALS_DIRECTORY/INTERNAL_REST_TOKEN" ]; then
        INTERNAL_REST_TOKEN="$(< "$CREDENTIALS_DIRECTORY/INTERNAL_REST_TOKEN")"
        export INTERNAL_REST_TOKEN
      fi

      exec xray \
        -config @"$INTERNAL_SOCKET_PATH":/internal/get-config?token="$INTERNAL_REST_TOKEN" \
        -format json
    '';
  };

  remnawaveNodeStart = pkgs.writeShellApplication {
    name = "remnawave-node-start";
    text = ''
      if [ -n "$CREDENTIALS_DIRECTORY" ]; then
        if [ -f "$CREDENTIALS_DIRECTORY/SECRET_KEY" ]; then
          SECRET_KEY="$(< "$CREDENTIALS_DIRECTORY/SECRET_KEY")"
          export SECRET_KEY
        fi

        if [ -f "$CREDENTIALS_DIRECTORY/INTERNAL_REST_TOKEN" ]; then
          INTERNAL_REST_TOKEN="$(< "$CREDENTIALS_DIRECTORY/INTERNAL_REST_TOKEN")"
          export INTERNAL_REST_TOKEN
        fi
      fi

      exec ${cfg.package}/bin/remnawave-node
    '';
  };
in {
  options.services.remnawave.node = {
    enable = lib.mkEnableOption "Remnawave Node service";

    package = lib.mkPackageOption pkgs ["remnawave" "node"] {};

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
      description = "Raw SECRET_KEY string from Remnawave panel";
    };

    secretKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to file containing SECRET_KEY";
    };

    internalRestToken = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Token for internal REST API between node and Xray";
    };

    internalRestTokenFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to file containing internal REST token";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 2222;
      description = "Port for node API";
    };

    environment = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional environment variables to pass to service";
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
        assertion = cfg.internalRestToken == null || cfg.internalRestTokenFile == null;
        message = "cannot set both services.remnawave.node.internalRestToken and services.remnawave.node.internalRestTokenFile";
      }
      {
        assertion = cfg.internalRestToken != null || cfg.internalRestTokenFile != null;
        message = "must set either services.remnawave.node.internalRestToken or services.remnawave.node.internalRestTokenFile";
      }
    ];

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [cfg.port];

    systemd.tmpfiles.rules = [
      "d /run/remnawave-node 0750 ${cfg.user} ${cfg.group} -"
      "d /run/remnawave-node/xray-service 0750 ${cfg.user} ${cfg.group} -"
      "f /run/remnawave-node/xray-service/down 0640 ${cfg.user} ${cfg.group} -"
      "L+ /run/remnawave-node/xray-service/run - - - - ${lib.getExe xrayRun}"
    ];

    systemd.services.remnawave-node-supervisor = {
      description = "Remnawave Node Supervisor";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      wants = ["network-online.target"];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        Type = "simple";
        ExecStart = "${pkgs.s6}/bin/s6-supervise /run/remnawave-node/xray-service";
        LoadCredential = lib.optional (cfg.internalRestTokenFile != null) "INTERNAL_REST_TOKEN:${cfg.internalRestTokenFile}";
        Environment =
          ["INTERNAL_SOCKET_PATH=remnawave-internal"]
          ++ lib.optional (cfg.internalRestToken != null) "INTERNAL_REST_TOKEN=${cfg.internalRestToken}";
        Restart = "always";
        AmbientCapabilities = ["CAP_NET_BIND_SERVICE" "CAP_NET_ADMIN"];
      };
    };

    systemd.services.remnawave-node = {
      description = "Remnawave Node service";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target" "remnawave-node-supervisor.service"];
      wants = ["network-online.target"];
      requires = ["remnawave-node-supervisor.service"];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        ExecStart = lib.getExe remnawaveNodeStart;
        WorkingDirectory = "${cfg.package}/share/remnawave-node";
        LoadCredential =
          lib.optional (cfg.secretKeyFile != null) "SECRET_KEY:${cfg.secretKeyFile}"
          ++ lib.optional (cfg.internalRestTokenFile != null) "INTERNAL_REST_TOKEN:${cfg.internalRestTokenFile}";
        Environment =
          [
            "NODE_ENV=production"
            "NODE_PORT=${toString cfg.port}"
            "INTERNAL_SOCKET_PATH=remnawave-internal"
            "XTLS_API_SOCKET_PATH=remnawave-xtls"
            "XRAY_S6_SERVICE_DIR=/run/remnawave-node/xray-service"
          ]
          ++ lib.optional (cfg.secretKey != null) "SECRET_KEY=${cfg.secretKey}"
          ++ lib.optional (cfg.internalRestToken != null) "INTERNAL_REST_TOKEN=${cfg.internalRestToken}"
          ++ cfg.environment;
        Restart = "on-failure";
        AmbientCapabilities = ["CAP_NET_BIND_SERVICE" "CAP_NET_ADMIN"];
      };
    };

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
