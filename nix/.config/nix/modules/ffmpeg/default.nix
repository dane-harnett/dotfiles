{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.ffmpeg;
in
{
  options = {
    ffmpeg = {
      enable = lib.mkEnableOption "Enable ffmpeg";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.ffmpeg
    ];
  };
}
