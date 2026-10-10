{
  config,
  lib,
  ...
}:
let
  cfg = config.protonvpn;
in
{
  options = {
    protonvpn = {
      enable = lib.mkEnableOption "Enable protonvpn";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "protonvpn"
      ];
    };
  };
}
