{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/FastAsyncWorldEdit.jar" = "${pkgs.fetchurl {
        url = "https://jenkins.padow.ru/job/FastAsyncWorldEdit/4/artifact/worldedit-bukkit/build/libs/FastAsyncWorldEdit-Paper-2.14.1-SNAPSHOT.jar";
        hash = "sha256-R6j9j8a7RwE9hFcwO4mU2YLTfrwZ527ZNFeKXBZ4234=";
      }}";
    };

    files = {
      "plugins/FastAsyncWorldEdit/config.yml".value = {
        issues = "https://github.com/IntellectualSites/FastAsyncWorldEdit/issues";
        wiki = "https://intellectualsites.github.io/fastasyncworldedit-documentation/";
        date = "Fri Oct 30 00:00:00 UTC 2025";
        build = "https://ci.athion.net/job/FastAsyncWorldEdit/0";
        commit = "https://github.com/IntellectualSites/FastAsyncWorldEdit/commit/9a076e3";
        platform = "Bukkit";
        region-restrictions = true;
        max-memory-percent = 95;
        slower-memory-percent = 80;
        enabled-components = {
          commands = true;
          debug = false;
          snapshot-update-notifications = false;
          release-update-notifications = false;
          notify-update-ingame = false;
        };
        clipboard = {
          use-disk = true;
          compression-level = 1;
          delete-after-days = 7;
          delete-on-logout = false;
          save-clipboard-nbt-to-disk = true;
          lock-clipboard-file = false;
        };
        lighting = {
          delay-packet-sending = true;
          async = true;
          mode = 1;
          remove-first = true;
        };
        tick-limiter = {
          enabled = false;
          interval = 20;
          falling = 64;
          physics-ms = 10;
          items = 256;
        };
        web = {
          url = "https://schem.intellectualsites.com/fawe/";
          arkitektonika-backend-url = "https://api.schematic.cloud/";
          arkitektonika-download-url = "https://schematic.cloud/download/{key}";
          arkitektonika-delete-url = "https://schematic.cloud/delete/{key}";
          max-image-load-time = 5;
          max-image-size = 8294400;
          allowed-image-hosts = ["i.imgur.com"];
        };
        extent = {
          allowed-plugins = ["com.example.ExamplePlugin"];
          debug = true;
        };
        experimental = {
          undo-batch-size = 128;
          anvil-queue-mode = false;
          dynamic-chunk-rendering = -1;
          persistent-brushes = true;
          keep-entities-in-blocks = true;
          remove-entity-from-world-on-chunk-fail = true;
          improved-entity-edits = true;
          other = false;
          allow-tick-fluids = false;
          use-vector-api = true;
        };
        queue = {
          progress = {
            display = "false";
            interval = 1;
            delay = 5000;
          };
          parallel-threads = 16;
          target-size = 256;
          extra-time-ms = 0;
          preload-chunk-count = 512;
          pool = true;
          async-chunk-load-write = true;
          thread-target-size-percent = 6;
        };
        history = {
          use-disk = true;
          use-database = true;
          combine-stages = true;
          send-before-history = true;
          compression-level = 3;
          buffer-size = 531441;
          delete-after-days = 7;
          delete-on-logout = false;
          delete-disk-on-logout = false;
          enable-for-console = true;
          store-redo = true;
          small-edits = false;
        };
        paths = {
          textures = "textures";
          heightmap = "heightmap";
          history = "history";
          clipboard = "clipboard";
          per-player-schematics = false;
        };
        region-restrictions-options = {
          mode = "MEMBER";
          allow-blacklists = false;
          exclusive-managers = ["ExamplePlugin"];
          worldguard-region-blacklist = false;
          restrict-to-safe-range = true;
        };
        general = {
          unstuck-on-generate = true;
          limit-unlimited-confirms = true;
        };
        limits = {
          default = {
            max-actions = 1;
            max-changes = 50000000;
            max-checks = 50000000;
            max-fails = 50000000;
            max-iterations = 1000;
            max-entities = 1337;
            max-radius = -1;
            max-super-pickaxe-size = 5;
            max-brush-radius = 100;
            max-butcher-radius = -1;
            max-blockstates = 1337;
            max-history-mb = -1;
            schem-file-size-limit = -1;
            schem-file-num-limit = -1;
            max-expression-ms = 50;
            speed-reduction = 0;
            fast-placement = true;
            inventory-mode = 0;
            confirm-large = true;
            restrict-history-to-regions = true;
            strip-nbt = [];
            universal-disallowed-blocks = true;
            allow-legacy = true;
            disallowed-blocks = ["minecraft:wheat" "minecraft:fire" "minecraft:redstone_wire"];
            remap-properties = [];
          };
        };
      };

      "plugins/FastAsyncWorldEdit/worldedit-config.yml".value = {
        limits = {
          max-blocks-changed = {
            default = -1;
            maximum = -1;
          };
          max-polygonal-points = {
            default = -1;
            maximum = 20;
          };
          max-radius = -1;
          max-super-pickaxe-size = 5;
          max-brush-radius = 100;
          butcher-radius = {
            default = -1;
            maximum = -1;
          };
          disallowed-blocks = ["minecraft:wheat" "minecraft:fire" "minecraft:redstone_wire"];
        };
        use-inventory = {
          enable = false;
          allow-override = true;
          creative-mode-overrides = false;
        };
        logging = {
          log-commands = false;
          file = "worldedit.log";
          format = "[%1$tY-%1$tm-%1$td %1$tH:%1$tM:%1$tS %4$s]: %5$s%6$s%n";
        };
        super-pickaxe = {
          drop-items = true;
          many-drop-items = false;
        };
        snapshots = {directory = null;};
        # navigation-wand = {
        #   item = "minecraft:compass";
        #   max-distance = 100;
        # };
        navigation-wand = -1;
        scripting = {
          timeout = 3000;
          dir = "craftscripts";
        };
        saving = {dir = "schematics";};
        files = {allow-symbolic-links = false;};
        history = {
          size = 100;
          expiration = 1000;
        };
        calculation = {timeout = 100;};
        debugging = {trace-unflushed-sessions = false;};
        wand-item = "minecraft:wooden_axe";
        shell-save-type = null;
        no-double-slash = false;
        no-op-permissions = false;
        debug = false;
        show-help-on-first-use = true;
        server-side-cui = true;
        command-block-support = false;
      };
    };
  };
}
