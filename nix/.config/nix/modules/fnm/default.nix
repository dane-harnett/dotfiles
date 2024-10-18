{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.fnm;
in {
  options = {
    fnm = {
      enable = lib.mkEnableOption "Enable fnm";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fnm
    ];
  };
}
