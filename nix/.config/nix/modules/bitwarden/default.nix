{
  config,
  lib,
  ...
}: let
  cfg = config.bitwarden;
in {
  options = {
    bitwarden = {
      enable = lib.mkEnableOption "Enable bitwarden";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "bitwarden"
      ];
    };
  };
}
