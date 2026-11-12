{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.fnm;
in
{
  options = {
    fnm = {
      enable = lib.mkEnableOption "Enable fnm";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.fnm.overrideAttrs (old: {
        # The Rust build hook requires system zstd, but fnm omits its build inputs.
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
        buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.zstd ];
      }))
    ];
  };
}
