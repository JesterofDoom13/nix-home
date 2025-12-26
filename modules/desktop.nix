{ pkgs, ... }:
{
  home.file.".config/kxkbrc".text = ''
    [Layout]
    Options=caps:swapescape
    ResetOldOptions=true
  '';
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    solaar
  ];
  programs.zen-browser.enable = true;
  programs.google-chrome.enable = true;

  # This is from the solaar github
  xdg.configFile."autostart/solaar.desktop".text = ''
    [Desktop Entry]
    Name=Solaar
    Comment=Logitech Unifying Receiver peripherals manager
    Comment[fr]=Gestionnaire de périphériques pour les récepteurs Logitech Unifying
    Comment[hr]=Upravitelj Logitechovih uređaja povezanih putem Unifying i Nano prijemnika
    Comment[ru]=Управление приёмником Logitech Unifying Receiver
    Comment[de]=Logitech Unifying Empfänger Geräteverwaltung
    Comment[es]=Administrador de periféricos de Logitech Receptor Unifying
    Comment[pl]=Menedżer urządzeń peryferyjnych odbiornika Logitech Unifying
    Comment[sv]=Kringutrustningshanterare för Logitech Unifying-mottagare
    Comment[zh_CN]=罗技优联设备管理器
    Comment[zh_TW]=羅技Unifying 裝置管理器
    Comment[zh_HK]=羅技Unifying 裝置管理器
    Exec=${pkgs.solaar}/bin/solaar --window=hide
    Icon=solaar
    StartupNotify=true
    Terminal=false
    Type=Application
    Keywords=logitech;unifying;receiver;mouse;keyboard;
    Categories=Utility;GTK;
  '';
}
