{
  config,
  lib,
  ...
}: let
  cfg = config.yt-dlp;
in {
  options = {
    yt-dlp = {
      enable = lib.mkEnableOption "Enable yt-dlp";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "yt-dlp"
      ];
    };
  };
}
