{ pkgs, ... }:
{
  programs = {
    bash = {
      enable = true;
      interactiveShellInit = ''
        eval "$(batman --export-env)"
      '';
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings
        batman --export-env | source
      '';
      shellAbbrs = {
        cd = "z";
        dock = "fissh root@10.0.0.6";
        cad = "fissh root@10.0.0.154";
        klip = "fissh klip@10.0.0.161";
        prox = "fissh root@bigprox";
        plex = "fissh root@10.0.0.90";
        pi = "fissh pi@johnny";
        head = "fissh root@10.0.0.94";
      };
      functions = {
        fissh = ''
          SSH_PREFER_FISH=1 ssh -o SendEnv=SSH_PREFER_FISH $argv
        '';
      };
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        core
        batman
        batgrep
      ];
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
      tmux.enableShellIntegration = true;
    };
    nh = {
      enable = true;
      flake = "/home/Jester/.config/home-manager/";
      homeFlake = "/home/Jester/.config/home-manager/";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 2w";
      };
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
      shellWrapperName = "y";
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
