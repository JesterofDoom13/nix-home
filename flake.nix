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
    nixgl.url = "github:nix-community/nixGL";
    my-nvim.url = "path:./nvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      my-nvim,
      nixgl,
      ...
    }@inputs:
    let
      user = "Jester";
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
        extraSpecialArgs = { inherit inputs user; };
        modules = [
          ./home.nix
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.stylix.homeModules.stylix
          inputs.zen-browser.homeModules.beta
        ];
      };
    };
}
