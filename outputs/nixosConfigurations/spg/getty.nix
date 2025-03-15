{
  config,
  lib,
  pkgs,
  ...
}:
let

  cfg = config.ff.services.kmscon;

  ttyId = cfg.disableAt;

  baseArgs =
    [
      "--login-program"
      "${pkgs.shadow}/bin/login"
    ]
    ++ lib.optionals (cfg.autologinUser != null) [
      "--autologin"
      cfg.autologinUser
    ];

  gettyCmd = args: "${lib.getExe' pkgs.util-linux "agetty"} ${lib.escapeShellArgs baseArgs} ${args}";

in
{
  options.ff.services.kmscon = {

    enable = lib.mkEnableOption "Enable kms console";

    autologinUser = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Username of the account that will be automatically logged in at the console.
        If unspecified, a login prompt is shown as usual.
      '';
    };

    disableAt = lib.mkOption {
      type = lib.types.nullOr lib.listOf lib.types.int;
      default = null;
      description = "Numeric identifier of ttys that should not use the kms console";
      example = [
        "2"
        "3"
        "4"
      ];
    };

  };
  config = lib.mkIf cfg.enable {
    services.kmscon.enable = true;
    systemd = {
      services."kmsconvt@tty${ttyId}".enable = false;
      services."getty@tty${ttyId}" = {
        enable = true;
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = [
          "" # override upstream default with an empty ExecStart
          (gettyCmd "--noclear --keep-baud pts/tty2 115200,38400,9600 $TERM")
        ];
        environment.TTY = "tty${ttyId}";
        restartIfChanged = false;
      };
    };
  };
}
