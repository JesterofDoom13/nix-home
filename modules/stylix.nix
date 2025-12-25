{ pkgs, myStylix, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = ../assets/imgs/background/brown_city_planet_w.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${myStylix}.yaml";
    fonts = {
      monospace = {
        name = "FiraCode Nerd Font";
      };
      sansSerif = {
        name = "FiraCode Nerd Font";
      };
      serif = {
        name = "FiraCode Nerd Font";
      };
      sizes = {
        desktop = 8;
        applications = 8;
        popups = 8;
        terminal = 8;
      };
    };
    targets = {
      yazi = {
        enable = true;
      };
      gtk = {
        enable = false;
      };
      zen-browser.profileNames = [ "" ];
    };
  };
}
