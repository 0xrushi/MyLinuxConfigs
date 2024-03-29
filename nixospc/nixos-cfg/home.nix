# { config, pkgs, lib, ... }:

# {
#   imports = [
#     ./wm/dwm.nix
#     ./wm/wm-pkgs.nix
#     ./pkgs/general.nix
#     ./pkgs/firefox.nix
#   ];

#   home = {
#     username = "creator54";
#     stateVersion = "22.05"; #do not touch
#     homeDirectory = "/home/creator54";
#     enableNixpkgsReleaseCheck = true;

#     file = {
#       ".config/gromit-mpx.ini".source                       = ./configs/gromit-mpx.ini;
#       ".config/flameshot".source                            = ./configs/flameshot;
#       ".config/fish".source                                 = ./configs/fish;
#       ".config/xplr".source                                 = ./configs/xplr;
#       ".config/mpv/scripts".source                          = ./configs/mpv/scripts;
#       ".config/mpv/script-opts/youtube-quality.conf".source = ./configs/mpv/youtube-quality.conf;
#       ".config/gtk-3.0".source                              = ./configs/gtk-3.0;
#       ".config/htop".source                                 = ./configs/htop;
#       ".icons".source                                       = ./configs/icons;
#       ".xinitrc".source                                     = ./configs/xinitrc;
#       ".Xresources".source                                  = ./configs/Xresources;
#     };
#   };
# }
 

 programs.zsh = {
  enable = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
    zplug = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
    ];
  };
    ohMyZsh = {
    enable = true;
    plugins = [ "git" "thefuck" ];
    theme = "robbyrussell";
  };
};