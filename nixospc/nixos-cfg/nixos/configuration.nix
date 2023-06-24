{ config, pkgs, ... }:

{
  imports =
    [
      # ./kernel/zen.nix #not including reverts kernel to one included in nixos revision
      ./sys/hardware.nix
      ./sys/services.nix
      #./sys/flatpak.nix
      #./sys/bt.nix
      ./sys/hosts.nix
      ./sys/resolved-hosts.nix
      ./sys/docker.nix
      ./sys/plymouth.nix
      ./sys/packages.nix
      #./sys/nvidia.nix
      #./sys/silent_boot.nix
      #./vm-configs/virt-manager.nix
      #./vm-configs/virtualbox.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      timeout = 1; #things can get messy anytime
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
  };

  # networking
  networking = {
    #wireless = { #https://nixos.org/manual/nixos/stable/#sec-wireless
    #  enable = true;
    #  networks = {
    #    CoudBe = {
    #      pskRaw = "d09b0e129ef70345504752f870e89ba6a831971942cbd76f8394704a2894076b";
    #    };
    #  };
    #};
    firewall.allowedTCPPorts = [ 3389 ];
    networkmanager.enable = true;
    hostName = "nixos";
    nameservers = ["1.1.1.1" "8.8.4.4" "8.8.8.8" "9.9.9.9"]; #without this will have to add nameserves to /etc/resolv.conf , internet fails without this on chroot, should be declared since not using dhcp, start nameserver from 1.1.1.1 else many sites give SSL errors, also temp fix is enable DoH in browser
  };

  documentation.man.generateCaches = true; #https://discourse.nixos.org/t/fish-shell-and-manual-page-completion-nixos-home-manager/15661/3

  environment = {
    systemPackages = [ pkgs.home-manager ];
    # pathsToLink = [ "/share/fish" ];
  };


  time.timeZone = "America/Chicago";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";


  #console = {
  #  earlySetup = true;
  #  font = "${pkgs.terminus_font}/share/consolefonts/ter-v18n.psf.gz"; #setfont ter-132b
  #  packages = with pkgs; [ terminus_font ];
  #  keyMap = "us";
  #};

  # useraccount & properties
  users.users.bread = {
    isNormalUser = true;
    description = "breadpitt";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
      kate
      chromium
     thunderbird
    ];

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCa/Azd1aY/4oiNPk6cdubnR8slh5qez7NkDECmdFyyW3TSVmXkzYiOZk0JNr0ExxcEZlLBpu2vwTaOFergbTsyhL7Kwbg5h83Dgy+WK5xA4C02lUD4prFs16wV7l9i9GJjRNAdi+IhBRdXV5CBE13VxH9zhUbOK+dVDMZc174iqBaeXBlWkAPsbtrzZtYvXkwOaJyno0ys3Razg+y0JKuyufyFC9UCVaz2kP3lLeMSMU8Sgs92TeP7zB6y5HOwYJRbYULjv5wOyrwGj+eAT8wJEiuWWoCb2PZMULSgfBW22wblKZYJcGvQXqnHFWPIjxKXEAh8mIz0dy+SAFWVKpCKVXA9POp/2+7YjnmRCfBxcid2rSCLGkCJETUPxSj+c9/HnWDKrVwjR6+IMetBOvZq/ErfmGGGIuDZ7M7xmyvDSv8jDVBZnGm/eB0Jc0ceCwtNhHHwZCWbbF9aOqbwCdqJZ3vPKShWUYcOViqxy3VzViVbN1EIOSrjBYnXaLg4gk= bread@breadpitt"
    ];
  };

  security.allowSimultaneousMultithreading = true;
  security.rtkit.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    setLdLibraryPath = true;
  };

  #services.openssh = {
  #  enable = true;
  #  forwardX11 = true;
  #};

  # Maintainence
#   nix = {
#     autoOptimiseStore = true; #automatically detects files in the store that have identical contents and replaces with hard links.
#     gc = {
#       automatic = true; 				# runs nix-collect-garbage which removes old unrefrenced packages
#       dates = "weekly";
#       options = "--delete-older-than 7d";
#     };
#     settings.experimental-features = [ "nix-command" "flakes" ]; #enable flakes
#     trustedUsers = [ "root" "creator54" ]; #for cachix to work
#   };

#   time.hardwareClockInLocalTime = true;


  system.stateVersion = "22.05"; # Did you read the comment?
  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true; 

 programs.zsh = {
  enable = true;
};

users.defaultUserShell = pkgs.zsh;

}
