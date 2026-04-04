{ pkgs, niri, ... }:
let
  niriBin = "${niri.packages.${pkgs.system}.niri-stable}/bin/niri";
in
{
  programs = {
    niri.enable = true;
    fuzzel.enable = true;
    waybar.enable = true;
  };

  home.packages = with pkgs; [
    swaybg
    swaylock
    xwayland-satellite
  ];

  systemd.user.services.niri = {
    Unit = {
      Description = "Niri Wayland compositor";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      Type = "notify";
      ExecStart = "${niriBin} --session";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.targets.niri-shutdown = {
    Unit = {
      Description = "Shutdown niri";
      DefaultDependencies = false;
    };
  };
}
