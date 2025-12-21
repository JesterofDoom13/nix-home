{
  pkgs,
  config,
  inputs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  ghostty-pkg = inputs.ghostty.packages.${system}.default;
  wrappedGhostty = config.lib.nixGL.wrap ghostty-pkg;

in
{
  # home.packages = [ ghostty-tmux ];

  programs.ghostty = {
    enable = true;
    package = wrappedGhostty;
    settings = {
      keybind = [ "global:super+semicolon=toggle_quick_terminal" ];
      quick-terminal-size = "72.5%,90%";
      background-opacity = 0.85;
      gtk-single-instance = true;
      # theme = "Gruvbox Material";
      command = "${pkgs.tmux}/bin/tmux new-session -A -s 'main' ${pkgs.fish}/bin/fish";
      ## These next two are VITAL to the quick-terminal working the way I like it.
      initial-window = false;
      quit-after-last-window-closed = false;
    };
  };

  xdg.configFile."autostart/ghostty.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=${wrappedGhostty}/bin/ghostty
    Name=Ghostty
    Comment=Start Ghostty on login
  '';
}
