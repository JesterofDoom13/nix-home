{ inputs, ... }:
{
  imports = [
    inputs.nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    # extraPackages = (with pkgs; [ glow ouch ])
    # ++ (with pkgs.yaziPlugins; [glow ouch time-travel wl-clipboard relative-motions chmod compress mediainfo jump-to-char]);
    # settings = {prepend_preloaders = [ Replace magick, image, video with mediainfo { mime = "{audio,video,image}/*"; run = "mediainfo"; } { mime = "application/subrip"; run = "mediainfo"; } Adobe Illustrator, Adobe Photoshop is image/adobe.photoshop, already handled above { mime = "application/postscript"; run = "mediainfo"; } ]; prepend_previewers = [ Replace magick, image, video with mediainfo { mime = "{audio,video,image}/*"; run = "mediainfo"; } { mime = "application/subrip"; run = "mediainfo"; } Adobe Illustrator, Adobe Photoshop is image/adobe.photoshop, already handled above { mime = "application/postscript"; run = "mediainfo"; } ]; There are more extensions which are supported by mediainfo. Just add file's MIME type to `previewers`, `preloaders` above. https://mediaarea.net/en/MediaInfo/Support/Formats task = [ "image_alloc" = 1073741824; ];};
    # keymap = {inputs.prepend_keymap = [ glow { on = [ "<C-e>" ]; run = "seek 5"; } { on = [ "<C-y>" ]; run = "seek -5"; } ]; mgr.prepend_keymap = [ { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod on selected files"; } { on = [ "C" ]; run = "plugin ouch"; desc = "Compress with ouch"; } { on = [ "1" ]; run = "plugin relative-motions 1"; desc = "Move in relative steps"; } { on = [ "2" ]; run = "plugin relative-motions 2"; desc = "Move in relative steps"; } { on = [ "3" ]; run = "plugin relative-motions 3"; desc = "Move in relative steps"; } { on = [ "4" ]; run = "plugin relative-motions 4"; desc = "Move in relative steps"; } { on = [ "5" ]; run = "plugin relative-motions 5"; desc = "Move in relative steps"; } { on = [ "6" ]; run = "plugin relative-motions 6"; desc = "Move in relative steps"; } { on = [ "7" ]; run = "plugin relative-motions 7"; desc = "Move in relative steps"; } { on = [ "8" ]; run = "plugin relative-motions 8"; desc = "Move in relative steps"; } { on = [ "9" ]; run = "plugin relative-motions 9"; desc = "Move in relative steps"; } { on = [ "z" "h" ]; run = "plugin time-travel --args=prev"; desc = "Go to previous snapshot"; } { on = [ "z" "l" ]; run = "plugin time-travel --args=next"; desc = "Go to next snapshot"; } { on = [ "z" "e" ]; run = "plugin time-travel --args=exit"; desc = "Exit browsing snapshots"; } { on = [ "c" "a" "a" ]; run = "plugin compress"; desc = "Archive selected files"; } { on = [ "c" "a" "p" ]; run = "plugin compress -p"; desc = "Archive selected files (password)"; } { on = [ "c" "a" "h" ]; run = "plugin compress -ph"; desc = "Archive selected files (password+header)"; } { on = [ "c" "a" "l" ]; run = "plugin compress -l"; desc = "Archive selected files (compression level)"; } { on = [ "c" "a" "u" ]; run = "plugin compress -phl"; desc = "Archive selected files (password+header+level)"; } { on = "<F9>"; run = "plugin mediainfo -- toggle-metadata"; desc = "Toggle media preview metadata"; } { on = [ "m" ]; run = "plugin relative-motions"; desc = "Trigger a new relative motion"; } ];};
    shellWrapperName = "y";
  };

  programs.yazi.yaziPlugins = {
    enable = true;
    plugins = {
      ouch = {
        enable = true;
      };
      rich-preview = {
        enable = true;
      };
      glow = {
        enable = false;
      };
      chmod = {
        enable = true;
      };
      jump-to-char = {
        enable = true;
        keys.toggle.on = [ "F" ];
      };
      relative-motions = {
        enable = true;
        show_numbers = "relative_absolute";
        show_motion = true;
      };
    };
  };
}
