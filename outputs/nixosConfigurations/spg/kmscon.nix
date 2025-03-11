{ config, pkgs, ... }:
let

  kmsConfDir = pkgs.writeTextFile {
    name = "kmscon-config";
    destination = "/kmscon.conf";
    text = "";
  };

in
{
  config = {
    systemd.services.kmscon = {
      after = [
        "systemd-logind.service"
        "systemd-vconsole-setup.service"
      ];
      requires = [ "systemd-logind.service" ];

      serviceConfig.ExecStart = [
        ""
        ''
          ${pkgs.kmscon}/bin/kmscon "--vt=%I" --seats=seat0 --no-switchvt --configdir ${kmsConfDir} --login -- ${pkgs.shadow}/bin/login -p codman
        ''
      ];

      restartIfChanged = false;
      aliases = [ "autovt@.service" ];
    };

    systemd.suppressedSystemUnits = [ "autovt@.service" ];

    systemd.services.systemd-vconsole-setup.enable = false;
    systemd.services.reload-systemd-vconsole-setup.enable = false;
  };
}
