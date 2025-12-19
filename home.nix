{
  pkgs,
  user,
  config,
  inputs,
  ...
}:
{
  targets.genericLinux.nixGL.packages = inputs.nixgl.packages;
  imports = [
    inputs.my-nvim.homeModule
    ./modules/programs
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
