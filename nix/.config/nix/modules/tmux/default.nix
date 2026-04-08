{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.tmux;
in
{
  options = {
    tmux = {
      enable = lib.mkEnableOption "Enable tmux";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.tmux
    ];
  };
}
