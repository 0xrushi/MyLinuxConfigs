{ config, lib, pkgs, modulesPath, ... }:

{
  # Import not-detected hardware configuration
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Kernel modules to include in the initrd
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  # boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-amd" ];
  # boot.extraModulePackages = [ ];

  # Filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3393886c-9656-465a-a8cb-c14c769d3609";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/B2E2-556A";
    fsType = "vfat";
  };

  # Swap device configuration
  swapDevices = [
    { device = "/dev/disk/by-uuid/9abae2a9-6d5a-419d-b1cb-aeae429082d2"; }
  ];

  # Networking configuration
  networking.useDHCP = lib.mkDefault true;

  # CPU microcode updates
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Enable open-source NVIDIA driver (if applicable)
  hardware.nvidia.open = true;

  # OpenGL configuration for AMD
  hardware.opengl = {
    enable = true;
    # driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
  };

  # Remove or comment out the NVIDIA package since you're using AMD
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Audio configuration
  hardware.pulseaudio.enable = false;

  # Additional AMD-specific settings
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
}
