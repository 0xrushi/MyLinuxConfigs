{ config, pkgs, ... }:

{
  # Import configuration files
  imports = [
    # ./kernel/zen.nix # Not including reverts kernel to one included in NixOS revision
    ./sys/hardware.nix
    ./sys/services.nix
    # ./sys/flatpak.nix
    # ./sys/bt.nix
    ./sys/hosts.nix
    ./sys/resolved-hosts.nix
    ./sys/docker.nix
    ./sys/plymouth.nix
    ./sys/packages.nix
    # ./sys/nvidia.nix
    # ./sys/silent_boot.nix
    # ./vm-configs/virt-manager.nix
    # ./vm-configs/virtualbox.nix
  ];

  # Bootloader configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 1; # Things can get messy anytime
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
  };

  # Networking configuration
  networking = {
    # wireless = { # https://nixos.org/manual/nixos/stable/#sec-wireless
    #   enable = true;
    #   networks = {
    #     CoudBe = {
    #       pskRaw = "d09b0e129ef70345504752f870e89ba6a831971942cbd76f8394704a2894076b";
    #     };
    #   };
    # };
    firewall.allowedTCPPorts = [ 3389 ];
    networkmanager.enable = true;
    hostName = "nixos";
    nameservers = ["1.1.1.1" "8.8.4.4" "8.8.8.8" "9.9.9.9"]; # Without this will have to add nameservers to /etc/resolv.conf, internet fails without this on chroot, should be declared since not using DHCP, start nameserver from 1.1.1.1 else many sites give SSL errors, also temp fix is enable DoH in browser
  };

  # Documentation configuration
  documentation.man.generateCaches = true; # https://discourse.nixos.org/t/fish-shell-and-manual-page-completion-nixos-home-manager/15661/3

  # Environment configuration
  environment = {
    systemPackages = [ pkgs.home-manager ];
    # pathsToLink = [ "/share/fish" ];
  };

  # Timezone configuration
  time.timeZone = "America/Chicago";

  # Internationalisation properties
  i18n.defaultLocale = "en_US.utf8";

  # Console configuration
  # console = {
  #   earlySetup = true;
  #   font = "${pkgs.terminus_font}/share/consolefonts/ter-v18n.psf.gz"; # setfont ter-132b
  #   packages = with pkgs; [ terminus_font ];
  #   keyMap = "us";
  # };

  # Bootloader EFI configuration
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.kernelModules = [ "amdgpu" ];

  # X server configuration
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # User account & properties
  users.users.bread = {
    isNormalUser = true;
    description = "breadpitt";
    extraGroups = [ "networkmanager" "wheel" "docker" ];

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCa/Azd1aY/4oiNPk6cdubnR8slh5qez7NkDECmdFyyW3TSVmXkzYiOZk0JNr0ExxcEZlLBpu2vwTaOFergbTsyhL7Kwbg5h83Dgy+WK5xA4C02lUD4prFs16wV7l9i9GJjRNAdi+IhBRdXV5CBE13VxH9zhUbOK+dVDMZc174iqBaeXBlWkAPsbtrzZtYvXkwOaJyno0ys3Razg+y0JKuyufyFC9UCVaz2kP3lLeMSMU8Sgs92TeP7zB6y5HOwYJRbYULjv5wOyrwGj+eAT8wJEiuWWoCb2PZMULSgfBW22wblKZYJcGvQXqnHFWPIjxKXEAh8mIz0dy+SAFWVKpCKVXA9POp/2+7YjnmRCfBxcid2rSCLGkCJETUPxSj+c9/HnWDKrVwjR6+IMetBOvZq/ErfmGGGIuDZ7M7xmyvDSv8jDVBZnGm/eB0Jc0ceCwtNhHHwZCWbbF9aOqbwCdqJZ3vPKShWUYcOViqxy3VzViVbN1EIOSrjBYnXaLg4gk= bread@breadpitt"
    ];
  };

  # Security configuration
  security.allowSimultaneousMultithreading = true;
  security.rtkit.enable = true;

  # Hardware OpenGL configuration
  # hardware.opengl = {
  #   enable = true;
  #   driSupport32Bit = true;
  #   setLdLibraryPath = true;
  # };

  # OpenSSH service configuration
  # services.openssh = {
  #   enable = true;
  #   forwardX11 = true;
  # };

  # Maintenance configuration
  # nix = {
  #   autoOptimiseStore = true; # Automatically detects files in the store that have identical contents and replaces with hard links.
  #   gc = {
  #     automatic = true; # Runs nix-collect-garbage which removes old unrefrenced packages
  #     dates = "weekly";
  #     options = "--delete-older-than 7d";
  #   };
  #   settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes
  #   trustedUsers = [ "root" "creator54" ]; # For cachix to work
  # };

  # time.hardwareClockInLocalTime = true;

  # System state version
  system.stateVersion = "24.11"; # Did you read the comment?

  # Virtualisation configuration
  virtualisation.docker.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;

  # Zsh configuration
  programs.zsh = {
    enable = true;
  };

  # Allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
  ];

  # Default user shell
  users.defaultUserShell = pkgs.zsh;
}
