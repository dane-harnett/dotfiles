{
  config,
  lib,
  ...
}:
let
  cfg = config.fluidvoice;
in
{
  options = {
    fluidvoice = {
      enable = lib.mkEnableOption "Enable fluidvoice";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "fluidvoice"
      ];
    };
  };
}
