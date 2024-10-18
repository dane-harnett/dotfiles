{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zoxide;
in {
  options = {
    zoxide = {
      enable = lib.mkEnableOption "Enable zoxide";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.zoxide
    ];
  };
}
