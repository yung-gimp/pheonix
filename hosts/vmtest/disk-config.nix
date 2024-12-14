{
  disko.devices = {
    disk.nix = {
      type = "disk";
      device = "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00003";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "nixcrypt";
              settings.allowDiscards = true;
              passwordFile = "/tmp/root.key";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                postMountHook = ''
                  mkdir -p /mnt/disko-install-root/nix/persist/root && cp /tmp/home.key /mnt/disko-install-root/nix/persist/root/home.key
                '';
                subvolumes = {
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress-force=zstd:1" "noatime" ];
                  };
                  "swap" = {
                    mountpoint = "/.swap";
                    mountOptions = [ "compress-force=zstd:1" "noatime" ];
                    swap.swapfile.size = "8G";
                  };
                };
              };
            };
          };
        };
      };
    };

    disk.home = {
      type = "disk";
      device = "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00005";
      content = {
        type = "luks";
        name = "homecrypt";
        settings.allowDiscards = true;
        settings.keyFile = "/tmp/home.key";
        initrdUnlock = false;  # don't unlock at boot
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ];
          subvolumes = {
            "home" = {
              mountpoint = "/nix/persist/home";
              mountOptions = [ "compress-force=zstd:1" "noatime"];
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "size=3G" "mode=755" ];
    };
  };
}
