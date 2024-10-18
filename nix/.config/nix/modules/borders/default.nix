{
  config,
  lib,
  ...
}: let
  cfg = config.borders;
in {
  options = {
    borders = {
      enable = lib.mkEnableOption "Enable borders";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        {
          name = "FelixKratz/formulae/borders";
          restart_service = true;
        }
      ];
      taps = [
        "FelixKratz/formulae"
      ];
    };
  };
}
