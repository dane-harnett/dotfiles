{
  config,
  lib,
  ...
}:
let
  cfg = config.tree-sitter-cli;
in
{
  options = {
    tree-sitter-cli = {
      enable = lib.mkEnableOption "Enable tree-sitter-cli";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "tree-sitter-cli"
      ];
    };
  };
}
