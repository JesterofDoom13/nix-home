{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap orca-slicer)
    # Got this form reddit https://www.reddit.com/r/NixOS/comments/1hr293i/how_to_properly_handle_desktop_files_with/
    # Using it because the scale was way too big for me. I need font smaller or I feel like it's crowded.
    # mkdir
    # substitute
    # (lib.hiPrio (
    #   pkgs.runCommand "orca-slicer-desktop-modify" { } ''
    #     mkdir -p $out/share/applications
    #     substitute ${config.lib.nixGL.wrap pkgs.orca-slicer}/share/applications/OrcaSlicer.desktop $out/share/applications/OrcaSlicer.desktop \
    #       --replace-fail "Exec=orca-slicer %U" "Exec=env GDK_DPI_SCALE=0.8 orca-slicer %U"
    #   ''
    # ))
  ];
  xdg.configFile."OrcaSlicer" = {
    enable = true;
    recursive = false;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/assets/OrcaSlicer"; # Keep orca with me and allow it to update and pull changes
  };
}
