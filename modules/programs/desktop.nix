{ pkgs, ... }:
{
  programs.zen-browser.enable = true;
  programs.google-chrome.enable = true;

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
