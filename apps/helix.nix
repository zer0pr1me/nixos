{ pkgs, lib, config, ... }:

let
  utils = import ../lib/utils.nix { inherit lib; };
  userHome = config.home.homeDirectory;
in
{
  programs.helix = {
    enable = true;

    # Package selection (defaults to pkgs.helix)
    package = pkgs.helix;

    extraPackages = with pkgs; [
      # Nix
      nil                  # Feature-rich Language Server for Nix
      nixfmt-rfc-style     # Standard Nix formatter

      # Python
      pyright              # Fast type checking & autocompletion
      ruff                 # Blazing fast Python linter and formatter

      # Markdown
      marksman             # Markdown LSP (links, references, heading navigation)
      markdownlint-cli     # Markdown linter for syntax & structure formatting
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
      };
      
    };

    languages = {
      language = [
        {
          name = "nix";
          formatter = { command = "nixfmt"; };
          auto-format = true;
        }
        {
          name = "python";
          formatter = { command = "ruff"; args = [ "format" "--------" "-" ]; };
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
