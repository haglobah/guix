;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-module (haglobah config home)
  #:use-module (gnu home)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix gexp))

(define base-packages
    (list
      "openssh"
      "curl"
      "glibc-locales"))

(define desktop-packages
    (list
      "signal-desktop"
      "telegram-desktop"
      "flatpak"
      "gnome-tweaks"
      "xdg-desktop-portal"
      "xdg-desktop-portal-gtk"
      "firefox"
      "ungoogled-chromium"
      "syncthing"
      "guix-icons"))

(define dev-packages
    (list
      "git"
      "racket"
      "erlang"
      "elixir"
      "gcc-toolchain"
      "make"
      "inotify-tools"
      "emacs"
      "vscodium"))

(define font-packages
   (list
    "font-awesome"
    "font-dejavu"
    "font-fira-code"
    "font-gnu-freefont"
    "font-hack"))

(define home-env
 (home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  #;(packages
   (specifications->packages
    `(,@base-packages
      ,@desktop-packages
      ,@dev-packages
      ,@font-packages)))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '((".." . "cd ..")
                              ("cp" . "cp -i")
                              ("h" . "history")
                              ("libpath" . "echo -e ${LD_LIBRARY_PATH//:/\\\\n}")
                              ("la" . "ll -A")
                              ("ll" . "ls -lv --group-directories-first")
                              ("lr" . "ll -R")
                              ("ls" . "ls -p --color")
                              ("mv" . "mv -i")
                              ("path" . "echo -e ${PATH//:/\\\\n}")
                              ("rm" . "rm -i")
                              ("which" . "type -a")

                              ("grep" . "grep --color=auto")
                              ("taru" . "tar -xvf")
                              ("tarz" . "tar -cvf")

                              ("ga" . "git add")
                              ("gu" . "git restore --staged")
                              ("gb" . "git branch -a -v")
                              ("gsw" . "git switch")
                              ("gcb" . "git checkout -b")
                              ("gcm" . "git commit -m")
                              ("gco" . "git checkout")
                              ("gf" . "git pull")
                              ("gl" . "git log --oneline --decorate --graph")
                              ("gp" . "git push")
                              ("gra" . "git remote add")
                              ("grv" . "git remote -v")
                              ("gs" . "git status -s -b")
                              ("gst" . "git status")

                              ("xsh" . "guix shell")
                              ("xp" . "guix package")
                              ("xsw" . "guix package --switch-generation")
                              ("xrb" . "guix package --roll-back")
                              ("xl" . "guix package --list-installed")
                              ("xlg" . "guix package --list-generations")
                              ("xi" . "guix install")
                              ("xup" . "guix package --do-not-upgrade='racket|telegram|vscodium' -u")
                              ("xu" . "guix package -r")
                              ("xse" . "guix search")
                              ("xpa" . "guix pack")
                              ("xh" . "guix home")
                              ("xhre" . "guix home reconfigure")
                              ("xs" . "guix system")
                              ("xsl" . "guix system list-generations")
                              ("xssw" . "guix system switch-generations")
                              ("xsre" . "sudo -E guix system reconfigure")
                              ("x" . "guix")

                              ("nix" . "sudo -i nix")

                              ("start_psql_db" . "/gnu/store/qyyvxss45hqi000wwxkbil7qmgr1ra08-postgresql-10.21/bin/pg_ctl -D /var/lib/postgresql/data -l logfile start")
                              ("obs" . "flatpak run md.obsidian.Obsidian")
                            ))
                   (bashrc (list (local-file ".bashrc" "bashrc")))
                   (bash-profile (list (local-file
                                        ".bash_profile"
                                        "bash_profile")))))))))

home-env
