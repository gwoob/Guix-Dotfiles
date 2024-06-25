;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (gnu home services desktop)
             (gnu home services shells)
	     (gnu home services sound)
	     (gnu packages xdisorg)
	     (gnu packages zig-xyz)
	     (gnu packages librewolf)
	     (gnu packages terminals)
	     (gnu packages emacs)
	     (gnu packages freedesktop)
	     (gnu packages pulseaudio)
	     (gnu packages fonts)
	     (gnu packages wm)
	     (gnu packages shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
 (packages (list zsh
		 wl-clipboard
		 river
		 bemenu
		 librewolf
		 foot
		 emacs-next-pgtk
		 xdg-user-dirs
		 pavucontrol
		 font-fira-code
		 sandbar
		 fzf))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list
    (service home-dbus-service-type)
    (service home-pipewire-service-type))))
;;    (service home-bash-service-type
;;                  (home-bash-configuration
;;                   (aliases '(("grep" . "grep --color=auto")
;;                              ("ip" . "ip -color=auto")
;;                              ("ll" . "ls -l")
;;                              ("ls" . "ls -p --color=auto")))
;;                   (bashrc (list (local-file
;;                                  "/home/ben/src/guix-config/.bashrc" "bashrc")))
;;                   (bash-profile (list (local-file
;;                                        "/home/ben/src/guix-config/.bash_profile"
;;                                        "bash_profile"))))))))
