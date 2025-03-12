{
  config,
  lib,
  pkgs,
  ...
}:
let

  cfg = config.ff.services.getty;

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
  options.ff.services.getty = {
    autologinUser = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Username of the account that will be automatically logged in at the console.
        If unspecified, a login prompt is shown as usual.
      '';
    };

  };
  config = {
    services.kmscon.enable = true;
    systemd.services."getty@tty2" = {
      serviceConfig.ExecStart = [
        "" # override upstream default with an empty ExecStart
        (gettyCmd "--noclear --keep-baud pts/tty2 115200,38400,9600 $TERM")
      ];
      environment.TTY = "tty2";
      restartIfChanged = false;
    };
  };
}
