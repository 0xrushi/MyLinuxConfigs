{ config, pkgs, lib, ... }:


{
  #docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    extraOptions = "--config-file=${pkgs.writeText "daemon.json" (builtins.toJSON {
      data-root ="/run/media/bread/84d83a2f-1dce-43fe-89c9-83e8c0df271d/doraemon/pavandockershit";
      storage-driver = "overlay";
    })}";
  };
  users.users.bread.extraGroups = ["docker"];
  # https://stackoverflow.com/questions/24309526/how-to-change-the-docker-image-installation-directory
  # https://github.com/NixOS/nixpkgs/issues/68349

}
