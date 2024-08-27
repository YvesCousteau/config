{ pkgs, ... }: {
  imports = [
    # Import general core 
    ../../core

    # Import optional
    ../../optional/pkgs/git
    ../../optional/pkgs/rust
    ../../optional/pkgs/unity
  ];

  home = {
    username = "me";
    homeDirectory = "/home/me";
  };

  home.packages = with pkgs; [ 
    can-utils # can cli tools
    vial      # keyboard soft
    stremio   # stream app
  ];

  programs.git = {
    userName = "me";
    userEmail = "email@domain.com";
  };
}
