{
  config,
  lib,
  ...
}:
let
  cfg = config.tree-sitter;
in
{
  options = {
    tree-sitter = {
      enable = lib.mkEnableOption "Enable tree-sitter";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = [
        "tree-sitter"
      ];
    };
  };
}
