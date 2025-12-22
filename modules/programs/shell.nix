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
    eza = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      icons = "auto";
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
    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--max-columns-preview"
      ];
    };
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
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
      fd
      dust
      pandoc
    ];
  };
}
