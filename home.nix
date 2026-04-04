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
    stateVersion = "25.11";
    shellAliases = {
      du = "dust";
      q = "exit";
      rsg = "systemctl --user daemon-reload && systemctl --user restart app-ghostty-service.service";
      mfesp = "nix flake init -t my-flakes && direnv allow";
    };
    sessionVariables.EDITOR = "nvim";
    sessionVariables.VISUAL = "nvim";
    sessionSearchVariables.XDG_CONFIG_DIRS = [
      "${homeDir}/.config/kdedefaults"
      "/etc/xdg"
    ];
  };
  home.packages = with pkgs; [
    wget
    coreutils
    nix-ld
  ];
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
    useFlake = true;
  };
  programs.home-manager.enable = true;
}
