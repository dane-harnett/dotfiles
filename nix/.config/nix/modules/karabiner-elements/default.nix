{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.karabiner-elements;
in
{
  options = {
    karabiner-elements = {
      enable = lib.mkEnableOption "Enable karabiner-elements";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.karabiner-elements
    ];
  };
}
