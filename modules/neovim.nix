{
  config,
  myStylix,
  inputs,
  ...
}:
let
  inherit (inputs.nixCats) utils;
  # Points to your local lua folder for the builder
  luaPath = "${../assets/nvim/config}";

  categoryDefinitions =
    { pkgs, ... }:
    {
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          ast-grep
          black
          chafa
          cmake-lint
          curl
          gem
          harper
          isort
          lua5_1
          lua51Packages.luarocks
          lua-language-server
          markdownlint-cli2
          markdown-toc
          marksman
          mermaid-cli
          nil
          nixfmt
          nodejs_24
          perl540Packages.NeovimExt
          prettier
          python313Packages.pynvim
          ripgrep
          shfmt
          sqlite
          statix
          stdenv.cc.cc
          stylua
          tectonic
          tree-sitter
          tree-sitter-grammars.tree-sitter-norg-meta
          tree-sitter-grammars.tree-sitter-norg
          ueberzugpp
          universal-ctags
          viu
          zig
          (pkgs.writeShellScriptBin "lazygit" ''
            exec ${pkgs.lazygit}/bin/lazygit --use-config-file ${pkgs.writeText "lazygit_config.yml" ""} "$@"
          '')
        ];
      };
      startupPlugins = {
        general = with pkgs.vimPlugins; [
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
          transparent-nvim
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
      { pkgs, ... }:
      {
        settings = {
          wrapRc = true;
          aliases = [
            "vim"
            "nv"
          ];
        };
        categories = {
          general = true;
          test = false;
          gitPlugins = true;
          colorscheme = {
            stylix = "base16-${myStylix}";
          };
        };
      };
    testnvim =
      { pkgs, mkPlugin, ... }:
      {
        settings = {
          wrapRc = true;
          aliases = [
            "ntvim"
          ];
          unwrappedCfgPath = utils.mkLuaInline "os.getenv('HOME') .. '/.config/home-manager/assets/nvim/config'";
        };
        categories = {
          general = true;
          test = false;
          gitPlugins = true;
          colorscheme = {
            stylix = "base16-${myStylix}";
          };
        };
        extra = { };
      };
  };
in
{
  imports = [
    (utils.mkHomeModules {
      inherit (inputs) nixpkgs;
      inherit luaPath categoryDefinitions packageDefinitions;
      dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];
    })
  ];
  config = {
    nixCats.enable = true;
    nixCats.packageNames = [
      "nvim"
      "testnvim"
    ];
    xdg.configFile."nvim" = {
      enable = true;
      recursive = false;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/assets/nvim/config"; # Keep orca with me and allow it to update and pull changes
    };
  };
}
