;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (gnu packages linux)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu packages gl)
             (gnu packages shells)
             (guix utils))

(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware sof-firmware))
  (locale "en_US.utf8")
  (timezone "America/Los_Angeles")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "navi")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "ben")
                  (comment "Benjamin Carpenter")
		  (shell (file-append zsh "/bin/zsh"))
                  (group "users")
                  (home-directory "/home/ben")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list mesa)
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service network-manager-service-type)
                 (service wpa-supplicant-service-type)
                 (service ntp-service-type)
                 (service elogind-service-type))

           ;; This is the default list of services we
           ;; are appending to.
           %base-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/efi"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "cac4da52-02e1-48dd-aed0-327b7de6f43a"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "xfs")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/efi")
                         (device (uuid "7625-ABBA"
                                       'fat32))
                         (type "vfat")) %base-file-systems))
  (swap-devices
   (list
    (swap-space
     (target "/swapfile")
     (dependencies (filter (file-system-mount-point-predicate "/")
			   file-systems)))))

  (kernel-arguments
  (cons* "resume=/dev/mapper/cryptroot"        ;device that holds /swapfile
         "resume_offset=1212909"  ;offset of /swapfile on device
	 "modprobe.blacklist=nouveau"
	 "nowatchdog"
	 "modprobe.blacklist=iTCO_wdt"
	 "modprobe.blacklist=sp5100_tco"
	 "amd_pstate=active"
         %default-kernel-arguments)))
