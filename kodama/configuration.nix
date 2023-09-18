{ config, pkgs, lib, ... }:
let
  system_StateVersion = "23.05";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system_StateVersion}.tar.gz";
in
{
  imports = [
      (import "${home-manager}/nixos")
  ];
  networking.hostName = "nix-kodama";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  #mobile.boot.stage-1.splash.enable = false;
  users.users.raymond = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = [ "wheel" "networkmanager" ];
  };
  home-manager.users.raymond = {
    home.homeDirectory = "/home/raymond";
    home.packages = with pkgs; [
        firefox
        tailscale
        tmux 
    ];    
    home.stateVersion = "${system_StateVersion}";
  dconf.settings = {
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "native-window-placement@gnome-shell-extensions.gcampax.github.com" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "trayIconsReloaded@selfmade.pl" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "windowsNavigator@gnome-shell-extensions.gcampax.github.com" "vertical-workspaces@G-dH.github.com" "chrome-kedolomibeipjfpgimbgogkpojhpkgmj-Default.desktop" ];
      enabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" "just-perfection-desktop@just-perfection" "drive-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" "dash-to-dock@micxgx.gmail.com" "clipboard-indicator@tudmotu.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "quick-settings-tweaks@qwreey" "tailscale-status@maxgallup.github.com"];
      favorite-apps = [ "org.gnome.Console.desktop" "org.gnome.Nautilus.desktop" "google-chrome.desktop" "discord.desktop" "org.prismlauncher.PrismLauncher.desktop" "chrome-ehcljolipkikggmbpmdijefmppdgemlf-Default.desktop" "code.desktop" "slack.desktop" "chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Default.desktop" "steam.desktop" "carla.desktop" "ardour.desktop"];
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
      style-dash-to-dock = 2;
      unblur-in-overview = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
      compatibility = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      customize = false;
      static-blur = true;
      blur = true;
      style-panel = 2;
      override-background = true;
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
      app-menu-label = true;
      app-menu-icon = false;
      notification-banner-position = 1;
      search = false;
      theme = true;
      workspace-switcher-should-show = true;
      workspaces-in-app-grid = true;
      panel-indicator-padding-size = 5;
      pannel-button-padding-size = 5;
    };

    "org/gnome/shell/extensions/window-list" = {
      display-all-workspaces = false;
      grouping-mode = "auto";
      show-on-all-monitors = true;
    };

    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      add-dnd-quick-toggle-enabled = false;
      add-unsafe-quick-toggle-enabled = false;
      disable-adjust-content-border-radius = false;
      disable-remove-shadow = false;
      input-always-show = false;
      input-show-selected = false;
      last-unsafe-state = false;
      list-buttons = "[{\"name\":\"Clutter_Actor\",\"label\":null,\"visible\":true},{\"name\":\"SystemItem\",\"label\":null,\"visible\":true},{\"name\":\"OutputStreamSlider\",\"label\":null,\"visible\":true},{\"name\":\"St_BoxLayout\",\"label\":null,\"visible\":true},{\"name\":\"InputStreamSlider\",\"label\":null,\"visible\":false},{\"name\":\"BrightnessItem\",\"label\":null,\"visible\":false},{\"name\":\"NMWiredToggle\",\"label\":null,\"visible\":false},{\"name\":\"NMWirelessToggle\",\"label\":null,\"visible\":true},{\"name\":\"NMModemToggle\",\"label\":null,\"visible\":false},{\"name\":\"NMBluetoothToggle\",\"label\":null,\"visible\":false},{\"name\":\"NMVpnToggle\",\"label\":null,\"visible\":false},{\"name\":\"BluetoothToggle\",\"label\":null,\"visible\":true},{\"name\":\"PowerProfilesToggle\",\"label\":null,\"visible\":true},{\"name\":\"NightLightToggle\",\"label\":\"Night Light\",\"visible\":true},{\"name\":\"DarkModeToggle\",\"label\":\"Dark Style\",\"visible\":true},{\"name\":\"RfkillToggle\",\"label\":\"Airplane Mode\",\"visible\":true},{\"name\":\"RotationToggle\",\"label\":\"Auto Rotate\",\"visible\":false},{\"name\":\"DndQuickToggle\",\"label\":null,\"visible\":true},{\"name\":\"BackgroundAppsToggle\",\"label\":\"No Background Apps\",\"visible\":false},{\"name\":\"MediaSection\",\"label\":null,\"visible\":false},{\"name\":\"Notifications\",\"label\":null,\"visible\":true}]";
      media-control-compact-mode = false;
      notifications-enabled = true;
      notifications-integrated = true;
      notifications-use-native-controls = true;
      notifications-hide-when-no-notifications = false;
      output-show-selected = false;
      volume-mixer-position = "bottom";
      volume-mixer-show-description = false;
      volume-mixer-show-icon = true;
    };

    "org/gnome/shell/world-clocks" = {
      locations = "@av []";
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      enable-animations = true;
      clock-show-seconds = true;
    };
   };
  };
    environment.systemPackages = with pkgs; [
    nano
    git 
    curl    
    carla
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.tailscale-status
    gnome.adwaita-icon-theme
    gnome.gvfs
    gnome.sushi
    gnome-browser-connector
  ];
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
  environment.sessionVariables = rec { #set default session latency
    PIPEWIRE_LATENCY = "256/48000";
  };
  programs.dconf.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  #VIAL HID RULE
   services.udev.extraRules = '' #VIAL udev rules
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  services.openssh.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
  services.tailscale.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.udev.packages = with pkgs; [ 
	gnome.gnome-settings-daemon 
  ];
  virtualisation = {
    libvirtd.enable = true;
    waydroid.enable = true;
    lxd.enable = true;
  };
  hardware.opengl.enable = true;
  hardware.pulseaudio.enable = false;
  sound.enable = true;  
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  system.stateVersion = "${system_StateVersion}"; # Did you read the comment?

}
