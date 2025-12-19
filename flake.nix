{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Or a specific release channel
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Ensure Home Manager uses the same Nixpkgs
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      zen-browser,
      ghostty,
      nixgl,
      stylix,
      ...
    }@inputs:
    let
      user = "Jester";
      username = "${user}";
      system = "x86_64-linux";
    in
    {
      # home-manager.backupFileExtension = "backup";
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { localSystem = system; };
        extraSpecialArgs = {
          inherit
            nixgl
            inputs
            user
            zen-browser
	    stylix
            ;
        };
        modules = [
          plasma-manager.homeModules.plasma-manager
          ./home.nix
	  stylix.homeModules.stylix
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
    };
}
