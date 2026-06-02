{
  boot = {
    loader = {
      timeout = 15;
      grub = {
        devices = ["nodev"];
        theme = ./theme;
        splashImage = null;
        extraEntries = ''
          menuentry 'Zorin' --class zorin --class gnu-linux --class gnu --class os {
            insmod gzio
            insmod part_gpt
            insmod ext2
            search --no-floppy --fs-uuid --set=root c871e425-8e39-4ed1-a294-d9fdee9e051f
            linux /boot/vmlinuz-6.8.0-51-generic root=UUID=c871e425-8e39-4ed1-a294-d9fdee9e051f ro rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1 rcutree.rcu_idle_gp_delay=1 quiet splash amd_iommu=on iommu=pt
            initrd /boot/initrd.img-6.8.0-51-generic
          }

          menuentry 'Windows' --class windows --class os {
            insmod part_gpt
            insmod fat
            search --no-floppy --fs-uuid --set=root F28E-ECDB
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };

    plymouth = {
      enable = true;
      theme = "spinner";
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
