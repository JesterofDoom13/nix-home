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
  programs = {

    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        fingers
        # Couldn't get this to load from here
        # but I have it installe din neovim so I use
        # the run-shell command on it and that does the
        # trick.
        # pkgs.vimPlugins.tmux-nvim
      ];
      extraConfig = ''
        set-window-option -g mode-keys vi

        set -g  default-terminal "screen-256color"
        # needed for proper nvim/tmux/base16 colors
        set -ga terminal-overrides ",xterm-256color:Tc"
        set -gq allow-passthrough on
        set -g visual-activity off

        # because I can't install it through the plugins I cheated and know 
        # I'm already installing it in nixCats
        run-shell ${pkgs.vimPlugins.tmux-nvim}/tmux.nvim.tmux


        # Kill split
        bind-key -n M-w kill-pane 

        # split windows
        bind-key -n 'C-;' split-window -h -c '#{pane_current_path}'
        bind-key -n C-"'" split-window -v -c'#{pane_current_path}'
      '';
    };
    ghostty = {
      enable = true;
      # can't run this version since I'm using the wrappedGhostty
      # version and that isn't in the sytemd this provides.
      # systemd.enable = true;
      package = wrappedGhostty;
      settings = {
        keybind = [ "global:super+semicolon=toggle_quick_terminal" ];
        quick-terminal-size = "72.5%,90%";
        background-opacity = 0.85;
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
  };
  xdg = {
    configFile = {
      "ghostty/shaders/sparks-from-fire.glsl".source = ../assets/ghostty/shaders/sparks-from-fire.glsl;
      "ghostty/shaders/cursor_tail.glsl".source = ../assets/ghostty/shaders/cursor_tail.glsl;
      "ghostty/shaders/sonic_boom_cursor.glsl".source = ../assets/ghostty/shaders/sonic_boom_cursor.glsl;
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
}
