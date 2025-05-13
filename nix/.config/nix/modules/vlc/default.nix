{
  config,
  lib,
  ...
}: let
  cfg = config.vlc;
in {
  options = {
    vlc = {
      enable = lib.mkEnableOption "Enable vlc";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "vlc"
      ];
    };
  };
}
