{
  config,
  lib,
  ...
}: let
  cfg = config.gnu-sed;
in {
  options = {
    gnu-sed = {
      enable = lib.mkEnableOption "Enable gnu-sed";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "gnu-sed"
      ];
    };
  };
}
