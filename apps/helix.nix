{
  pkgs,
  lib,
  config,
  ...
}:

let
  utils = import ../lib/utils.nix { inherit lib; };
  userHome = config.home.homeDirectory;
in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    # Package selection (defaults to pkgs.helix)
    package = pkgs.helix;

    extraPackages = with pkgs; [
      # Nix
      nil # Feature-rich Language Server for Nix
      nixfmt-rfc-style # Standard Nix formatter

      # Python
      pyright # Fast type checking & autocompletion
      ruff # Blazing fast Python linter and formatter

      # Markdown
      marksman # Markdown LSP (links, references, heading navigation)
      markdownlint-cli # Markdown linter for syntax & structure formatting

      # YAML
      yaml-language-server
      ansible-language-server
    ];

    # Settings exported directly into ~/.config/helix/config.toml
    settings = {
      editor = {
        auto-save = {
          focus-lost = true;
        };
        lsp = {
          display-messages = true;
        };
        auto-format = true;
      };

      keys.insert = {
        "C-[" = "normal_mode";

        # Ukrainian layout:
        "C-х" = "normal_mode";
      };

      keys.normal = {
        # Ukrainian layout:
        # Navigation (h, j, k, l)
        "р" = "move_char_left";
        "о" = "move_visual_line_down";
        "л" = "move_visual_line_up";
        "д" = "move_char_right";

        # Word movement (w, b, e)
        "ц" = "move_next_word_start";
        "и" = "move_prev_word_start";
        "у" = "move_next_word_end";

        # Mode switches (i, a, o, O)
        "ш" = "insert_mode";
        "ф" = "append_mode";
        "щ" = "open_below";
        "Щ" = "open_above";

        # Basic editing (d, c, y, p, u)
        "в" = "delete_selection";
        "с" = "change_selection";
        "н" = "yank";
        "з" = "paste_after";
        "г" = "undo";
        "Г" = "redo";

        # Selection/visual (x)
        "ч" = "extend_line_below";
      };

    };

    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
          };
          auto-format = true;
        }
        {
          name = "python";
          formatter = {
            command = "ruff";
            args = [
              "format"
              "--------"
              "-"
            ];
          };
          language-servers = [
            "pyright"
            "ruff"
          ];
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [ "marksman" ];
        }
      ];
    };
  };

  home.activation.linkHelix = utils.mkNonNixosSymlink {
    sourcePath = "${userHome}/.nix-profile/bin/hx";
    targetPath = "/usr/local/bin/hx";
  };
}
