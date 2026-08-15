{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    

    settings = {
      user.name = "Bohdan Ovsiannikov";
      user.email = "zeroprime@mailbox.org";
      core.editor = "hx";
    };
  };
}
