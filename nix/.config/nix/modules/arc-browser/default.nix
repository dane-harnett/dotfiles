{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.arc-browser;
in {
  options = {
    arc-browser = {
      enable = lib.mkEnableOption "Enable arc-browser";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.arc-browser
    ];
    system.defaults = {
      dock.persistent-apps = [
        "/Applications/Nix Apps/Arc.app"
      ];
    };
  };
}
