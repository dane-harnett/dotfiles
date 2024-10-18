{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.neovim;
in {
  options = {
    neovim = {
      enable = lib.mkEnableOption "Enable neovim";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.neovim
    ];
  };
}
