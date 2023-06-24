# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit=10;
  boot.loader.timeout = 0;
  networking.hostName = "kodi";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  users.users.root.hashedPassword = "!";  
  users.users.kodi = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; 
     initialPassword = "kodi";
     # packages = with pkgs; [     ];
  };
  environment.variables = {
    "EDITOR" = "nano";
  };
  environment.systemPackages = with pkgs; [  ];
# Containers
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {   };
  documentation.enable = false; # documentation of packages
  documentation.nixos.enable = false; # nixos documentation
  documentation.man.enable = false; # manual pages and the man command
  documentation.info.enable = false; # info pages and the info command
  documentation.doc.enable = false; # documentation distributed in packages' /share/doc
  nixpkgs.config.allowUnfree = true; #need this for my mac's bc chipset
  services.xserver.enable = true;
  services.xserver.desktopManager.kodi.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kodi";
  services.xserver.displayManager.lightdm.autoLogin.timeout = 3;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";

}
