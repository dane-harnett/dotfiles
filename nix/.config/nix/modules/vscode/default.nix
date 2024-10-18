{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.vscode;
in {
  options = {
    vscode = {
      enable = lib.mkEnableOption "Enable vscode";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.vscode
    ];
    system.defaults = {
      dock.persistent-apps = [
        "/Applications/Nix Apps/Visual Studio Code.app"
      ];
    };
  };
}
