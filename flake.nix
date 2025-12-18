{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Or a specific release channel
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Ensure Home Manager uses the same Nixpkgs
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixgl/main";
    # ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = {
    self, 
    nixpkgs, 
    home-manager, 
    plasma-manager, 
    zen-browser, 
    # ghostty, 
    nixgl, 
    ... } @ inputs :
  let
    user = "Jester";
    username = "${user}";
    system = "x86_64-linux";
  in {
    # home-manager.backupFileExtension = "backup";
    homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; };
      extraSpecialArgs = {
          inherit nixgl inputs user zen-browser;
        };
        modules = [
          plasma-manager.homeModules.plasma-manager
          ./home.nix
          {
              home = {
                  inherit username;
                  homeDirectory = "/home/${username}";
                };
            }
        ];
    };
    # nixosConfigurations.mysystem = nixpkgs.lib.nixosSystem {
    #   modules = [
    #     ({ pkgs, ... }: {
    #       environment.systemPackages = [
    #         ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
    #       ];
    #     })
    #   ];
    # };
  };
}
