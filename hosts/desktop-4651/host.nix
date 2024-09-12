# hosts/desktop-hood.nix
{ mkNixosConfiguration, nixos-hardware, ... }:

mkNixosConfiguration {
  system = "x86_64-linux";
  host = ./.;
  users = [ "me" "guest" ];
  setup = {
    gui = {
      enable = true;
      extra.hyprland = {
        windowrulev2 = ''
          windowrulev2 = monitor 1,title:^(X1325)$,
        '';
        classic = ''
          cursor {
            no_hardware_cursors = true
          }
        '';
      };
      nvidia = true;
      steam-run = true;
      handbrake = true;
    };
    network = {
      wifi = {
        emergency =  true;
      };
      can = {
        enable = true;
        peak = true;
      };
    };
  };
  extraModules = [
    "/home/me/4651-ZLegend/soft-high-level/nix/os.nix"
  ];
}
