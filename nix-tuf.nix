# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# Use nixpkgs/unstable

{ config, pkgs, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  musnix = builtins.fetchTarball "https://github.com/musnix/musnix/archive/master.tar.gz";

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      (import "${musnix}")


    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit=5;

  networking.hostName = "nix-tuf"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  programs.dconf.enable = true;
# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raymond = { 
    isNormalUser = true;
    initialPassword = "change";
    extraGroups = [ "wheel" "audio" "networkmanager" ]; # Enable ‘sudo’ for the user. 
  };
  home-manager.users.raymond = {
    home.homeDirectory = "/home/raymond";
    home.packages = with pkgs; [
        google-chrome
        reaper
        jellyfin-web
        discord 
        steam
        spotify
        prismlauncher
 	adoptopenjdk-jre-openj9-bin-16
        openrgb
        gimp
        krita
        libreoffice
        cura
        lsp-plugins
        vscode
        nodejs
        obs-studio
	gh
        vial
        steam-tui
        steam-run
    ];
      home.stateVersion = "22.11";
  programs.git = {
    enable = true;
    userName  = "pcs3rd";
    userEmail = "rhean1620@gmail.com";
  };
  dconf.settings = {
    "org/gnome/shell" = {
      command-history = [ "lg" ];
      disable-user-extensions = false;
      disabled-extensions = [ "native-window-placement@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "trayIconsReloaded@selfmade.pl" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "vertical-workspaces@G-dH.github.com"];
      enabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" "just-perfection-desktop@just-perfection" "drive-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" "dash-to-dock@micxgx.gmail.com" "clipboard-indicator@tudmotu.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com"  ];
      favorite-apps = [ "org.gnome.Console.desktop" "org.gnome.Nautilus.desktop" "google-chrome.desktop" "discord.desktop" "org.prismlauncher.PrismLauncher.desktop" "chrome-ehcljolipkikggmbpmdijefmppdgemlf-Default.desktop" "code.desktop"];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "44.0";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      hacks-level = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = false;
      blur-on-overview = true;
      enable-all = false;
      opacity = 213;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      override-background = true;
      style-dash-to-dock = 0;
      unblur-in-overview = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
      compatibility = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      customize = false;
      static-blur = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-color = "rgb(0,0,0)";
      background-opacity = 0.8;
      custom-background-color = false;
      custom-theme-shrink = true;
      dash-max-icon-size = 32;
      dock-fixed = true;
      dock-position = "LEFT";
      extend-height = true;
      height-fraction = 0.9;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      preview-size-scale = 0.4;
      running-indicator-style = "METRO";
    };

    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      app-menu = true;
      app-menu-label = false;
      notification-banner-position = 1;
      search = false;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/window-list" = {
      display-all-workspaces = false;
      grouping-mode = "auto";
      show-on-all-monitors = true;
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };
    "org/gnome/dekstop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      enable-animations = true;
    };

  };
};
 
  environment.systemPackages = with pkgs; [
    nano
    git 
    curl    
    carla
    nvidia-offload
    home-manager
    dconf2nix
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-dock-animator
    gnomeExtensions.just-perfection
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.quick-settings-tweaker
    gnome.adwaita-icon-theme
    gnome.gvfs
    gnome.sushi
    gnome-browser-connector
    gnome.networkmanager-l2tp
    gnome.gnome-boxes
    yabridge
    yabridgectl
    wineWowPackages.stable 
    winetricks
    vlc
  ];


  programs.steam.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
  services.openssh.enable = false;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      gnome-weather
      gnome-maps
      gnome-calendar
      gnome-clocks
      cheese # webcam tool
      gnome-music
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
    ]);
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
 
  hardware.pulseaudio.enable = false;
  musnix.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.sessionVariables = rec { #set default session latency
    PIPEWIRE_LATENCY = "32/48000";
  };
	#Prime offloading maybe?
  hardware.nvidia.prime = {
    offload.enable = lib.mkForce true;
    amdgpuBusId = "PCI:6:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  networking.firewall.enable = false;
  nixpkgs.config.allowUnfree = true;
  system.copySystemConfiguration = true;
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  system.stateVersion = "22.11"; # Did you read the comment?
}


