# hosts/desktop-hood.nix
{ mkNixosConfiguration, nixos-hardware, ... }:

mkNixosConfiguration {
  system = "aarch64-linux";
  host = ./.;
  users = [ "me" "guest" ];
  setup = {
    gui = {
      enable = true;
      hyprland = false;
      wayfire = true;
      steam-run = false;
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
    nixos-hardware.nixosModules.raspberry-pi-4
    "/home/me/4658-UGREEN/soft-high-level/nix/os.nix"
  ];
}
