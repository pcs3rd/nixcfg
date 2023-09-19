{ config, pkgs, lib, ... }:
let 
  system_StateVersion = "23.05";
  mobile-nixos = builtins.fetchTarball "https://github.com/pcs3rd/mobile-nixos/archive/master.tar.gz";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${system_StateVersion}.tar.gz";
in
{
  imports = [
    (import "${mobile-nixos}/lib/configuration.nix" { device = "lenovo-kodama"; })
    (import "${home-manager}/nixos")
  ];

  networking.hostName = "nixos-kodama";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
    
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  users.users.raymond = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = [ "wheel" "networkmanager" ];
  };
  home-manager.users.raymond = {
    home.packages = with pkgs; [
      tmux
      git
      nano
      curl 
      firefox-wayland
      chromium
      carla
    ];
    home.stateVersion = "${system_StateVersion}";
   dconf.settings = {
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ "just-perfection-desktop@just-perfection" "drive-menu@gnome-shell-extensions.gcampax.github.com" "appindicatorsupport@rgcjonas.gmail.com" "dash-to-dock@micxgx.gmail.com" "clipboard-indicator@tudmotu.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com" "quick-settings-tweaks@qwreey" "tailscale-status@maxgallup.github.com" "blur-my-shell@aunetx"];
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
  sound.enable = true;  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.tailscale.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
  environment.sessionVariables = rec { #set default session latency
    PIPEWIRE_LATENCY = "256/48000";
  };
  environment.gnome.excludePackages = (with pkgs; [
    baobab
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-calendar
    gnome-weather
    gnome-maps
    gnome-calculator
    gnome-contacts
    simple-scan
    eog
    yelp
    cheese
    gnome-music
    epiphany
    geary
    evince
    gnome-characters
    totem
    tali
    hitori
    atomix
  ]);
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.tailscale-status
    gnome.adwaita-icon-theme
    gnome.gvfs
    gnome-browser-connector
  ];
  programs.dconf.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opengl.enable = true;
  hardware.sensor.iio.enable = false;
  hardware.firmware = [ config.mobile.device.firmware ];
  services.openssh.enable = false;
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
  system.stateVersion = "${system_StateVersion}";
}
