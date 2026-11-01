{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.atuin;
  darwinTestSkips = {
    # This output-capture test times out in the macOS Nix build.
    "18.23.0" = [ "filtered_commands_leave_no_captured_output" ];

    # These Pi session tests report a running session in the macOS Nix build.
    "18.24.4" = [
      "a_diverged_copy_resumes_only_as_chosen::agent_4_Agent__Pi"
      "a_session_gone_on_with_elsewhere_catches_up_where_it_came_from::agent_3_Agent__Pi"
    ];
  };
in
{
  options = {
    atuin = {
      enable = lib.mkEnableOption "Enable atuin";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (
        _final: prev:
        let
          skippedTests = darwinTestSkips.${prev.atuin.version} or [ ];
        in
        {
          atuin =
            if prev.stdenv.hostPlatform.isDarwin && skippedTests != [ ] then
              prev.atuin.overrideAttrs (
                old:
                {
                  # Keep the other tests enabled, including upstream test exclusions.
                  checkFlags = (old.checkFlags or [ ]) ++ map (name: "--skip=${name}") skippedTests;
                }
                // lib.optionalAttrs (prev.atuin.version == "18.24.4") {
                  # Parallel daemon tests can terminate the test process on macOS.
                  dontUseCargoParallelTests = true;
                }
              )
            else
              prev.atuin;
        }
      )
    ];

    environment.systemPackages = [
      pkgs.atuin
    ];
  };
}
