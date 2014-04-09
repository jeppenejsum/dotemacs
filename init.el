(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings starter-kit-js color-theme-solarized)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq user-full-name "Jeppe Nejsum Madsen")
(setq user-mail-address "jeppe@ingolfs.dk")

(defun system-name() "jnm.ingolfs.dk")

;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(global-linum-mode t)

;; relocate other files so we don't clutter $HOME
(setq save-place-file "~/.emacs.d/save-places")
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(setq url-configuration-directory "~/.emacs.d/url.d")
(setq gamegrid-user-score-file-directory "~/.emacs.d/games.d")
(setq auto-save-list-file-prefix "~/.emacs.d/auto-save-list.d/")
(setq backup-by-copying t)
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/auto-save-list.d/" t)))

(setq backup-directory-alist
     (cons '("." . "~/.emacs.d/backups")
           backup-directory-alist))

(setq gnus-home-directory "~/.emacs.d/gnus.d/")
(setq gnus-directory "~/.emacs.d/gnus.d/News/")
(setq message-directory "~/.emacs.d/gnus.d/Mail/")
(setq nnfolder-directory "~/.emacs.d/gnus.d/Mail/archive/")
(setq gnus-init-file "~/.emacs.d/gnus.d/init")

(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-smtp-server "smtp.gmail.com"
      starttls-use-gnutls t
      smtpmail-default-smtp-server "smtp.gmail.com"
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      smtpmail-auth-credentials (expand-file-name "~/.authinfo"))

;; Use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;; turn on syntax hilighting
(global-font-lock-mode 1)

(load "progmodes")

(require 'server)
(unless (server-running-p)
  (server-start))

(put 'upcase-region 'disabled nil)

(yas-global-mode 1)

;; Local Variables:
;; eval: (add-hook 'after-save-hook 'emacs-lisp-byte-compile t t)
;; End:
