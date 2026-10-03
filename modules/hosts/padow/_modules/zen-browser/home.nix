{inputs, ...}: {
  imports = [inputs.zen-browser.homeModules.beta];

  programs.zen-browser = {
    enable = true;

    policies.ExtensionSettings = let
      forceInstall = name: {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/${name}";
        installation_mode = "force_installed";
      };
    in {
      "{9350bc42-47fb-4598-ae0f-825e3dd9ceba}" = forceInstall "4274207/absolute_enable_right_click-1.3.9resigned1.xpi"; # Absolute Enable Right Click & Copy
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = forceInstall "5076543/bitwarden_password_manager-2026.9.3.xpi"; # Bitwarden Password Manager
      "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = forceInstall "5057371/indie_wiki_buddy-4.0.1.xpi"; # Indie Wiki Buddy
      "{eac6e624-97fa-4f28-9d24-c06c9b8aa713}" = forceInstall "5080172/material_icons_for_github-1.17.1.xpi"; # Material Icons for Github
      "@react-devtools" = forceInstall "4432990/react_devtools-6.1.1.xpi"; # React Developer Tools
      "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = forceInstall "5075070/refined_github-26.10.xpi"; # Refined GitHub
      "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = forceInstall "5012638/return_youtube_dislikes-4.0.6.xpi"; # Return YouTube Dislike
      "sponsorBlocker@ajay.app" = forceInstall "4897574/sponsorblock-6.1.7.xpi"; # SponsorBlock
      "firefox-extension@steamdb.info" = forceInstall "4967437/steam_database-4.37.xpi"; # SteamDB
      "uBlock0@raymondhill.net" = forceInstall "5034826/ublock_origin-1.75.0.xpi"; # uBlock Origin
    };

    profiles.default = {
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.newtabpage.enabled" = false;
        "mod.lean.bookmarks" = true;
        "mod.lean.bottom-buttons" = false;
        "mod.lean.hide-zoom" = false;
        "mod.lean.ninja-top-buttons" = false;
        "mod.lean.pinned-ext" = false;
        "mod.lean.pinned-ext.workspaces" = false;
        "mod.lean.show-pageactions" = false;
        "mod.lean.show-translation" = false;
        "mod.lean.top-workspace" = true;
        "privacy.clearHistory.cache" = false;
        "privacy.clearHistory.cookiesAndStorage" = false;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.clearSiteData.historyFormDataAndDownloads" = true;
        "privacy.clearSiteData.siteSettings" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "privacy.history.custom" = true;
        "privacy.sanitize.timeSpan" = 0;
        "theme-better_find_bar-enable_custom_background" = true;
        "theme.better_find_bar.custom_background" = "#121212";
        "theme.better_find_bar.hide_find_status" = false;
        "theme.better_find_bar.hide_found_matches" = false;
        "theme.better_find_bar.hide_highlight" = "not_hide";
        "theme.better_find_bar.hide_match_case" = "not_hide";
        "theme.better_find_bar.hide_match_diacritics" = "not_hide";
        "theme.better_find_bar.hide_whole_words" = "not_hide";
        "theme.better_find_bar.horizontal_position" = "default";
        "theme.better_find_bar.instant_animations" = false;
        "theme.better_find_bar.textbox_width" = "800";
        "theme.better_find_bar.transparent_background" = true;
        "theme.better_find_bar.vertical_position" = "default";
        "uc.fixcontext.applyzenaccent" = false;
        "uc.fixcontext.applyzengradient" = false;
        "uc.fixcontext.ergonomicsfortabs" = false;
        "uc.fixcontext.restoreicons" = false;
        "uc.hidecontext.bookmark" = true;
        "uc.hidecontext.closetab" = false;
        "uc.hidecontext.copylink" = true;
        "uc.hidecontext.icons" = false;
        "uc.hidecontext.image" = true;
        "uc.hidecontext.navigation" = true;
        "uc.hidecontext.pin" = true;
        "uc.hidecontext.printselection" = true;
        "uc.hidecontext.reloadtab" = true;
        "uc.hidecontext.search" = true;
        "uc.hidecontext.searchinpriv" = true;
        "uc.hidecontext.selectalltabs" = true;
        "uc.hidecontext.selectalltext" = false;
        "uc.hidecontext.separators" = false;
        "uc.hidecontext.translate" = false;
        "zen.glance.enabled" = false;
        "zen.mods.auto-update" = false;
        "zen.tabs.ctrl-tab.ignore-pending-tabs" = true;
        "zen.tabs.select-recently-used-on-close" = false;
        "zen.view.compact.enable-at-startup" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
        "zen.workspaces.hide-default-container-indicator" = false;
        "zen.workspaces.separate-essentials" = false;
      };

      mods = [
        "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
        "1e86cf37-a127-4f24-b919-d265b5ce29a0" # Lean
        "599a1599-e6ab-4749-ab22-de533860de2c" # Pimp your PiP
        "81fcd6b3-f014-4796-988f-6c3cb3874db8" # Zen Context Menu
      ];

      search = {
        force = true;
        default = "google";
      };
    };
  };
}
