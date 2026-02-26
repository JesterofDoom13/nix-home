{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.pvetui.default.${pkgs.system}
  ];
  # programs.pvetui.enable = true;
}
