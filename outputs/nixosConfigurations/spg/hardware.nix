{ pkgs, lib, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    # loader.systemd-boot.extraFiles = { "/EFI/Microsoft/Boot/bootmgfw.efi" = "/boot/EFI/systemd/systemd-bootx64.efi"; }; # pretend to be windows bootloader because msi sucks
    initrd.systemd.enable = lib.mkForce false;
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "usbhid"
      "hid_generic"
    ];
    kernelModules = [ "kvm-intel" ];
  };
}
