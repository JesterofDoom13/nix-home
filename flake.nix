{
  description = "Jester's 2025 Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    suyu.url = "github:Noodlez1232/suyu-flake";
    nixgl.url = "github:nix-community/nixGL";

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
      home-manager,
      nixgl,
      ...
    }@inputs:
    let
      user = "Jester";
      homeDir = "/home/${user}";
      # Stylix and base16 seem to share the same names for the same things
      # All you have to do is find the name of it and add it here.
      # in nixCats I have it add the "base16-" in front of it and
      # adding it nixCats.cats.colorscheme.stylix and in stylix
      # I add it  ${pkgs.base16-schemes}/share/themes/${myStylix}.yaml
      # Simpler approach and flexible in same ways, but not others.
      myStylix = "gruvbox-material-dark-hard";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        localSystem = system;
        config.allowUnfree = true;
        overlays = [ nixgl.overlay ];
      };
    in
    {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            inputs
            user
            homeDir
            myStylix
            ;
        };
        modules = [
          ./home.nix
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.stylix.homeModules.stylix
          inputs.zen-browser.homeModules.beta
        ];
      };
    };
}
