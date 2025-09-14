{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.carapace;
in {
  options = {
    carapace = {
      enable = lib.mkEnableOption "Enable carapace";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.carapace
    ];
  };
}
