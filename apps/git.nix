{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    userName = "Bohdan Ovsiannikov";
    userEmail = "zeroprime@mailbox.org";

    extraConfig = {
      core.editor = "hx";
    };
  };
}
