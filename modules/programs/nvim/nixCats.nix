{ config, lib, pkgs, inputs, ... }:
let
  inherit (inputs.nixCats) utils;
  # Points to your local lua folder for the builder
  luaPath = "${./config}"; 

  categoryDefinitions = { pkgs, ... }: {
    lspsAndRuntimeDeps = {
      general = with pkgs; [
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
    startupPlugins = {
      general = with pkgs.vimPlugins; [
        lazy-nvim LazyVim base16-nvim blink-cmp bufferline-nvim conform-nvim flash-nvim friendly-snippets fzf-lua gitsigns-nvim grug-far-nvim lazydev-nvim lualine-nvim noice-nvim nui-nvim nvim-lint nvim-lspconfig nvim-treesitter-textobjects nvim-treesitter.withAllGrammars nvim-ts-autotag nvim-web-devicons obsidian-nvim persistence-nvim plenary-nvim smart-splits-nvim snacks-nvim telescope-fzf-native-nvim telescope-nvim tmux-nvim todo-comments-nvim tokyonight-nvim trouble-nvim ts-comments-nvim vim-illuminate vim-startuptime which-key-nvim yazi-nvim nerdy-nvim dial-nvim lazygit-nvim { plugin = image-nvim; name = "image.nvim"; } { plugin = img-clip-nvim; name = "img-clip.nvim"; } { plugin = live-preview-nvim; name = "live-preview.nvim"; } { plugin = catppuccin-nvim; name = "catppuccin"; } { plugin = mini-ai; name = "mini.ai"; } { plugin = mini-operators; name = "mini.operators"; } { plugin = mini-icons; name = "mini.icons"; } { plugin = mini-splitjoin; name = "mini.splitjoin"; } { plugin = mini-surround; name = "mini.surround"; } { plugin = mini-pairs; name = "mini.pairs"; }
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
            sytlix = "woodland";
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
  };

  packageDefinitions = {
    nvim = { pkgs, ... }: {
      settings = {
        wrapRc = true; # Required for editable symlink
        aliases = [ "vim" "nv" ];
      };
      categories = { general = true; };
    };
        testnvim =
          { pkgs, mkPlugin, ... }@misc:
          {
            settings = {
              wrapRc = true;
              aliases = [
              "ntvim"
              ];
              unwrappedCfgPath = utils.mkLuaInline "os.getenv('HOME') .. './config/nvim'";
            };
            categories = {
              general = true;
              test = false;
              gitPlugins = true;
              colorscheme = "wooodland";
            };
            extra = { };
          };
  };
  defaultPackageName = "nvim";
in
{
  imports = [
    # Generate the nixCats Home Manager module on the fly
    (utils.mkHomeModule {
      inherit (inputs) nixpkgs;
      inherit luaPath categoryDefinitions packageDefinitions;
      # Re-adds your plugin overlays if you have them
      dependencyOverlays = [ (utils.standardPluginOverlay inputs) ];
    })
  ];
config = {
    nvim.enable = true;
    nvim.packageNames = ["nvim" "testnvim"]
  };
}
