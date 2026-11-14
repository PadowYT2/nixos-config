{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "biome"
      "caddyfile"
      "color-highlight"
      "comment"
      "dart"
      "editorconfig"
      "env"
      "git-firefly"
      "html"
      "import-cost-lsp"
      "java"
      "kotlin"
      "laravel"
      "make"
      "markdown-oxide"
      "material-icon-theme"
      "mdx"
      "nix"
      "php"
      "svelte"
      "tokyo-night-dark"
      "tombi"
      "toml"
      "wakatime"
    ];

    userSettings = {
      calls = {
        mute_on_join = true;
      };
      format_on_save = "on";
      cli_default_open_behavior = "new_window";
      agent = {
        button = false;
      };
      auto_indent = "syntax_aware";
      base_keymap = "VSCode";
      bottom_dock_layout = "contained";
      buffer_font_family = "Monocraft";
      buffer_font_size = 15;
      buffer_font_weight = 400;
      buffer_line_height = "standard";
      centered_layout = {
        left_padding = 0.2;
        right_padding = 0.2;
      };
      collaboration_panel = {
        button = false;
      };
      completions = {
        words = "fallback";
      };
      cursor_blink = true;
      debugger = {
        button = false;
      };
      diagnostics = {
        button = true;
        inline = {
          padding = 4;
        };
      };
      disable_ai = true;
      document_folding_ranges = "on";
      document_symbols = "on";
      "experimental.theme_overrides" = {
        accents = [
          "#848426"
          "#448446"
          "#844486"
          "#2C7B7C"
        ];
      };
      git = {
        inline_blame = {
          enabled = true;
        };
      };
      git_panel = {
        group_by = "none";
        default_width = 448;
        dock = "right";
        status_style = "icon";
        tree_view = true;
      };
      gutter = {
        bookmarks = false;
        breakpoints = false;
        folds = true;
        line_numbers = true;
        min_line_number_digits = 3;
        runnables = false;
      };
      hover_popover_delay = 400;
      icon_theme = "Material Icon Theme";
      indent_guides = {
        active_line_width = 1;
        background_coloring = "indent_aware";
        coloring = "fixed";
        line_width = 1;
      };
      inlay_hints = {
        enabled = false;
      };
      inline_code_actions = true;
      languages = {
        CSS = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
          language_servers = [
            "tailwindcss-language-server"
          ];
        };
        HTML = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
        JSON = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
        JSONC = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
        JavaScript = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
        Nix = {
          formatter = {
            external = {
              arguments = [
                "--quiet"
                "--"
              ];
              command = "alejandra";
            };
          };
          language_servers = [
            "nixd"
          ];
          tab_size = 2;
        };
        TSX = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
        TypeScript = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
        YAML = {
          tab_size = 2;
        };
        Svelte = {
          formatter = {
            language_server = {
              name = "biome";
            };
          };
        };
      };
      line_ending = "prefer_lf";
      lsp = {
        vtsls = {
          settings = {
            typescript = {
              updateImportsOnFileMove = {
                enabled = "always";
              };
            };
            javascript = {
              updateImportsOnFileMove = {
                enabled = "always";
              };
            };
          };
          enable_lsp_tasks = true;
        };
        biome = {
          settings = {
            require_config_file = true;
          };
        };
        nixd = {
          initialization_options = {
            formatting = {
              command = [
                "alejandra"
                "--quiet"
                "--"
              ];
            };
          };
        };
        tailwindcss-language-server = {
          settings = {
            classFunctions = [
              "cn"
              "cva"
              "clsx"
            ];
          };
        };
      };
      middle_click_paste = false;
      minimap = {
        current_line_highlight = "none";
        max_width_columns = 80;
        show = "always";
        thumb = "always";
      };
      node = {
        npm_path = "bun";
      };
      outline_panel = {
        button = false;
        indent_size = 20;
      };
      preferred_line_length = 80;
      preview_tabs = {
        enabled = false;
      };
      project_panel = {
        folder_indicator = "icon";
        bold_folder_labels = false;
        default_width = 320;
        dock = "left";
        entry_spacing = "standard";
        file_icons = true;
        git_status = true;
        git_status_indicator = true;
        hide_root = false;
        indent_size = 20;
        show_diagnostics = "errors";
        sort_mode = "directories_first";
        sticky_scroll = false;
      };
      redact_private_values = false;
      scrollbar = {
        axes = {
          horizontal = true;
          vertical = true;
        };
        cursors = true;
        diagnostics = "all";
        git_diff = true;
        search_results = true;
        selected_symbol = true;
        selected_text = true;
      };
      search = {
        button = true;
      };
      semantic_tokens = "combined";
      session = {
        trust_all_worktrees = true;
      };
      show_whitespaces = "selection";
      show_wrap_guides = true;
      status_bar = {
        active_language_button = true;
        cursor_position_button = true;
        line_endings_button = true;
        show_active_file = false;
      };
      sticky_scroll = {
        enabled = false;
      };
      tab_bar = {
        show = true;
        show_nav_history_buttons = false;
        show_pinned_tabs_in_separate_row = false;
        show_tab_bar_buttons = true;
      };
      tab_size = 4;
      tabs = {
        close_position = "right";
        file_icons = true;
        git_status = true;
        show_close_button = "hover";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      terminal = {
        button = true;
        dock = "bottom";
        flexible = true;
        font_size = 14;
        max_scroll_history_lines = 100000;
        scroll_multiplier = 1;
        show_count_badge = false;
        toolbar = {
          breadcrumbs = false;
        };
      };
      text_rendering_mode = "platform_default";
      theme = "Tokyo Night Dark";
      title_bar = {
        button_layout = "platform_default";
        show_branch_name = true;
        show_branch_status_icon = false;
        show_menus = false;
        show_onboarding_banner = true;
        show_project_items = true;
        show_sign_in = true;
        show_user_menu = true;
        show_user_picture = true;
      };
      toolbar = {
        agent_review = false;
        breadcrumbs = true;
        code_actions = false;
        quick_actions = true;
      };
      ui_font_family = "Monocraft";
      ui_font_size = 15;
      which_key = {
        delay_ms = 200;
      };
      code_actions_on_format = {
        "source.organizeImports.biome" = true;
      };
    };

    userKeymaps = [
      {
        unbind = {
          ctrl-q = "zed::Quit";
        };
      }
      {
        bindings = {
          ctrl-shift-tab = "pane::ActivatePreviousItem";
          ctrl-tab = "pane::ActivateNextItem";
        };
        context = "Pane";
      }
      {
        context = "!Terminal";
        unbind = {
          ctrl-shift-c = "collab_panel::ToggleFocus";
        };
      }
    ];
  };
}
