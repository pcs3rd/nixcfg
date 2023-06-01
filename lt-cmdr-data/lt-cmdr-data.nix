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

  networking.hostName = "Lieutenant_Commander_Data";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.nftables.enable = true;
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  environment.etc."issue.d/ip.issue".text = "\\4\n";
  networking.dhcpcd.runHook = "${pkgs.utillinux}/bin/agetty --reload";

  users.users.root.hashedPassword = "";  
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
    docker
    docker-compose
  ];

# Services
  services.openssh = {
    enable = true;
  };
# Containers
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
     pihole = {
       image = "portainer/portainer-ee:latest";
       environment = {
         TZ: 'America/New_York';
         WEBPASSWORD: 'changeme';
         DNSMASQ_LISTENING: 'all'; 
       };
       ports = ["0.0.0.0:53:53" "0.0.0.0:80" ];
       volumes = ["/AppData/pihole/data:/etc/pihole" "/AppData/pihole/dns:/etc/dnsmasq.d"];
       #cmd = [];
      };
      unifi = {
        image = "linuxserver/unifi-controller";
        enviroment = {
          PGUID: "";
          PGID: "";
          TZ:"";
          MEM_LIMIT:"";
          MEM_STARTUP:"";
        };
            ports:
      - 8443:8443
      - 3478:3478/udp
      - 10001:10001/udp
      - 8080:8080
      - 1900:1900/udp #optional
      - 8843:8843 #optional
      - 8880:8880 #optional
      - 6789:6789 #optional
      - 5514:5514/udp #optional
          
        };
      };
   };

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
