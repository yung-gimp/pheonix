{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.cm.programs.media;
in
{
  options.cm.programs.media.enable = lib.mkEnableOption "Enable media stuff";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.stremio ];
    home.persistence.${config.cm.perDir}.directories = [
      ".stremio-server"
      ".local/share/Smart Code ltd/Stremio"
    ];
  };
}
