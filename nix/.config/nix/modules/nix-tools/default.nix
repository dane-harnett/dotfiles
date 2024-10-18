{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nix-tools;
in {
  options = {
    nix-tools = {
      enable = lib.mkEnableOption "Enable nix-tools";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nixpkgs-fmt
    ];
  };
}
