# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "size=3G" "mode=755" ]; # mode=755 so only root can write to those files
    };
  fileSystems."/nix" =  
    { device = "/dev/disk/by-label/NIX";
      fsType = "ext4";
    };
  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  fileSystems."/AppData" =
    { device = "/dev/disk/by-uuid/12c93ad9-0eed-487d-9574-87d7ebcfecdd";
      fsType = "ext4";
    };

  fileSystems."/JellyStorage" =
    { device = "/dev/disk/by-uuid/15dffdb7-2565-4984-8743-dcc6b4711f52";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/395fbbbb-1eee-4cf7-9866-bf0e8491f694"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
