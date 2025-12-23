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
    # Have to add this to nvim/default.nix under nvimFlakeOutputs = nvimFlake.outputs {
    # and in the nvim/flake.nix under optionalPlugins minus the "plugins-"
    myNixCats.url = "path:./modules/programs/nvim";
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
      myNixCats,
      ...
    }@inputs:
    let
      user = "Jester";
      homeDir = "/home/${user}";
      myColorscheme = "woodland";
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
            myColorscheme
            ;
        };
        modules = [
          ./home.nix
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.stylix.homeModules.stylix
          inputs.zen-browser.homeModules.beta
          myNixCats.homeModule
          (
            {
              config,
              lib,
              myColorscheme,
              ...
            }:
            {
              nixCats.enable = true;
              nixCats.packageNames = [ "nvim" ];

              xdg.configFile."nvim"= {
	      	source =
                config.lib.file.mkOutOfStoreSymlink "{$homeDir}/.config/home-manager/modules/programs/nvim/config";
		recursive = true;
}; 
            }
          )
        ];
      };
    };
}
