{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "ahci"
    "virtio_pci"
    "xhci_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
    "usbhid"
    "hid_generic"
  ];
  boot.kernelModules = [ "kvm-amd" ];
}
