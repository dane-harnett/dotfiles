{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.pi-coding-agent;
in
{
  options = {
    pi-coding-agent = {
      enable = lib.mkEnableOption "Enable pi-coding-agent";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.pi-coding-agent
    ];
  };
}
