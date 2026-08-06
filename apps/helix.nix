# modules/apps/helix.nix
{ pkgs, ... }:

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
}
