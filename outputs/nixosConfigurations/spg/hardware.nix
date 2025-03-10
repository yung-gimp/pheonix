{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    # initrd.includeDefaultModules = true;
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "usbhid"
      "i8042"
    ];
    kernelModules = [ "kvm-intel" ];
  };
}
