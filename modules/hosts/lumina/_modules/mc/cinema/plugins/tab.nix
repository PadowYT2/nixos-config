{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/TAB.jar" = "${pkgs.fetchurl {
        url = "https://jenkins.padow.ru/job/TAB/3/artifact/jar/build/libs/TAB-5.3.2.jar";
        hash = "sha256-GkTN0yjIUiLmqUXjjFPd26j53KlwS6RTD4BAapfGOvA=";
      }}";
    };

    files = {
      "plugins/TAB/config.yml".value = {
        header-footer = {enabled = false;};
        tablist-name-formatting = {
          enabled = true;
          disable-condition = "";
        };
        scoreboard-teams = {enabled = false;};
        playerlist-objective = {
          enabled = true;
          value = "%ping%";
          fancy-value = "&7%ping%ms";
          title = "Ping";
          render-type = "INTEGER";
          disable-condition = "";
        };
        belowname-objective = {enabled = false;};
        prevent-spectator-effect = {enabled = false;};
        bossbar = {enabled = false;};
        scoreboard = {enabled = false;};
        layout = {enabled = false;};
        ping-spoof = {enabled = false;};
        global-playerlist = {enabled = false;};
        placeholders = {
          date-format = "dd.MM.yyyy";
          time-format = "[HH:mm:ss / h:mm a]";
          time-offset = 0;
          register-tab-expansion = false;
        };
        placeholder-output-replacements = {};
        conditions = {};
        placeholder-refresh-intervals = {
          default-refresh-interval = 500;
          "%player_ping%" = 1000;
        };
        assign-groups-by-permissions = false;
        primary-group-finding-list = ["default"];
        permission-refresh-interval = 1000;
        debug = false;
        mysql = {enabled = false;};
        proxy-support = {
          enabled = true;
          type = "PLUGIN";
          plugin = {name = "RedisBungee";};
        };
        components = {
          minimessage-support = true;
          disable-shadow-for-heads = true;
        };
        config-version = 2;
        per-world-playerlist = {enabled = false;};
        compensate-for-packetevents-bug = false;
        use-bukkit-permissions-manager = false;
        use-online-uuid-in-tablist = true;
      };

      "plugins/TAB/users.yml".value = {
        _DEFAULT_ = {tabprefix = "<head:%player%> ";};
      };
    };
  };
}
