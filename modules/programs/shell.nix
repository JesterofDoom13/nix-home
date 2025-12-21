{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = "fish_vi_key_bindings";
      shellAbbrs = {
        cd = "z";
      };
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    yazi = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    bash.enable = true;
    nh = {
      enable = true;
      flake = "/home/Jester/.config/home-manager/";
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
