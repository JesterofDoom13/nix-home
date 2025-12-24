{
  pkgs,
  user,
  homeDir,
  inputs,
  ...
}:
{
  targets.genericLinux.nixGL.packages = inputs.nixgl.packages;
  targets.genericLinux.enable = true;
  imports = [
    ./modules
  ];

  home = {
    username = user;
    homeDirectory = homeDir;
    stateVersion = "25.05";
    shellAliases = {
      du = "dust";
      q = "exit";
    };
    sessionVariables.EDITOR = "nvim";

    sessionSearchVariables.XDG_CONFIG_DIRS = [
      "${homeDir}/.config/kdedefaults"
      "/etc/xdg"
    ];
  };

  # Global packages that don't need their own module
  home.packages = with pkgs; [
    wget
    btop
    coreutils
  ];

  programs.home-manager.enable = true;
}
