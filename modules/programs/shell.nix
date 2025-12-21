{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Development
    gcc
    cmake-lint
    zig
    rustup
    nodejs_24
    python3
    git
    lazygit
    chezmoi
    # CLI Tools
    fzf
    eza
    ripgrep
    zoxide
    fd
    yazi
    tmux
    # Neovim dependencies
    # neovim tree-sitter lua51Packages.luarocks black isort
  ];

  home.sessionSearchVariables.XDG_CONFIG_DIRS = [
    "/home/Jester/.config/kdedefaults"
    "/etc/xdg"
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = "fish_vi_key_bindings";
  };

  programs.bash.enable = true;
  home.sessionVariables.EDITOR = "nvim";
}
