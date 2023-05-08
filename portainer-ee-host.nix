# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use systemd-boot  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit=10;
  boot.loader.timeout = 0;

  networking.hostName = "docker";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  environment.etc."issue.d/ip.issue".text = "\\4\n";
  networking.dhcpcd.runHook = "${pkgs.utillinux}/bin/agetty --reload";

  users.users.root.hashedPassword = "!";  
  users.users.admin = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" "networkmanager" "storage" ]; 
     initialPassword = "changeme";
     # packages = with pkgs; [     ];
  };
  environment.variables = {
    "EDITOR" = "nano";
  };

  environment.systemPackages = with pkgs; [
    nano
    git
    docker
    docker-compose
  ];

# Services
  services.openssh = {
    enable = true;
  };
systemd.timers."nextcloud-cron" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "nc-cron.service";
    };
};
systemd.services."nc-cron" = {
  script = ''
    ${pkgs.docker}/bin/docker exec -u 33 -t nextcloud-server php -f /var/www/html/cron.php
  '';
  serviceConfig = {
    Type = "oneshot";
    User= "root";
  };
};

# Define mountpoints here
  systemd.tmpfiles.rules =
  [
    "d /AppData 0755"
    "d /JellyStorage 0755"
  ] ;

# Containers
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer/portainer-ee:latest";
      ports = ["0.0.0.0:9443:9443"];
      volumes = ["/AppData/portainer:/data" "/var/run/docker.sock:/var/run/docker.sock"];
      #cmd = [];
     };
   };
  # Firewall Ports
  networking.firewall.allowedTCPPorts = [ 22 80 81 443 9443 ]; #ssh,http,https,npm,portainer
  networking.firewall.allowedUDPPorts = [ 22 80 81 443 9443 ]; #ssh,http,https,npm,portainer

  documentation.enable = false; # documentation of packages
  documentation.nixos.enable = false; # nixos documentation
  documentation.man.enable = false; # manual pages and the man command
  documentation.info.enable = false; # info pages and the info command
  documentation.doc.enable = false; # documentation distributed in packages' /share/doc
  nixpkgs.config.allowUnfree = true; #need this for my mac's bc chipset

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.copySystemConfiguration = true;
  system.stateVersion = "22.11";

}
