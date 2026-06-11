{
  programs = {
    zed-editor = {
      enable = true;

      extensions = [
        "biome"
        "caddyfile"
        "color-highlight"
        "comment"
        "dart"
        "editorconfig"
        "env"
        "html"
        "import-cost-lsp"
        "java"
        "kotlin"
        "laravel"
        "markdown-oxide"
        "material-icon-theme"
        "mdx"
        "nix"
        "php"
        "tokyo-night-dark"
        "toml"
        "wakatime"
      ];

      userSettings = {
        hover_popover_delay = 400;
        semantic_tokens = "combined";
        document_folding_ranges = "on";
        document_symbols = "on";
        inline_code_actions = true;
        centered_layout = {
          right_padding = 0.2;
          left_padding = 0.2;
        };
        tab_size = 4;
        gutter = {
          folds = true;
          bookmarks = false;
          breakpoints = false;
          runnables = false;
          min_line_number_digits = 3;
          line_numbers = true;
        };
        auto_indent = "syntax_aware";
        indent_guides = {
          line_width = 1;
          active_line_width = 1;
          background_coloring = "indent_aware";
          coloring = "fixed";
        };
        scrollbar = {
          diagnostics = "all";
          git_diff = true;
          search_results = true;
          selected_text = true;
          selected_symbol = true;
          axes = {
            vertical = true;
            horizontal = true;
          };
          cursors = true;
        };
        ui_font_family = "Monocraft";
        disable_ai = true;
        agent = {
          button = false;
        };
        collaboration_panel = {
          button = false;
        };
        git_panel = {
          tree_view = true;
          status_style = "icon";
          default_width = 448;
          dock = "right";
        };
        outline_panel = {
          indent_size = 20;
          button = false;
        };
        project_panel = {
          git_status_indicator = true;
          show_diagnostics = "errors";
          sort_mode = "directories_first";
          hide_root = false;
          sticky_scroll = false;
          bold_folder_labels = false;
          indent_size = 20;
          git_status = true;
          folder_icons = true;
          file_icons = true;
          entry_spacing = "standard";
          default_width = 320;
          dock = "left";
        };
        bottom_dock_layout = "contained";
        tabs = {
          show_close_button = "hover";
          file_icons = true;
          close_position = "right";
          git_status = true;
        };
        tab_bar = {
          show_pinned_tabs_in_separate_row = false;
          show_nav_history_buttons = false;
          show_tab_bar_buttons = true;
          show = true;
        };
        title_bar = {
          button_layout = "platform_default";
          show_menus = false;
          show_user_picture = true;
          show_user_menu = true;
          show_sign_in = true;
          show_onboarding_banner = true;
          show_project_items = true;
          show_branch_name = true;
          show_branch_status_icon = false;
        };
        debugger = {
          button = false;
        };
        search = {
          button = true;
        };
        diagnostics = {
          inline = {
            padding = 4;
          };
          button = true;
        };
        status_bar = {
          show_active_file = false;
          active_language_button = true;
          cursor_position_button = true;
          line_endings_button = true;
        };
        middle_click_paste = false;
        inlay_hints = {
          enabled = false;
        };
        completions = {
          words = "fallback";
        };
        show_whitespaces = "selection";
        line_ending = "prefer_lf";
        preferred_line_length = 80;
        toolbar = {
          breadcrumbs = true;
          agent_review = false;
          code_actions = false;
          quick_actions = true;
        };
        minimap = {
          current_line_highlight = "none";
          max_width_columns = 80;
          thumb = "always";
          show = "always";
        };
        which_key = {
          delay_ms = 200;
        };
        show_wrap_guides = true;
        text_rendering_mode = "platform_default";
        agent_ui_font_size = 16;
        buffer_line_height = "standard";
        buffer_font_weight = 400;
        icon_theme = "Material Icon Theme";
        auto_update = false;
        redact_private_values = false;
        session = {
          trust_all_worktrees = true;
        };
        terminal = {
          font_size = 14;
          toolbar = {
            breadcrumbs = false;
          };
          scroll_multiplier = 1;
          show_count_badge = false;
          flexible = true;
          dock = "bottom";
          button = true;
          max_scroll_history_lines = 100000;
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        node = {
          npm_path = "bun";
        };
        git = {
          inline_blame = {
            enabled = true;
          };
        };
        base_keymap = "VSCode";
        preview_tabs = {
          enabled = false;
        };
        sticky_scroll = {
          enabled = false;
        };
        cursor_blink = true;
        buffer_font_family = "Monocraft";
        ui_font_size = 15;
        buffer_font_size = 15;
        theme = "Tokyo Night Dark";
        lsp = {
          nixd = {
            initialization_options = {
              formatting = {
                command = ["alejandra" "--quiet" "--"];
              };
            };
          };
          biome = {
            settings = {
              require_config_file = true;
            };
          };
          tailwindcss-language-server = {
            settings = {
              classFunctions = ["cn" "cva" "clsx"];
            };
          };
        };
        languages = {
          YAML.tab_size = 2;
          Nix = {
            tab_size = 2;
            language_servers = ["nixd"];
            formatter.external = {
              command = "alejandra";
              arguments = ["--quiet" "--"];
            };
          };
          CSS.formatter.language_server.name = "biome";
          HTML.formatter.language_server.name = "biome";
          JSON.formatter.language_server.name = "biome";
          JSONC.formatter.language_server.name = "biome";
          JavaScript.formatter.language_server.name = "biome";
          TSX.formatter.language_server.name = "biome";
          TypeScript.formatter.language_server.name = "biome";
        };
        "experimental.theme_overrides".accents = ["#848426" "#448446" "#844486" "#2C7B7C"];
      };

      userKeymaps = [
        {
          context = "Pane";
          bindings = {
            "ctrl-tab" = "pane::ActivateNextItem";
            "ctrl-shift-tab" = "pane::ActivatePreviousItem";
          };
        }
      ];
    };

    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        font-family = "Monocraft";
      };
    };
  };
}
