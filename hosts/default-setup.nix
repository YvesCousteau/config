# hosts/default-setup.nix
{
  gui = {
    enable = false;
    full = false;
    nvidia = false;
    unity = false;
    steam = false;
    steam-run = false;
    solaar = false;
    streamio = false;
    vial = false;
    handbrake = false;
    vlc = false;
  };
  audio = {
    enable = false;
    spotify = false;
  };
  network = {
    wifi = {
      home = false;
      emergency = false;
    };
    bluetooth = false;
    can = {
      enable = false;
      peak = false;
    };
  };
}
