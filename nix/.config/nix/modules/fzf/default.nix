{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.fzf;
in {
  options = {
    fzf = {
      enable = lib.mkEnableOption "Enable fzf";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fzf
    ];
  };
}
