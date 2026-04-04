{
  description = "Jester's 2025 Home Manager Configuration";

  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    pvetui.url = "github:devnullvoid/pvetui";
    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Zen Browser and extras
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vimium-options.url = "github:uimataso/vimium-nixos"; # For outputting my vvimium-c config to load after install

    ### nix-index-database -- For use with comma and nix-index integration on command not found.
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### For NixCats --- NEOVIM
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-obsidian-nvim = {
      url = "github:obsidian-nvim/obsidian.nvim";
      flake = false;
    };
    # Have to add this to nvim/default.nix under nvimFlakeOutputs = nvimFlake.outputs {
    # and in the nvim/flake.nix under optionalPlugins minus the "plugins-"
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
      niri,
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
        config.permittedInsecurePackages = [
          "nexusmods-app-unfree-0.21.1"
        ];
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
            niri
            homeDir
            myStylix
            system
            ;
        };
        modules = [
          niri.homeModules.niri
          ./home.nix
        ];
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          mod-organizer
          qt6.qtbase
          qt6.qtwayland
          lz4
          zlib
        ];
        shellHook = ''
          echo "MO2 dev environment ready."
          echo "Run: ModOrganizer2"
        '';
      };
    };
}
