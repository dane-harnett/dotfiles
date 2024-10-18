{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.oh-my-posh;
in {
  options = {
    oh-my-posh = {
      enable = lib.mkEnableOption "Enable oh-my-posh";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.oh-my-posh
    ];
  };
}
