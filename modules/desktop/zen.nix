{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  programs = {
    zen-browser = {
      suppressXdgMigrationWarning = true;
      enable = true;
      policies.SecurityDevices.CAC-Device = "${pkgs.opensc}/lib/opensc-pkcs11.so";
      # profiles."Jester" = rec {
      #   id = 1;
      #   isDefault = true;
      #
      #   # containersForce = true;
      #   spacesForce = true;
      #   pinsForce = true;
      #
      #   # containers = {
      #   #   default = {
      #   #     color = "blue";
      #   #     icon = "briefcase";
      #   #     id = 0;
      #   #   };
      #   # };
      #   spaces = {
      #     "Rendezvous" = {
      #       id = "572910e1-4468-4832-a869-0b3a93e2f165";
      #       icon = "🎭";
      #       position = 1000;
      #       container = 0;
      #     };
      #     "Github" = {
      #       id = "08be3ada-2398-4e63-bb8e-f8bf9caa8d10";
      #       icon = "🐙";
      #       position = 2000;
      #       theme = {
      #         type = "gradient";
      #         colors = [
      #           {
      #             red = 185;
      #             green = 200;
      #             blue = 215;
      #             algorithm = "floating";
      #             type = "explicit-lightness";
      #           }
      #         ];
      #         opacity = 0.8;
      #         texture = 0.5;
      #       };
      #     };
      #     "Nix" = {
      #       id = "2441acc9-79b1-4afb-b582-ee88ce554ec0";
      #       icon = "❄️";
      #       position = 3000;
      #       theme = {
      #         type = "gradient";
      #         colors = [
      #           {
      #             red = 150;
      #             green = 190;
      #             blue = 230;
      #             algorithm = "floating";
      #             type = "explicit-lightness";
      #           }
      #         ];
      #         opacity = 0.2;
      #         texture = 0.5;
      #       };
      #     };
      #   };
      #   pins = {
      #     "mail" = {
      #       id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
      #       container = 0;
      #       url = "https://outlook.live.com/mail/";
      #       isEssential = true;
      #       position = 101;
      #     };
      #     "Notion" = {
      #       id = "8af62707-0722-4049-9801-bedced343333";
      #       container = 0;
      #       url = "https://notion.com";
      #       isEssential = true;
      #       position = 102;
      #     };
      #     "Folo" = {
      #       id = "fb316d70-2b5e-4c46-bf42-f4e82d635153";
      #       container = 0;
      #       url = "https://app.folo.is/";
      #       isEssential = true;
      #       position = 103;
      #     };
      #     "Nix awesome" = {
      #       id = "d85a9026-1458-4db6-b115-346746bcc692";
      #       workspace = spaces.Nix.id;
      #       isGroup = true;
      #       isFolderCollapsed = false;
      #       editedTitle = true;
      #       position = 200;
      #     };
      #     "Nix Packages" = {
      #       id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
      #       workspace = spaces.Nix.id;
      #       folderParentId = pins."Nix awesome".id;
      #       url = "https://search.nixos.org/packages";
      #       position = 201;
      #     };
      #     "Nix Options" = {
      #       id = "92931d60-fd40-4707-9512-a57b1a6a3919";
      #       workspace = spaces.Nix.id;
      #       folderParentId = pins."Nix awesome".id;
      #       url = "https://search.nixos.org/options";
      #       position = 202;
      #     };
      #     "Home Manager Options" = {
      #       id = "2eed5614-3896-41a1-9d0a-a3283985359b";
      #       workspace = spaces.Nix.id;
      #       folderParentId = pins."Nix awesome".id;
      #       url = "https://home-manager-options.extranix.com";
      #       position = 203;
      #     };
      #   };
      # };
    };
  };
}
