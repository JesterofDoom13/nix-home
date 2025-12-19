{
  pkgs,
  user,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.my-nvim.homeModule
  ];

  nvim = {
    enable = true;
    packageNames = [ "nvim" ];
  };

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.05";
    shellAliases = {
      v = "nixGL nvim";
      nvim = "nixGL nvim";
    };
  };

  # Global packages that don't need their own module
  home.packages = with pkgs; [
    wget
    btop
    coreutils
    (config.lib.nixGL.wrap orca-slicer)
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
}
