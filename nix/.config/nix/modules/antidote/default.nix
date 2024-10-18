{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.antidote;
in {
  options = {
    antidote = {
      enable = lib.mkEnableOption "Enable antidote";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.antidote
    ];
  };
}
