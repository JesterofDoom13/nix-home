# ~/.config/home-manager/modules/syncthing-emudeck.nix
# or inline into home.nix

{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Change this to your actual username on Bazzite
  user = config.home.username;
  # If your EmuDeck is on an SD card or secondary drive, change this base path
  emuBase = "${homeDir}/Emulation"; # or "$HOME/Emulation" if on internal storage
  homeDir = config.home.homeDirectory;
in
{
  # ── Install the syncthing package ──────────────────────────────────────────
  home.packages = [ pkgs.syncthing ];

  # ── Enable and configure Syncthing ─────────────────────────────────────────
  services.syncthing = {
    enable = true;

    # GUI available at http://127.0.0.1:8384
    # Change port if it conflicts with Decky Loader (which also uses 8080)
    guiAddress = "127.0.0.1:8384";

    settings = {
      gui = {
        address = "127.0.0.1:8384";
      };

      # ── Devices ──────────────────────────────────────────────────────────
      # Add your Proxmox/Syncthing server device here.
      # Get the device ID from the Syncthing web UI on your Proxmox server.
      devices = {
        "proxmox-syncthing" = {
          id = "OQXMPN3-3UISNNK-UL2FIJI-ZQQTRUC-ISUBUKO-SVWGF7R-A4SXXUA-I4BEVAJ";
          # Replace with your actual device ID from the Proxmox Syncthing UI
          name = "Proxmox Syncthing";
        };
      };

      # ── Folders ──────────────────────────────────────────────────────────
      folders = {

        "mame-saves" = {
          path = "${homeDir}/.mame";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
          ignorePatterns = ''
            // DO NOT IGNORE
            !/nvram
            !/sta
            // IGNORE
            *
            .DS_Store
          '';
        };

        "flycast-saves" = {
          path = "${emuBase}/saves/flycast/saves";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "duckstation-saves" = {
          path = "${emuBase}/saves/duckstation/saves";
          devices = [ "proxmox-syncthing" ];
        };

        "retroarch-saves" = {
          path = "${homeDir}/.var/app/org.libretro.RetroArch/config/retroarch";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
          ignorePatterns = ''
            // DO NOT IGNORE
            !/states
            !/saves
            // IGNORE
            *
            .DS_Store
          '';
        };

        "ryujinx-saves" = {
          path = "${homeDir}/.config/Ryujinx/bis";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "rpcs3-saves" = {
          path = "${emuBase}/saves/rpcs3/saves";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "dolphin-saves" = {
          path = "${homeDir}/.var/app/org.DolphinEmu.dolphin-emu/data/dolphin-emu";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
          ignorePatterns = ''
            // DO NOT IGNORE
            !/GC
            !/Wii
            !/GBA
            !/states
            !/StateSaves
            // IGNORE
            *
            .DS_Store
          '';
        };

        "primehack-saves" = {
          path = "${homeDir}/.var/app/io.github.shiiion.primehack/data/dolphin-emu";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
          ignorePatterns = ''
            // DO NOT IGNORE
            !/GC
            !/Wii
            !/GBA
            !/states
            !/StateSaves
            // IGNORE
            *
            .DS_Store
          '';
        };

        "ppsspp-saves" = {
          path = "${homeDir}/.var/app/org.ppsspp.PPSSPP/config/ppsspp/PSP";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
          ignorePatterns = ''
            // DO NOT IGNORE
            !/PPSSPP_STATE
            !/SAVEDATA
            // IGNORE
            *
            .DS_Store
          '';
        };

        "pcsx2-states" = {
          path = "${emuBase}/saves/pcsx2/states";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "pcsx2-saves" = {
          path = "${emuBase}/saves/pcsx2/saves";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "yuzu-nand" = {
          path = "${emuBase}/storage/yuzu/nand";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "eden-nand" = {
          path = "${emuBase}/storage/eden/nand";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

        "roms" = {
          path = "${emuBase}/roms/";
          devices = [ "proxmox-syncthing" ];
          type = "sendreceive"; # add this
        };

      }; # end folders
    }; # end settings
  }; # end services.syncthing
}
