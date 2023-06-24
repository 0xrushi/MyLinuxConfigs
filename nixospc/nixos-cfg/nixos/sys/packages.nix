{ config, pkgs, ... }:

  let
    unstableTarball = fetchTarball https://releases.nixos.org/nixpkgs/nixpkgs-21.05pre286178.ff13163e3fd/nixexprs.tar.xz;
  in
  {
    nixpkgs.config = {
      packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
    };
  
  
  # Allow Properietry packages
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
  ];

  # Some fonts
   fonts.fonts = with pkgs; [
     fira-code fira-code-symbols
     cascadia-code
     source-code-pro
     twemoji-color-font
   ];
}

# https://stackoverflow.com/questions/48831392/how-to-add-nixos-unstable-channel-declaratively-in-configuration-nix
# https://channels.nixos.org/

