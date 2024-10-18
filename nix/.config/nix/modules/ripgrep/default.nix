{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ripgrep;
in {
  options = {
    ripgrep = {
      enable = lib.mkEnableOption "Enable ripgrep";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ripgrep
    ];
  };
}
