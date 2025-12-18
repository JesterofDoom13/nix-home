{ config, nixgl, zen-browser, pkgs, lib, inputs, ...}:
{
  # enable quirks (e.g. set $XDG_DATA_DIRS environment variable) for non NixOS operating systems
  targets.genericLinux.enable = true;

  # enable for nixGL wrapper
  targets.genericLinux.nixGL.packages = nixgl.packages;

  # home.username = "Jester";
  # home.homeDirectory = "/home/Jester/";
  home.stateVersion = "25.05";
  
  home.packages = with pkgs; [
    # (config.lib.nixGL.wrap ghostty)
    (config.lib.nixGL.wrap orca-slicer)
    gcc cmake-lint zig rustup
    wget
    btop
    python3 pipx
    ruby php php84Packages.composer
    nodejs_24
    julia
    git lazygit
    fish
    chezmoi
    fzf eza ripgrep ast-grep zoxide fd
    viu chafa ueberzugpp
    neovim
    tree-sitter
    lua51Packages.luarocks lua51Packages.lua
    black isort
    markdownlint-cli2 prettier prettierd
    texlivePackages.latex
    tmux
    yazi
    nerd-fonts.jetbrains-mono nerd-fonts.fira-code
  ];

  # Tell nixgl which packages in home.packages need wrapping
  # nixgl.extraPackages = with pkgs; [
  #   ghostty
  #   orca-slicer
  # ];
  # Install of fonts. All for now I suppose.
  fonts.fontconfig.enable = true;

  home.file = {
    # ... (your home.file config)
  };

  # zen-browser
  imports = [
    zen-browser.homeModules.beta
  ];
  programs.zen-browser.enable = true;

  # # ghostty
  # programs.ghostty = {
  #     enable = true;
  #     settings = {
  #       keybind = [ "global:super+semicolon=toggle_quick_terminal" ];
  #       quick-terminal-size = "75%,90%";
  #       background-opacity = .85;
  #
  #       command = "~/.local/bin/ghostty-tmux.sh";
  #       };
  #   };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

