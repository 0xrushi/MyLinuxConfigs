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

 environment.systemPackages = with pkgs; [
    wget vim htop feh nox git github-cli
    gnumake
    firefox
    chromium
    microsoft-edge
    konsole
    fortune
    capitaine-cursors
    # bibata-extra-cursors
    papirus-maia-icon-theme
    adapta-gtk-theme #dark theme
    meld
    colorpicker
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
    vlc
    obs-studio
    nix-direnv
    ulauncher
    libarchive
    go
    sshuttle
    python311Packages.keep
 ];

 # Some fonts
 fonts.fonts = with pkgs; [
    fira-code fira-code-symbols
    cascadia-code
    source-code-pro
    twemoji-color-font
 ];
}
