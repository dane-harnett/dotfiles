{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.atuin;
in
{
  options = {
    atuin = {
      enable = lib.mkEnableOption "Enable atuin";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (_final: prev: {
        atuin =
          if prev.stdenv.hostPlatform.isDarwin && prev.atuin.version == "18.23.0" then
            prev.atuin.overrideAttrs (old: {
              # This output-capture test times out in the macOS Nix build.
              # Keep the other tests enabled, including upstream test exclusions.
              checkFlags = (old.checkFlags or [ ]) ++ [
                "--skip=filtered_commands_leave_no_captured_output"
              ];
            })
          else
            prev.atuin;
      })
    ];

    environment.systemPackages = [
      pkgs.atuin
    ];
  };
}
