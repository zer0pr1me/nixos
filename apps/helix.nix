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

    # Settings exported directly into ~/.config/helix/config.toml
    settings = {
      editor = {
        auto-save = {
          focus-lost = true;
        };
        lsp = {
          display-messages = true;
        };
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
