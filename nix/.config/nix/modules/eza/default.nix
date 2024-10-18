{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.eza;
in {
  options = {
    eza = {
      enable = lib.mkEnableOption "Enable eza";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.eza
    ];
  };
}
