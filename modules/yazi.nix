{ inputs, ... }:
{
  imports = [
    inputs.nix-yazi-plugins.legacyPackages.x86_64-linux.homeManagerModules.default
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    shellWrapperName = "y";
  };

  programs.yazi.yaziPlugins = {
    enable = true;
    plugins = {
      ouch = {
        enable = true;
      };
      system-clipboard = {
        enable = true;
      };
      rich-preview = {
        enable = true;
      };
      glow = {
        enable = true;
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
