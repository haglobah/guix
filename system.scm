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
			 (nongnu packages linux)
			 (gnu services databases)
       (gnu packages docker)
       (gnu services docker))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Numenor")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "beat")
                  (comment "Beat Hagenlocher")
                  (group "users")
                  (home-directory "/home/beat")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "docker")))
                %base-user-accounts))
  (groups (cons* (user-group
                    (name "nixbld")
                    (id 30000))
                 %base-groups))
  (packages (append (list (specification->package "nss-certs"))
                    (list docker)
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service docker-service-type)
                 (service gnome-desktop-service-type)
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))

           ;; This is the default list of services we
           ;; are appending
           (modify-services %desktop-services
             (guix-service-type config => (guix-configuration
               (inherit config)
               (substitute-urls
                (append (list "https://substitutes.nonguix.org")
                  %default-substitute-urls))
               (authorized-keys
                (append (list (local-file "./signing-key.pub"))
                  %default-authorized-guix-keys)))))))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "dd18c8c9-dfde-4874-bef2-f819b5e163fb"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "BCE8-1F78"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
