{ pkgs, myColorscheme, ... }:
{
  stylix = {
    enable = true;
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
        name = "Roboto Regular";
      };
      serif = {
        # Or other generic font
        name = "Roboto Slab";
      };
      sizes = {
        desktop = 9; # Or your preferred small size, e.g., 9, 10, 11
        applications = 9;
        popups = 9;
        terminal = 9; # Adjust for your terminal
      };
    };
    targets = {
      gtk = {
        enable = false;
      };
      zen-browser.profileNames = [ "default" ];
    };
  };
}
