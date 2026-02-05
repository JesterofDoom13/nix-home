{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser = {
    enable = true;
    policies.SecurityDevices.CAC-Device = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };

}
