{ mkNixosConfiguration }:
{
  desktop-hood = mkNixosConfiguration {
    system = "x86_64-linux";
    host = ./desktop/hood;
    users = [ "me" ];
    setup = {
      gui = {
        enable = true;
        nvidia = true;
        unity = true;
        steam = true;
        steam-run = true;
        solaar = true;
        pavucontrol = true;
        streamio = true;
        vial = true;
        handbrake = true;
      };
      audio = {
        enable = true;
        spotify = true;
      };
      network = {
        wifi = {
          home =  true;
        };
        bluetooth = false;
        can = {
          enable = false;
          peak = false;
        };
      };
    };
  };
  laptop-hood = mkNixosConfiguration {
    system = "x86_64-linux";
    host = ./laptop/hood;
    users = [ "me" ];
    setup = {
      gui = {
        enable = true;
        nvidia = true;
        unity = false;
        steam = false;
        steam-run = true;
        solaar = true;
        streamio = false;
        pavucontrol = true;
        vial = false;
        handbrake = true;
      };
      audio = {
        enable = true;
        spotify = true;
      };
      python = true;
      network = {
        wifi = {
          home =  true;
        };
        bluetooth = true;
        can = {
          enable = true;
          peak = true;
        };
      };
    };
  };
  # work-4644 = mkNixosConfiguration {
  #   system = "x86_64-linux";
  #   hostModule = ./laptop/hood;
  #   isGui = true;
  #   users = [ "me" ];
  # };
}
