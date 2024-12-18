{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/etc/nixos"
    ];
    files = [
      
    ];
  };
}
