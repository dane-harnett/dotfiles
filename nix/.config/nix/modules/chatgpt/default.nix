{
  config,
  lib,
  ...
}:
let
  cfg = config.chatgpt;
in
{
  options = {
    chatgpt = {
      enable = lib.mkEnableOption "Enable ChatGPT";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      casks = [
        "chatgpt"
      ];
    };
  };
}
