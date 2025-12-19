# features/default.nix
{ ... }:

{
  imports = [
    ./desktop.nix
    ./ghostty.nix
    ./shell.nix
    ./theme.nix
  ];
}
