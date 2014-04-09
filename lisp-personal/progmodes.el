
(show-paren-mode 1)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/scala-mode"))

(require 'scala-mode)
(require 'ruby-mode)
(require 'nodejs-repl)

(defun me-turn-off-indent-tabs-mode ()
  (setq indent-tabs-mode nil))
(add-hook 'scala-mode-hook 'me-turn-off-indent-tabs-mode)
(add-hook 'ruby-mode-hook 'turn-off-auto-fill)

(add-hook 'js2-mode-hook
          (lambda () (progn
                  (auto-fill-mode 0)
                  (setq js2-basic-offset 8)
                  (message "js2 hook")
                  (add-hook 'write-contents-functions
                            (lambda () (progn
                                    (message "save hook")
                                    (tabify (point-min) (point-max))
                                    (delete-trailing-whitespace))))
                  (setq indent-tabs-mode t))))


;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ps1$" . powershell-mode))
(add-to-list 'auto-mode-alist '("\\.asp$" . asp-mode))
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

(autoload 'powershell-mode "powershell-mode" "Powershell editing mode." nil t)
(autoload 'asp-mode "asp-mode" "ASP editing mode." nil t)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(global-set-key "\M-;" 'evilnc-comment-or-uncomment-lines)
(global-set-key "\M-:" 'evilnc-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-.") 'ac-expand)

;; Local Variables:
;; eval: (add-hook 'after-save-hook 'emacs-lisp-byte-compile t t)
;; End:

