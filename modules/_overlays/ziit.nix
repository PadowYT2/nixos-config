{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.ziit;

  databaseUrl =
    if cfg.database.createLocally
    then "postgresql://${cfg.database.user}@localhost/${cfg.database.name}?host=${cfg.database.host}"
    else if cfg.database.urlFile != null
    then "@DATABASE_URL@"
    else cfg.database.url;

  env =
    (lib.filterAttrs (n: v: v != null) {
      HOST = cfg.host;
      PORT = toString cfg.port;
      NUXT_BASE_URL = cfg.baseUrl;
      NUXT_DISABLE_REGISTRATION = lib.boolToString cfg.disableRegistration;
      NUXT_DATABASE_URL = databaseUrl;
      NUXT_PASETO_KEY =
        if cfg.pasetoKeyFile != null
        then "@PASETO_KEY@"
        else cfg.pasetoKey;
      NUXT_ADMIN_KEY =
        if cfg.adminKeyFile != null
        then "@ADMIN_KEY@"
        else cfg.adminKey;
      NUXT_GITHUB_CLIENT_ID =
        if cfg.github.clientIdFile != null
        then "@GITHUB_CLIENT_ID@"
        else cfg.github.clientId;
      NUXT_GITHUB_CLIENT_SECRET =
        if cfg.github.clientSecretFile != null
        then "@GITHUB_CLIENT_SECRET@"
        else cfg.github.clientSecret;
      NUXT_EPILOGUE_APP_ID =
        if cfg.epilogue.appIdFile != null
        then "@EPILOGUE_APP_ID@"
        else cfg.epilogue.appId;
      NUXT_EPILOGUE_APP_SECRET =
        if cfg.epilogue.appSecretFile != null
        then "@EPILOGUE_APP_SECRET@"
        else cfg.epilogue.appSecret;
    })
    // cfg.extraEnvironment;

  setupScript = pkgs.writeShellApplication {
    name = "ziit-setup";
    runtimeInputs = with pkgs; [coreutils replace-secret sudo];
    text = ''
      umask 077

      install -Dm640 -o ${cfg.user} -g ${cfg.group} ${pkgs.writeText "ziit.env" (lib.generators.toKeyValue {} env)} ${cfg.dataDir}/.env

      ${lib.optionalString (cfg.database.urlFile != null) ''
        replace-secret '@DATABASE_URL@' ${lib.escapeShellArg cfg.database.urlFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString (cfg.pasetoKeyFile != null) ''
        replace-secret '@PASETO_KEY@' ${lib.escapeShellArg cfg.pasetoKeyFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString (cfg.adminKeyFile != null) ''
        replace-secret '@ADMIN_KEY@' ${lib.escapeShellArg cfg.adminKeyFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString (cfg.github.clientIdFile != null) ''
        replace-secret '@GITHUB_CLIENT_ID@' ${lib.escapeShellArg cfg.github.clientIdFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString (cfg.github.clientSecretFile != null) ''
        replace-secret '@GITHUB_CLIENT_SECRET@' ${lib.escapeShellArg cfg.github.clientSecretFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString (cfg.epilogue.appIdFile != null) ''
        replace-secret '@EPILOGUE_APP_ID@' ${lib.escapeShellArg cfg.epilogue.appIdFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString (cfg.epilogue.appSecretFile != null) ''
        replace-secret '@EPILOGUE_APP_SECRET@' ${lib.escapeShellArg cfg.epilogue.appSecretFile} ${cfg.dataDir}/.env
      ''}

      ${lib.optionalString cfg.database.createLocally ''
        sudo -u postgres ${config.services.postgresql.finalPackage}/bin/psql -d ${cfg.database.name} -c "ALTER EXTENSION timescaledb UPDATE;" 2>/dev/null || true
        sudo -u postgres ${config.services.postgresql.finalPackage}/bin/psql -d ${cfg.database.name} -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;"
        sudo -u postgres ${config.services.postgresql.finalPackage}/bin/psql -d ${cfg.database.name} -c "CREATE EXTENSION IF NOT EXISTS timescaledb;"
      ''}

      set -a
      # shellcheck disable=SC1091
      source ${cfg.dataDir}/.env
      set +a

      sudo -u ${cfg.user} --preserve-env=NUXT_DATABASE_URL ${cfg.package}/bin/ziit-migrate
    '';
  };

  cfgService = {
    User = cfg.user;
    Group = cfg.group;
    WorkingDirectory = cfg.dataDir;
    StateDirectory = lib.removePrefix "/var/lib/" cfg.dataDir;
    ReadWritePaths = [cfg.dataDir];
  };
in {
  options.services.ziit = {
    enable = lib.mkEnableOption "Ziit code time tracking service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ziit;
      defaultText = "pkgs.ziit";
      description = "The Ziit package to use";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "ziit";
      description = "User to run Ziit as";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "ziit";
      description = "Group to run Ziit as";
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/ziit";
      description = "The directory where Ziit stores its data";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to open the specified port in the firewall";
    };

    host = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "The host address to bind the server to";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Port to run Ziit on";
    };

    baseUrl = lib.mkOption {
      type = lib.types.str;
      description = "The base URL of the Ziit instance (e.g., https://ziit.example.com)";
    };

    database = {
      createLocally = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to create the PostgreSQL database locally";
      };

      url = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "PostgreSQL database URL (required if createLocally is false)";
      };

      urlFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to a file containing the PostgreSQL database URL";
      };

      host = lib.mkOption {
        type = lib.types.str;
        default = "/run/postgresql";
        description = "The host of the PostgreSQL database (use socket path for local)";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 5432;
        description = "The port of the PostgreSQL database";
      };

      name = lib.mkOption {
        type = lib.types.str;
        default = "ziit";
        description = "The name of the database";
      };

      user = lib.mkOption {
        type = lib.types.str;
        default = "ziit";
        description = "The database user";
      };
    };

    pasetoKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "PASETO key for authentication. Generate with: echo k4.local.$(openssl rand -base64 32)";
    };

    pasetoKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a file containing the PASETO key";
    };

    adminKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Admin key for the admin dashboard. Generate with: openssl rand -base64 64";
    };

    adminKeyFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a file containing the admin key";
    };

    disableRegistration = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to disable user registration";
    };

    github = {
      clientId = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "GitHub OAuth client ID";
      };

      clientIdFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to a file containing the GitHub OAuth client ID";
      };

      clientSecret = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "GitHub OAuth client secret";
      };

      clientSecretFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to a file containing the GitHub OAuth client secret";
      };
    };

    epilogue = {
      appId = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Epilogue OAuth application ID";
      };

      appIdFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to a file containing the Epilogue OAuth application ID";
      };

      appSecret = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Epilogue OAuth application secret";
      };

      appSecretFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to a file containing the Epilogue OAuth application secret";
      };
    };

    extraEnvironment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra environment variables to be merged with the main environment variables";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.pasetoKey == null || cfg.pasetoKeyFile == null;
        message = "Cannot set both services.ziit.pasetoKey and services.ziit.pasetoKeyFile";
      }
      {
        assertion = cfg.pasetoKey != null || cfg.pasetoKeyFile != null;
        message = "Must set either services.ziit.pasetoKey or services.ziit.pasetoKeyFile";
      }
      {
        assertion = cfg.adminKey == null || cfg.adminKeyFile == null;
        message = "Cannot set both services.ziit.adminKey and services.ziit.adminKeyFile";
      }
      {
        assertion = cfg.adminKey != null || cfg.adminKeyFile != null;
        message = "Must set either services.ziit.adminKey or services.ziit.adminKeyFile";
      }
      {
        assertion = cfg.database.url == null || cfg.database.urlFile == null;
        message = "Cannot set both services.ziit.database.url and services.ziit.database.urlFile";
      }
      {
        assertion = cfg.database.createLocally || cfg.database.url != null || cfg.database.urlFile != null;
        message = "Must set either services.ziit.database.createLocally or provide a database URL";
      }
      {
        assertion = cfg.github.clientId == null || cfg.github.clientIdFile == null;
        message = "Cannot set both services.ziit.github.clientId and services.ziit.github.clientIdFile";
      }
      {
        assertion = cfg.github.clientSecret == null || cfg.github.clientSecretFile == null;
        message = "Cannot set both services.ziit.github.clientSecret and services.ziit.github.clientSecretFile";
      }
      {
        assertion = cfg.epilogue.appId == null || cfg.epilogue.appIdFile == null;
        message = "Cannot set both services.ziit.epilogue.appId and services.ziit.epilogue.appIdFile";
      }
      {
        assertion = cfg.epilogue.appSecret == null || cfg.epilogue.appSecretFile == null;
        message = "Cannot set both services.ziit.epilogue.appSecret and services.ziit.epilogue.appSecretFile";
      }
    ];

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [cfg.port];

    services.postgresql = lib.mkIf cfg.database.createLocally {
      enable = true;
      ensureDatabases = [cfg.database.name];
      ensureUsers = [
        {
          name = cfg.database.user;
          ensureDBOwnership = true;
        }
      ];
      extensions = exts: with exts; [timescaledb];
      settings.shared_preload_libraries = "timescaledb,pg_stat_statements";
    };

    systemd.tmpfiles.settings."10-ziit" = {
      "${cfg.dataDir}".d = {
        user = cfg.user;
        group = cfg.group;
        mode = "0750";
      };
    };

    systemd.services.ziit-setup = {
      description = "Ziit setup";
      after = lib.optionals cfg.database.createLocally ["postgresql.service"];
      requires = lib.optionals cfg.database.createLocally ["postgresql.service"];
      requiredBy = ["ziit.service"];
      before = ["ziit.service"];
      restartTriggers = [cfg.package];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = lib.getExe setupScript;
        RemainAfterExit = true;
      };
    };

    systemd.services.ziit = {
      description = "Ziit code time tracking service";
      after = ["network-online.target" "ziit-setup.service"] ++ lib.optionals cfg.database.createLocally ["postgresql.service"];
      wants = ["network-online.target"];
      requires = ["ziit-setup.service"] ++ lib.optionals cfg.database.createLocally ["postgresql.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig =
        cfgService
        // {
          ExecStart = "${cfg.package}/bin/ziit";
          Restart = "on-failure";
          EnvironmentFile = "${cfg.dataDir}/.env";
        };
    };

    users.users = lib.mkIf (cfg.user == "ziit") {
      ${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
        home = cfg.dataDir;
      };
    };

    users.groups = lib.mkIf (cfg.group == "ziit") {
      ${cfg.group} = {};
    };
  };
}
