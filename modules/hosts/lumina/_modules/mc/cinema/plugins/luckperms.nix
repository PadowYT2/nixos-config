{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/LuckPerms.jar" = "${pkgs.fetchurl {
        url = "https://download.luckperms.net/1611/bukkit/loader/LuckPerms-Bukkit-5.5.22.jar";
        hash = "sha256-mcS0B51630AImy+MmIzTm3UI7Cu/Nrbw71sZYV7dzLI=";
      }}";
    };

    files = {
      "plugins/LuckPerms/config.yml".value = {
        server = "global";
        use-server-uuid-cache = false;
        storage-method = "yaml";
        data = {
          address = "localhost";
          database = "minecraft";
          username = "root";
          password = "";
          pool-settings = {
            maximum-pool-size = 10;
            minimum-idle = 10;
            maximum-lifetime = 1800000;
            keepalive-time = 0;
            connection-timeout = 5000;
            properties = {
              useUnicode = true;
              characterEncoding = "utf8";
            };
          };
          table-prefix = "luckperms_";
          mongodb-collection-prefix = "";
          mongodb-connection-uri = "";
        };
        split-storage = {
          enabled = false;
          methods = {
            user = "h2";
            group = "h2";
            track = "h2";
            uuid = "h2";
            log = "h2";
          };
        };
        sync-minutes = -1;
        watch-files = false;
        messaging-service = "auto";
        auto-push-updates = false;
        push-log-entries = true;
        broadcast-received-log-entries = true;
        redis = {
          enabled = false;
          address = "localhost";
          username = "";
          password = "";
        };
        nats = {
          enabled = false;
          address = "localhost";
          username = "";
          password = "";
        };
        rabbitmq = {
          enabled = false;
          address = "localhost";
          vhost = "/";
          username = "guest";
          password = "guest";
        };
        temporary-add-behaviour = "deny";
        primary-group-calculation = "parents-by-weight";
        argument-based-command-permissions = false;
        require-sender-group-membership-to-modify = false;
        log-notify = true;
        log-notify-filtered-descriptions = null;
        auto-install-translations = true;
        meta-formatting = {
          prefix = {
            format = ["highest"];
            duplicates = "first-only";
            start-spacer = "";
            middle-spacer = " ";
            end-spacer = "";
          };
          suffix = {
            format = ["highest"];
            duplicates = "first-only";
            start-spacer = "";
            middle-spacer = " ";
            end-spacer = "";
          };
        };
        inheritance-traversal-algorithm = "depth-first-pre-order";
        post-traversal-inheritance-sort = false;
        context-satisfy-mode = "at-least-one-value-per-key";
        disabled-contexts = null;
        include-global = true;
        include-global-world = true;
        apply-global-groups = true;
        apply-global-world-groups = true;
        meta-value-selection-default = "inheritance";
        meta-value-selection = null;
        apply-wildcards = true;
        apply-sponge-implicit-wildcards = false;
        apply-default-negated-permissions-before-wildcards = false;
        apply-regex = true;
        apply-shorthand = true;
        apply-bukkit-child-permissions = true;
        apply-bukkit-default-permissions = true;
        apply-bukkit-attachment-permissions = true;
        disabled-context-calculators = [];
        world-rewrite = null;
        group-weight = null;
        enable-ops = false;
        auto-op = false;
        commands-allow-op = true;
        vault-unsafe-lookups = false;
        vault-group-use-displaynames = true;
        vault-npc-group = "default";
        vault-npc-op-status = false;
        use-vault-server = false;
        vault-server = "global";
        vault-include-global = true;
        vault-ignore-world = false;
        debug-logins = false;
        allow-invalid-usernames = false;
        skip-bulkupdate-confirmation = false;
        disable-bulkupdate = false;
        prevent-primary-group-removal = false;
        update-client-command-list = true;
        register-command-list-data = true;
        resolve-command-selectors = false;
        commands-read-only-mode = {
          players = true;
          console = false;
        };
        disable-luckperms-commands = {
          players = false;
          console = false;
        };
      };

      "plugins/LuckPerms/yaml-storage/groups/admin.yml".value = {
        name = "admin";
        permissions = ["*" "weight.1"];
        parents = ["default"];
      };

      "plugins/LuckPerms/yaml-storage/users/b8cf1af3-7dea-4338-bd7d-0f09f4e9d33c.yml".value = {
        uuid = "b8cf1af3-7dea-4338-bd7d-0f09f4e9d33c";
        name = "PadowYT2";
        primary-group = "default";
        parents = ["admin"];
      };

      "plugins/LuckPerms/yaml-storage/users/f1b1cf9a-1417-48ef-a68d-c0a461c8e208.yml".value = {
        uuid = "f1b1cf9a-1417-48ef-a68d-c0a461c8e208";
        name = "kony_ogony";
        primary-group = "default";
        parents = ["admin"];
      };

      "plugins/LuckPerms/yaml-storage/users/98785c54-6b91-4c14-bd15-744813583287.yml".value = {
        uuid = "98785c54-6b91-4c14-bd15-744813583287";
        name = "YellowRun";
        primary-group = "default";
        parents = ["admin"];
      };
    };
  };
}
