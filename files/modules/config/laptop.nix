{ ... }:
{
  services = {
    logind = {
      # Laptop lid behavior
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      lidSwitchDocked = "ignore";
    };

    # Disable built-in Gnome power management daemon
    power-profiles-daemon.enable = false;
    # Enable TLP power management daemon
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE="1";
        TLP_WARN_LEVEL="3";
        TLP_MSG_COLORS="91 93 1 92";
        TLP_PERSISTENT_DEFAULT="0";
        DISK_IDLE_SECS_ON_AC="0";
        DISK_IDLE_SECS_ON_BAT="2";
        MAX_LOST_WORK_SECS_ON_AC="15";
        MAX_LOST_WORK_SECS_ON_BAT="60";
        CPU_ENERGY_PERF_POLICY_ON_AC="performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT="power";
        PLATFORM_PROFILE_ON_AC="performance";
        PLATFORM_PROFILE_ON_BAT="low-power";
        CPU_BOOST_ON_AC="1";
        CPU_BOOST_ON_BAT="0";
        NMI_WATCHDOG="0";
        DISK_DEVICES="nvme0n1 sda";
        DISK_APM_LEVEL_ON_AC="254 254";
        DISK_APM_LEVEL_ON_BAT="128 128";
        DISK_APM_CLASS_DENYLIST="usb ieee1394";
        DISK_IOSCHED="keep keep";
        SATA_LINKPWR_ON_AC="med_power_with_dipm";
        SATA_LINKPWR_ON_BAT="med_power_with_dipm";
        AHCI_RUNTIME_PM_ON_AC="on";
        AHCI_RUNTIME_PM_ON_BAT="auto";
        AHCI_RUNTIME_PM_TIMEOUT="15";
        PCIE_ASPM_ON_AC="default";
        PCIE_ASPM_ON_BAT="default";
        RADEON_DPM_PERF_LEVEL_ON_AC="auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT="auto";
        AMDGPU_ABM_LEVEL_ON_AC="0";
        AMDGPU_ABM_LEVEL_ON_BAT="3";
        WIFI_PWR_ON_AC="off";
        WIFI_PWR_ON_BAT="on";
        WOL_DISABLE="Y";
        SOUND_POWER_SAVE_ON_AC="1";
        SOUND_POWER_SAVE_ON_BAT="1";
        SOUND_POWER_SAVE_CONTROLLER="Y";
        BAY_POWEROFF_ON_AC="0";
        BAY_POWEROFF_ON_BAT="0";
        BAY_DEVICE="sr0";
        RUNTIME_PM_ON_AC="on";
        RUNTIME_PM_ON_BAT="auto";
        RUNTIME_PM_DRIVER_DENYLIST="mei_me nouveau radeon xhci_hcd";
        USB_AUTOSUSPEND="1";
        USB_EXCLUDE_AUDIO="1";
        USB_EXCLUDE_BTUSB="0";
        USB_EXCLUDE_PHONE="0";
        USB_EXCLUDE_PRINTER="1";
        USB_EXCLUDE_WWAN="0";
        RESTORE_DEVICE_STATE_ON_STARTUP="0";
        RESTORE_THRESHOLDS_ON_BAT="0";
        NATACPI_ENABLE="1";
        TPSMAPI_ENABLE="1";
        START_CHARGE_THRESH_BAT0="75";
        STOP_CHARGE_THRESH_BAT0="80";
        # DEVICES_TO_ENABLE_ON_STARTUP="bluetooth wifi wwan";
      };
    };
  };
}
