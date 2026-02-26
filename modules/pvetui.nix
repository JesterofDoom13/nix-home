{ inputs, system, ... }:
{
  home.packages = [
    inputs.pvetui.packages.${system}.default
  ];
  # programs.pvetui.enable = true;
}
