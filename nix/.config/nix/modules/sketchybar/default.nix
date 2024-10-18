{
  config,
  lib,
  ...
}: let
  cfg = config.sketchybar;
in {
  options = {
    sketchybar = {
      enable = lib.mkEnableOption "Enable sketchybar";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        {
          name = "FelixKratz/formulae/sketchybar";
          restart_service = true;
        }
      ];
      casks = [
        "font-hasklug-nerd-font"
      ];
      taps = [
        "FelixKratz/formulae"
      ];
    };
  };
}
