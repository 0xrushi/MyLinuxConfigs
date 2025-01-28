{ config, pkgs, lib, ... }:

{
  virtualisation.docker = {
    rootless.enable = true;
    enable = true;
    enableOnBoot = false;
    enableNvidia = true;
    extraOptions = "--config-file=${pkgs.writeText "daemon.json" (builtins.toJSON {
      data-root = "/mnt/sdc3/dockerc/";
      storage-driver = "overlay2";
    })}";
  };
  users.users.bread.extraGroups = ["docker"];
}