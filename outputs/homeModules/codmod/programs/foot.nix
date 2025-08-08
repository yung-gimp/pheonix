{
  config,
  lib,
  ...
}: let
  cfg = config.cm.programs.foot;
in {
  options.cm.programs.foot.enable = lib.mkEnableOption "Enable foot terminal";

  config.programs.foot = lib.mkIf cfg.enable {
    enable = true;
    server.enable = true;
    settings = {};
  };
}
