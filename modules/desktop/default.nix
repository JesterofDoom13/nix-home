{ pkgs, config, ... }:
{
  imports = [
    ./ghostty.nix
    ./orca.nix
    ./stylix.nix
    ./zen.nix
  ];
  xdg.configFile = {
    ".config/kxkbrc".text = ''
      [Layout]
      Options=caps:swapescape
      ResetOldOptions=true
    '';

    "kando" = {
      enable = true;
      recursive = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/assets/kando"; # Keep orca with me and allow it to update and pull changes
    };
    # This is from the solaar github
    "autostart/kando.desktop".text = ''
      [Desktop Entry]
      Name=Kando
      Exec=${pkgs.kando}/bin/kando
      Icon=kando
      StartupNotify=true
      Terminal=false
      Type=Application
      Keywords=kando;mouse;
      Categories=Utility;GTK;
    '';
    "autostart/solaar.desktop".text = ''
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

  };
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    freecad
    solaar
    kando
  ];
  programs.google-chrome.enable = true;

}
