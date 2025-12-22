{ pkgs, myColorscheme, ... }:
{
  stylix = {
    enable = true;
    # The default but I didn't feel like it was doing it, so just in case
    autoEnable = true;
    polarity = "dark";
    image = ../../assets/imgs/background/anime_skull.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${myColorscheme}.yaml";
    fonts = {
      monospace = {
        name = "FiraCode Nerd Font"; # Or "FiraCodeNF"
      };
      sansSerif = {
        # Or other generic font
        name = "FiraCode Nerd Font";
      };
      serif = {
        # Or other generic font
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
