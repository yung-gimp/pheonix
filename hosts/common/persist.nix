{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/etc/nixos"
    ];
    files = [
      { file = "/root/home.key"; parentDirectory.mode = "0600"; }
    ];
  };
}
