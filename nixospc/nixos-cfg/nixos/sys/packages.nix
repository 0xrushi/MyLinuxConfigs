{ config, pkgs, ... }:

let
 unstableTarball = fetchTarball https://channels.nixos.org/nixos-unstable;
in
{
 nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
 };

 # Allow Proprietary packages
 nixpkgs.config.allowUnfree = true;

 # Define system packages
 environment.systemPackages = with pkgs; [
    wget         # Network downloader
    vim          # Text editor
    htop         # Interactive process viewer
    feh
    nox
    git          # Version control system
    github-cli
    gnumake
    firefox      # Web browser
    chromium
    microsoft-edge
    konsole
    fortune
    capitaine-cursors
    # bibata-extra-cursors
    papirus-maia-icon-theme
    adapta-gtk-theme #dark theme
    meld
    gpick
    nitrogen
    vscode
    discord
    tdesktop
    mcfly
    unzip
    mendeley
    ncdu
    obsidian
    mpv
    vlc          # Media player
    obs-studio
    nix-direnv
    ulauncher
    libarchive
    go
    sshuttle
    firefox
    kate
    chromium
    thunderbird  # Email client
    vscode
    clinfo
    zed
    zed-editor
    brave
    curl         # Command-line tool for transferring data
    tree         # Directory listing program
    neofetch     # System information tool
    gimp         # Image editor
    libreoffice  # Office suite
 ];

 # Define user-specific packages
 users.users.bread = {
    packages = with pkgs; [
      fish        # Friendly interactive shell
      tmux        # Terminal multiplexer
      zsh         # Z shell
      # Add more user-specific packages as needed
    ];
 };

 # Some fonts
 fonts.fonts = with pkgs; [
    fira-code fira-code-symbols
    cascadia-code
    source-code-pro
    twemoji-color-font
 ];
}
