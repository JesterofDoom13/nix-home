{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    image = ../../assets/imgs/background/anime_skull.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts.monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    targets.zen-browser.profileNames = [ "default" ];
  };
}
