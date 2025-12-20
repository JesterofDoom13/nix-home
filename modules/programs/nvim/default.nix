{
  inputs,
  myColorscheme,
  ...
}:
let
  # Get the home module from the local nvim flake
  nvimFlake = import ./flake.nix;
  nvimFlakeOutputs = nvimFlake.outputs {
    inherit (inputs) nixpkgs nixCats myColorscheme;
    self = nvimFlake;
  };
in
{
  imports = [
    nvimFlakeOutputs.homeModule
  ];

  nvim = {
    enable = true;
    packageDefinitions.merge = {
      nvim =
        { pkgs, ... }:
        {
          categories = {
            colorscheme = myColorscheme;
          };
        };
    };
  };
}
