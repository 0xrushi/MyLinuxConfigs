{ config, pkgs,... }:

{
  nixpkgs.overlays = [ (import ./plymouth-themes) ];
  boot = {
    kernelParams = [ "quiet" "splash" "vga=current" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" ];
    consoleLogLevel = 0;
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth ];
      theme = "blockchain";
    };
    initrd.verbose = false;
  };
}
