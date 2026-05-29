{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ghostty;
in
{
  options = {
    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ghostty-bin
    ];
  };
}
