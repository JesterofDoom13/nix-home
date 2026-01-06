{
  pkgs,
  config,
  inputs,
  homeDir,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  ghostty-pkg = inputs.ghostty.packages.${system}.default;
  wrappedGhostty = config.lib.nixGL.wrap ghostty-pkg;
in
{
  programs.ghostty = {
    enable = true;
    # can't run this version since I'm using the wrappedGhostty
    # version and that isn't in the sytemd this provides.
    # systemd.enable = true;
    package = wrappedGhostty;
    settings = {
      keybind = [ "global:super+semicolon=toggle_quick_terminal" ];
      quick-terminal-size = "72.5%,90%";
      background-opacity = 0.85;
      background-blur = true;
      gtk-single-instance = true;
      alpha-blending = "native";
      font-thicken = true;
      adjust-cell-height = -2;
      adjust-cell-width = "-20%";
      adjust-underline-position = 2;
      window-padding-x = 2;
      command = "${pkgs.tmux}/bin/tmux new-session -A -s 'main' ${pkgs.fish}/bin/fish";
      custom-shader = [
        "${homeDir}/.config/ghostty/shaders/cursor_tail.glsl"
        "${homeDir}/.config/ghostty/shaders/sonic_boom_cursor.glsl"
        # "${homeDir}/.config/ghostty/shaders/sparks-from-fire.glsl"
      ];
      initial-window = false;
      quit-after-last-window-closed = false;
    };
  };
  # Building my own systemd because the one in programs.ghostty.systemd
  # doesn't have an option to set it as wrappedGhostty that I cna find
  # right now. Need the wrappedGhostty or this doesn't work on my bazzite
  # build. Maybe some day I'll find a better way.
  systemd.user.services.app-ghostty-service = {
    Unit = {
      Description = "Ghostty";
      After = [
        "graphical-session.target"
        "dbus.socket"
      ];
    };
    Service = {
      ExecStart = "${wrappedGhostty}/bin/ghostty";
      Type = "notify-reload";
      ReloadSignal = "SIGUSR2";
      BusName = "com.mitchellh.ghostty";
    };
    Install = {
      WantedBy = [
        "graphical-session.target"
      ];
    };
  };
  xdg = {
    configFile = {
      "ghostty/shaders/sparks-from-fire.glsl".source = ../../assets/ghostty/shaders/sparks-from-fire.glsl;
      "ghostty/shaders/cursor_tail.glsl".source = ../../assets/ghostty/shaders/cursor_tail.glsl;
      "ghostty/shaders/sonic_boom_cursor.glsl".source =
        ../../assets/ghostty/shaders/sonic_boom_cursor.glsl;
      # If systemd doesn't work, you can do this.
      # I went with the systemd so I can check it's status better.
      # "autostart/ghostty.desktop".text = ''
      #   [Desktop Entry]
      #   Type=Application
      #   Exec=${wrappedGhostty}/bin/ghostty
      #   Name=Ghostty
      #   Comment=Start Ghostty on login
      # '';
    };
  };
}
