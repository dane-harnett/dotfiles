{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim;
in
{
  options = {
    neovim = {
      enable = lib.mkEnableOption "Enable neovim";
      packageSource = lib.mkOption {
        type = lib.types.enum [
          "nixpkgs"
          "brew"
        ];
        default = "nixpkgs";
        description = "Which package manager to use for neovim";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optional (cfg.packageSource == "nixpkgs") pkgs.neovim;
    homebrew = lib.mkIf (cfg.packageSource == "brew") {
      enable = true;
      brews = [ "neovim" ];
    };
  };
}
