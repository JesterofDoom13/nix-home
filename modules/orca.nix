{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap orca-slicer)
  ];
  xdg.configFile."OrcaSlicer".source = config.lib.mkOutOfStoreSymlink ../assets/OrcaSlicer; # Keep orca with me and allow it to update and pull changes

}
