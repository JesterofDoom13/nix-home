{
  pkgs,
  config,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  ghostty-pkg = inputs.ghostty.packages.${system}.default;
  wrappedGhostty = config.lib.nixGL.wrap ghostty-pkg;

  ghostty-tmux = pkgs.writeShellScriptBin "ghostty-tmux" ''
    SESSION="main"
    ${pkgs.tmux}/bin/tmux new-session -A -s "$SESSION" ${pkgs.fish}/bin/fish
  '';
in
{
  home.packages = [ ghostty-tmux ];

  programs.ghostty = {
    enable = true;
    package = wrappedGhostty;
    settings = {
      keybind = [ "global:super+semicolon=toggle_quick_terminal" ];
      quick-terminal-size = "75%,90%";
      background-opacity = 0.85;
      gtk-single-instance = true;
      theme = "Gruvbox Material";
      ## These next two are VITAL to the quick-terminal working the way I like it.
      initial-window = false;
      quit-after-last-window-closed = false;
      command = "${ghostty-tmux}/bin/ghostty-tmux";
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
