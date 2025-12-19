{ pkgs, ... }: {
  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "kde" "gtk" ];
  };

  programs.zen-browser.enable = true;

  home.file.".config/kxkbrc".text = ''
    [Layout]
    Options=caps:swapescape
    ResetOldOptions=true
  '';

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}

