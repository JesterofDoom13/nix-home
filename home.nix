{ config, nixgl, zen-browser, pkgs, lib, inputs, ...}:
let
  ghostty-tmux = pkgs.writeShellScriptBin "ghostty-tmux" ''
  SESSION="main"
  ${pkgs.tmux}/bin/tmux new-session -A -s "$SESSION" ${pkgs.fish}/bin/fish
  '';
  wrappedGhostty = config.lib.nixGL.wrap inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  # enable quirks (e.g. set $XDG_DATA_DIRS environment variable) for non NixOS operating systems
  targets.genericLinux.enable = true;
  home.extraOutputsToInstall = [ "man" "share" "icons" ];
  xdg.enable = true;
	#  xdg.portal = {
	#  	enable = true;
	# config.common.default = "*";
	# extraPortals = with pkgs; [
	# 	xdg-desktop-portal-kde
	# 	xdg-desktop-portal-gtk
	# ];
	#  };



  # enable for nixGL wrapper
  targets.genericLinux.nixGL.packages = nixgl.packages;

  # home.username = "Jester";
  # home.homeDirectory = "/home/Jester/";
  home.stateVersion = "25.05";
  
  home.packages = with pkgs; [
    ghostty-tmux
    (config.lib.nixGL.wrap orca-slicer)
    gcc cmake-lint zig rustup
    wget
    btop
    python3 pipx
    ruby php php84Packages.composer
    nodejs_24
    julia
    git lazygit
    fish bash
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

  # Install of fonts. All for now I suppose.
  fonts.fontconfig.enable = true;
	#  home.file.".config/kxkbrc".text = ''
	#  	[Layout]
	# Options=caps:swapescape
	# ResetOldOptions=true
	# '';
  home.file.".config/kxkbrc".text = ''
    [Layout]
    Options=caps:swapescape
    ResetOldOptions=true
  '';
  
  # zen-browser
  imports = [
    zen-browser.homeModules.beta
  ];
  programs.zen-browser.enable = true;

	# programs.plasma.hotkeys.commands."toggle-ghostty" = {
	#   name = "Toggle Ghostty Quick Terminal";
	#   key = "Meta+;"; 
	#   # Use the wrappedGhostty variable to ensure it has OpenGL/NixGL support
	#   command = "${wrappedGhostty}/bin/ghostty +toggle_quick_terminal";
	# };

  # ghostty
  programs.bash = {
  	enable = true;
  };
  programs.fish = {
  	enable = true;
	interactiveShellInit = ''
	fish_vi_key_bindings
	'';
  };

  programs.ghostty = {
      enable = true;
        package = wrappedGhostty; 
      settings = {
        keybind = [ "global:super+semicolon=toggle_quick_terminal" ];
        quick-terminal-size = "75%,90%";
        background-opacity = .85;
	gtk-single-instance = true;
	quit-after-last-window-closed = false;
	initial-window = false;

	# Look
	theme = "Gruvbox Material";
	# custom-shader = "~/.config/ghostty/plugins/ghostty-shaders/sparks-from-fire.glsl";
	# custom-shader = "~/.config/ghostty/shaders/cursor_tail.glsl";
	# custom-shader = "~/.config/ghostty/shaders/sonic_boom_cursor.glsl";
	# alpha-blending = "native";


	# Fonts
	font-family = "Fira Code SemiBold";
	font-size = 9;
	# font-family = "Fira Code";
	font-family-bold = "Fira Code";
	font-family-italic = "Maple Mono";
	font-family-bold-italic = "Maple Mono";
	# font-family = "Symbols Nerd Font Mono";
	adjust-underline-position = 4;
	window-padding-x = 2;

	# Command to run at startup
        command = "${ghostty-tmux}/bin/ghostty-tmux";
        };
    };
	xdg.configFile."autostart/ghostty.desktop".text = ''
	  [Desktop Entry]
	  Type=Application
	  Exec=${wrappedGhostty}/bin/ghostty
	  Hidden=false
	  NoDisplay=false
	  X-GNOME-Autostart-enabled=true
	  Name=Ghostty
	  Comment=Start Ghostty on login
	'';

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

