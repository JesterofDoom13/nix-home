{
  config,
  ...
}:
{
  xdg.configFile."OrcaSlicer" = {
    enable = true;
    recursive = false;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/assets/OrcaSlicer"; # Keep orca with me and allow it to update and pull changes
  };
}
