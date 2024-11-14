{
  config,
  lib,
  ...
}: let
  cfg = config.font-jetbrains-mono-nerd-font;
in {
  options = {
    font-jetbrains-mono-nerd-font = {
      enable = lib.mkEnableOption "Enable font-jetbrains-mono-nerd-font";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "font-jetbrains-mono-nerd-font"
      ];
    };
  };
}
