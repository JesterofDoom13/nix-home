{
  pkgs,
  ...
}:
{
  programs.tmux = {
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
      set -g allow-passthrough on
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
}
