# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license
{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./config}";

      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        # allowUnfree = true;
      };

      dependencyOverlays = [
        (utils.standardPluginOverlay inputs)
      ];
      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          mkPlugin,
          ...
        }@packageDef:
        {
          lspsAndRuntimeDeps = with pkgs; {
            general = [
              ast-grep
              curl
              fd
              harper
              lua-language-server
              markdownlint-cli2
              markdown-toc
              nil
              nixfmt
              perl540Packages.NeovimExt
              prettier
              ripgrep
              statix
              stdenv.cc.cc
              stylua
              universal-ctags
              viu
              chafa
              ueberzugpp
              (pkgs.writeShellScriptBin "lazygit" ''
                exec ${pkgs.lazygit}/bin/lazygit --use-config-file ${pkgs.writeText "lazygit_config.yml" ""} "$@"
              '')
            ];
          };

          startupPlugins = with pkgs.vimPlugins; {
            general = [
              lazy-nvim
              LazyVim
              base16-nvim
              blink-cmp
              bufferline-nvim
              conform-nvim
              flash-nvim
              friendly-snippets
              fzf-lua
              gitsigns-nvim
              grug-far-nvim
              lazydev-nvim
              lualine-nvim
              noice-nvim
              nui-nvim
              nvim-lint
              nvim-lspconfig
              nvim-treesitter-textobjects
              nvim-treesitter.withAllGrammars
              nvim-ts-autotag
              nvim-web-devicons
              obsidian-nvim
              persistence-nvim
              plenary-nvim
              smart-splits-nvim
              snacks-nvim
              telescope-fzf-native-nvim
              telescope-nvim
              tmux-nvim
              todo-comments-nvim
              tokyonight-nvim
              trouble-nvim
              ts-comments-nvim
              vim-illuminate
              vim-startuptime
              which-key-nvim
              yazi-nvim
              nerdy-nvim
              dial-nvim
              lazygit-nvim
              {
                plugin = image-nvim;
                name = "image.nvim";
              }
              {
                plugin = img-clip-nvim;
                name = "img-clip.nvim";
              }
              {
                plugin = live-preview-nvim;
                name = "live-preview.nvim";
              }
              {
                plugin = catppuccin-nvim;
                name = "catppuccin";
              }
              {
                plugin = mini-ai;
                name = "mini.ai";
              }
              {
                plugin = mini-operators;
                name = "mini.operators";
              }
              {
                plugin = mini-icons;
                name = "mini.icons";
              }
              {
                plugin = mini-splitjoin;
                name = "mini.splitjoin";
              }
              {
                plugin = mini-surround;
                name = "mini.surround";
              }
              {
                plugin = mini-pairs;
                name = "mini.pairs";
              }
            ];
          };

          optionalPlugins = with pkgs.neovimPlugins; {
            general = [
              kanban-nvim
              {
                plugin = markdownplus;
                name = "markdown-plus.nvim";
              }
            ];
          };

          sharedLibraries = {
            general = with pkgs; [ libgit2 ];
          };
          environmentVariables = {
            test = {
              CATTESTVAR = "It worked!";
            };
          };
          extraWrapperArgs = {
            test = [ ''--set CATTESTVAR2 "It worked again!"'' ];
          };
          python3.libraries = {
            test = [ (_: [ ]) ];
          };
          extraLuaPackages = {
            test = [ (_: [ ]) ];
          };
        };

      packageDefinitions = {
        nvim =
          {
            pkgs,
            name,
            mkPlugin,
            ...
          }:
          {
            settings = {
              wrapRc = true;
              aliases = [
                "vim"
                "nv"
              ];
              hosts.python3.enable = true;
              hosts.node.enable = true;
            };
            categories = {
              general = true;
              test = false;
              gitPlugins = true;
            };
          };
        testnvim =
          { pkgs, mkPlugin, ... }:
          {
            settings = {
              wrapRc = false;
              aliases = [
              "ntvim"
              ];
              unwrappedCfgPath = utils.mkLuaInline "os.getenv('HOME') .. './config/nvim'";
            };
            categories = {
              general = true;
              test = false;
              gitPlugins = true;
            };
            extra = { };
          };
      };
      defaultPackageName = "nvim";
    in
    {
      homeModule =
        {
          config,
          lib,
          inputs,
          pkgs,
          ...
        }:
        {
          imports = [
            (utils.mkHomeModules {
              inherit
                nixpkgs
                luaPath
                categoryDefinitions
                packageDefinitions
                ;
               dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];
              extra = {
              };
            })
          ];
        };

      # Standard outputs below (packages, devShells, overlays, etc)
      packages = forEachSystem (
        system:
        let
          nixpkgsFor = nixpkgs.legacyPackages.${system};
        in
        {
          default = utils.mkNvimPackages packageDefinitions.${defaultPackageName} {
            pkgs = nixpkgsFor;
            inherit categoryDefinitions luaPath;
          };
        }
      );

      # (Your other outputs like devShells, overlays can go here if needed,
      # but they are often simpler when using the homeModule approach above)

    }; # This closes the outputs = { ... }; block
} # This closes the entire flake.nix file
