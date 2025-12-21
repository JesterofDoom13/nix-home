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
    tree-sitter
    lua51Packages.luarocks
    black
    isort
    marksman
    markdown-toc
    markdownlint-cli2
    nixfmt
    prettier
    ruby
    gem
    lua5_1
    shfmt
    ast-grep
    # CLI Tools
    fzf
    pandoc
    eza
    ripgrep
    zoxide
    fd
    yazi
    tmux
  ];

  home.sessionSearchVariables.XDG_CONFIG_DIRS = [
    "/home/Jester/.config/kdedefaults"
    "/etc/xdg"
  ];
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = "fish_vi_key_bindings";
    };

    bash.enable = true;
    nh = {
      enable = true;
      flake = "/home/Jester/.config/home-manager/";
    };
  };
  home.sessionVariables.EDITOR = "nvim";

}
