{
  description = "Jester's 2025 Home Manager Configuration";

  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vimium-options.url = "github:uimataso/vimium-nixos";
    ghostty.url = "github:ghostty-org/ghostty";
    pvetui.url = "github:devnullvoid/pvetui";
    suyu.url = "github:Noodlez1232/suyu-flake";
    nixgl.url = "github:nix-community/nixGL";
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### For NixCats --- NEOVIM
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    # Have to add this to nvim/default.nix under nvimFlakeOutputs = nvimFlake.outputs {
    # and in the nvim/flake.nix under optionalPlugins minus the "plugins-"
    plugins-obsidian-nvim = {
      url = "github:obsidian-nvim/obsidian.nvim";
      flake = false;
    };
    plugins-kanban-nvim = {
      url = "github:arakkkkk/kanban.nvim";
      flake = false;
    };
    plugins-markdownplus = {
      url = "github:yousefhadder/markdown-plus.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      home-manager,
      nix-yazi-plugins,
      pvetui,
      zen-browser,
      nixgl,
      ...
    }@inputs:
    let
      user = "Jester";
      homeDir = "/home/${user}";
      myStylix = "gruvbox-material-dark-hard";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        localSystem = system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
        ];
      };
      pkgs-unstable = import unstable {
        localSystem = system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
        ];
      };
    in
    {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            inputs
            pkgs-unstable
            user
            homeDir
            myStylix
            system
            ;
        };
        modules = [
          ./home.nix
        ];
      };
    };
}
