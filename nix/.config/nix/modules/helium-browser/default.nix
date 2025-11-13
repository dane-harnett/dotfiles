{
  config,
  lib,
  ...
}:
let
  cfg = config.helium-browser;
in
{
  options = {
    helium-browser = {
      enable = lib.mkEnableOption "Enable helium-browser";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "helium-browser"
      ];
    };
  };
}
