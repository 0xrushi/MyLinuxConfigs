{ config, pkgs, lib, ... }:

{
  # Enable and configure SSH service
  services.openssh = {
    enable = true;
    permitRootLogin = "no"; # Disable root login for security
    passwordAuthentication = false; # Disable password authentication
  };

  # Enable and configure NTP service
  services.ntp = {
    enable = true;
    servers = [ "pool.ntp.org" ]; # Use NTP pool servers
  };

  # Enable and configure CUPS printing service
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ]; # Use HPLIP drivers
  };


  # Enable and configure Avahi service for network discovery
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

  # Enable and configure Samba service for file sharing
  services.samba = {
    enable = true;
    shares = {
      "public" = {
        path = "/srv/samba/public";
        browseable = true;
        readOnly = false;
        guestOk = true;
      };
    };
  };

  # Enable and configure X server
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true; # Touchpad support generally enabled by most display managers
    displayManager.sddm.enable = true; # Minimal replacement for startx
    desktopManager.plasma5.enable = true;
    xkbVariant = "";
    deviceSection = ''
      Option "TearFree" "true"
    '';
    videoDrivers = [ "nvidia" ];
  };

  # Enable and configure XRDP service
  services.xrdp = {
    enable = true;
    defaultWindowManager = "startplasma-x11";
  };

  # Enable and configure Pipewire service
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # Use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable GNOME Keyring
  services.gnome.gnome-keyring.enable = true; # Fails to save if enabled via home-manager

  # Systemd services which I don't like/use mostly because they increase boot time and I find no issues not having them
  systemd.services = {
    systemd-udev-settle.enable = false;
    NetworkManager-wait-online.enable = false;
    firewall.enable = false;
    systemd-journal-flush.enable = false;
    lvm2-activation-early.enable = false;
    lvm2-activation.enable = false;
  };

  # Light works even without an xsession
  programs.light.enable = true;
}

