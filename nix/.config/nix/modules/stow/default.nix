{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.stow;
in {
  options = {
    stow = {
      enable = lib.mkEnableOption "Enable stow";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.stow
    ];
  };
}
