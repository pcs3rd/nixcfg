# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Use systemd-boot  
  # Support IP forwarding to use this device as a Tailscale exit node.
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit=10;
  boot.loader.timeout = 1;
# Network
  networking.hostName = "sevenofnine";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.nftables.enable = true;
  time.timeZone = "America/New_York";
# User stuff
  users.users.root.hashedPassword = "!";  
  users.users.admin = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" "networkmanager" "storage" ]; 
     initialPassword = "changeme";
  };
# USE GOOGLE AUTHENTICATOR TOTP CODES FOR SSH
  security.pam.services = {
    sshd.googleAuthenticator.enable = true;
  };
  services.openssh.settings.ChallengeResponseAuthentication = true;
  services.openssh.settings.PasswordAuthentication = true;
# Environment
  i18n.defaultLocale = "en_US.UTF-8";
  environment.variables = {
    "EDITOR" = "nano";
  };
  environment.systemPackages = with pkgs; [
    nano
    google-authenticator
    mtm
    smartmontools
  ];
# Servicses
  services.openssh.enable = true;
  services.tailscale.enable = true;
# Containers
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer/portainer-ee:2.18.3";
      ports = ["0.0.0.0:9443:9443"];
      volumes = ["/Disks/AppData/portainer:/data" "/var/run/docker.sock:/var/run/docker.sock"];
     };
   };
# Nix config
  nix.settings.auto-optimise-store = true;
  documentation.enable = false; # documentation of packages
  documentation.nixos.enable = false; # nixos documentation
  documentation.man.enable = false; # manual pages and the man command
  documentation.info.enable = false; # info pages and the info command
  documentation.doc.enable = false; # documentation distributed in packages' /share/doc
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
}
