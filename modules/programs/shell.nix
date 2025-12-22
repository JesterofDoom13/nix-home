{ pkgs, ... }:
{
  programs = {
    bash.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = "fish_vi_key_bindings";
      shellAbbrs = {
        cd = "z";
      };
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    nh = {
      enable = true;
      flake = "/home/Jester/.config/home-manager/";
    };
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        fingers
      ];
      extraConfig = ''
        set-window-option -g mode-keys vi

        set -g  default-terminal "screen-256color"
        # needed for proper nvim/tmux/base16 colors
        set -ga terminal-overrides ",xterm-256color:Tc"

        # Navigating panes
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' { if -F '#{pane_at_left}' ''$ 'select-pane -L' }
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' { if -F '#{pane_at_bottom}' ''$ 'select-pane -D' }
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' { if -F '#{pane_at_top}' ''$ 'select-pane -U' }
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' { if -F '#{pane_at_right}' ''$ 'select-pane -R' }
        bind-key -n 'C-n' if-shell "$is_vim" 'send-keys C-n' { if -F '#{window_end_flag}' ''$ 'select-window -n' }
        bind-key -n 'C-p' if-shell "$is_vim" 'send-keys C-p' { if 'test #{window_index} -gt #{base-index}' 'select-window -p' }

        bind-key -T copy-mode-vi 'C-h' if -F '#{pane_at_left}' ''$ 'select-pane -L'
        bind-key -T copy-mode-vi 'C-j' if -F '#{pane_at_bottom}' ''$ 'select-pane -D'
        bind-key -T copy-mode-vi 'C-k' if -F '#{pane_at_top}' ''$ 'select-pane -U'
        bind-key -T copy-mode-vi 'C-l' if -F '#{pane_at_right}' ''$ 'select-pane -R'
        bind-key -T copy-mode-vi 'C-n' if -F '#{window_end_flag}' ''$ 'select-window -n'
        bind-key -T copy-mode-vi 'C-p' if 'test #{window_index} -gt #{base-index}' 'select-window -p'

        # Resizing Panes
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

        bind -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 1'
        bind -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 1'
        bind -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 1'
        bind -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 1'

        bind-key -T copy-mode-vi M-h resize-pane -L 1
        bind-key -T copy-mode-vi M-j resize-pane -D 1
        bind-key -T copy-mode-vi M-k resize-pane -U 1
        bind-key -T copy-mode-vi M-l resize-pane -R 1

        # Swapping Panes
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

        bind -n 'C-M-h' if-shell "$is_vim" 'send-keys C-M-h' 'swap-pane -s "{left-of}"'
        bind -n 'C-M-j' if-shell "$is_vim" 'send-keys C-M-j' 'swap-pane -s "{down-of}"'
        bind -n 'C-M-k' if-shell "$is_vim" 'send-keys C-M-k' 'swap-pane -s "{up-of}"'
        bind -n 'C-M-l' if-shell "$is_vim" 'send-keys C-M-l' 'swap-pane -s "{right-of}"'

        bind-key -T copy-mode-vi C-M-h swap-pane -s "{left-of}"
        bind-key -T copy-mode-vi C-M-j swap-pane -s "{down-of}"
        bind-key -T copy-mode-vi C-M-k swap-pane -s "{up-of}"
        bind-key -T copy-mode-vi C-M-l swap-pane -s "{right-of}"

        ### From vim-tpipeline
        set -g focus-events on
        set -g status-style bg=default
        set -g status-left-length 99
        set -g status-right-length 99
        set -g status-justify centre
        #############

        # Kill split
        bind-key -n M-w kill-pane 

        # split windows
        bind-key -n 'C-;' split-window -h -c '#{pane_current_path}'
        bind-key -n C-"'" split-window -v -c'#{pane_current_path}'
      '';
    };
    yazi = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };

  home = {
    packages = with pkgs; [
      # Development
      ast-grep
      black
      cmake-lint
      gcc
      gem
      git
      isort
      lazygit
      lua5_1
      lua51Packages.luarocks
      markdownlint-cli2
      markdown-toc
      marksman
      nixfmt
      nodejs_24
      prettier
      python3
      ruby
      rustup
      shfmt
      tree-sitter
      zig
      # CLI Tools
      eza
      fd
      pandoc
      ripgrep
      tmux
    ];
    sessionVariables.EDITOR = "nvim";

    sessionSearchVariables.XDG_CONFIG_DIRS = [
      "/home/Jester/.config/kdedefaults"
      "/etc/xdg"
    ];
  };
}
