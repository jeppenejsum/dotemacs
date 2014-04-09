;; -*- emacs-lisp -*-

(setq mail-host-address "ingolfs.dk")

(copy-face 'default 'mysubject)
(setq gnus-face-1 'mysubject)
 
(copy-face 'default 'mytime)
(set-face-foreground 'mytime "grey")
(setq gnus-face-2 'mytime) 
 
(copy-face 'default 'mythreads)
(set-face-foreground 'mythreads "grey") 
(setq gnus-face-3 'mythreads) 
 
(copy-face 'default 'mygrey) 
(set-face-foreground 'mygrey "grey") 
(setq gnus-face-4 'mygrey) 

(copy-face 'default 'myblack) 
(set-face-foreground 'myblack "grey60") 
(setq gnus-face-5 'myblack) 

(copy-face 'default 'mybiggernumbers) 
(set-face-foreground 'mybiggernumbers "indianred4") 
(setq gnus-face-6 'mybiggernumbers)

;(if (featurep 'mule-ucs-autoloads)
;    (;(require 'un-define)
;     (setq gnus-sum-thread-tree-root 
;           (concat (char-to-string (ucs-char 9733)) " "))
;     (setq gnus-sum-thread-tree-false-root 
;           (concat (char-to-string (ucs-char 9734)) " "))
;     (setq gnus-sum-thread-tree-single-indent "")
;     (setq gnus-sum-thread-tree-leaf-with-other
;           (concat (char-to-string (ucs-char 9584))
;                   (char-to-string (ucs-char 8594))
;                   " "))
;     (setq gnus-sum-thread-tree-vertical
;           (concat (char-to-string (ucs-char 9474)) " "))
;     (setq gnus-sum-thread-tree-single-leaf
;           (concat (char-to-string (ucs-char 9584))
;                   (char-to-string (ucs-char 8594))
;                   " ")))
;  )

(setq gnus-summary-line-format (concat 
                                "%*%5{%U%R%z%}" 
                                "%4{|%}" 
                                "%2{%-10&user-date;%}"
                                "%4{|%}"
                                "%4{|%}"
                                "%2{ %}%(%-24,24n"
                                "%4{|%}" 
                                "%2{%5i%}" 
                                "%4{|%}" 
                                "%2{%6k %}%)"
                                "%4{|%}" 
                                "%2{ %}%3{%B%}%1{%s%}\n"))

;(setq gnus-summary-line-format
;      "%U%R%z%(%[%4L%]: %B%-55,55s%) |%uX%f\n")
(setq gnus-summary-same-subject "")

;(when window-system
  (setq gnus-sum-thread-tree-indent "  "
	gnus-sum-thread-tree-root "■ "
	gnus-sum-thread-tree-false-root "〓 "
	gnus-sum-thread-tree-single-indent "■ "
	gnus-sum-thread-tree-leaf-with-other "├─〓 "
	gnus-sum-thread-tree-vertical "│"
	gnus-sum-thread-tree-single-leaf "└─〓 ")


(defun rs-gnus-summary-tree-arrows-wide ()
  "Use tree layout with wide unicode arrows."
  (interactive)
  (setq
   gnus-sum-thread-tree-false-root      "┈┬──▷ "
   gnus-sum-thread-tree-single-indent   " ●  "
   gnus-sum-thread-tree-root            "┌─▶ "
   gnus-sum-thread-tree-vertical        "│"
   gnus-sum-thread-tree-leaf-with-other "├┬─► "
   gnus-sum-thread-tree-single-leaf     "╰┬─► "
   gnus-sum-thread-tree-indent          " ")
  (gnus-message 5 "Using tree layout with wide unicode arrows."))

(rs-gnus-summary-tree-arrows-wide)

;; Startup options
(setq gnus-check-new-newsgroups nil
      gnus-save-killed-list nil
      gnus-agent nil
      gnus-read-active-file nil
      gnus-save-newsrc-file nil
      gnus-read-newsrc-file nil
      gnus-nov-is-evil nil
      gnus-treat-unsplit-urls t
    ;  gnus-treat-fill-long-lines t
      gnus-verbose 10
      gnus-confirm-mail-reply-to-news t 
      gnus-verbose-backends 10
      gnus-local-organization "")

;;; Disable QP for unknown (binary) mime types.
(setq mm-content-transfer-encoding-defaults
  '(("text/x-patch" 8bit)
    ("text/.*" qp-or-base64)
    ("message/rfc822" 8bit)
    ("application/emacs-lisp" 8bit)
    ("application/x-patch" 8bit)
    (".*" base64)))

;; Input sources
(setq gnus-select-method '(nntp "news.dotsrc.org")) 
(setq gnus-secondary-select-methods
      '((nnml "private")))

;; Don't crosspost mail articles
(setq nnmail-crosspost nil)


(defun jnm-rem-string (str sub)
  "Remove sub from str"
  (if (string-match sub str)
      (jnm-rem-string (concat
              (substring str 0 (match-beginning 0))
              (substring str (match-end 0))) sub)
    str))

(defun jnm-gnus-simplify-subject (subject)
  "Remove \"Sv:\" from subject lines."
  (gnus-simplify-whitespace
   (jnm-rem-string
    (jnm-rem-string
     (jnm-rem-string subject "[Ss][Vv] *: *") "[Aw][Ww] *: *")
    "[Rr][Ee] *: *")))

;; (setq gnus-summary-gather-subject-limit 'fuzzy)

;; (setq gnus-simplify-subject-functions
;;       '(jnm-gnus-simplify-subject
;;         gnus-simplify-subject-fuzzy
;;         ))

;; Sorting methods
(setq nnmail-split-methods
      '(("mail.duplicates" "^Gnus-Warning:")
        ("SuperSpam" "^X-Spam-Level: \\*\\*\\*\\*\\*\\*\\*\\*")
        ("Spam" "^X-Spam-Flag: YES")
       	("mail.MythTV" "^Reply-To: mythtvdk@.*")
	("mail.MythTV" "^Subject:.*\\[xmltvdk\\].*")
	("mail.MythTV" "^Subject:.*\\[mythtv\\(-users\\|dk\\)?\\].*")
	("mail.ivtv" "^Subject:.*\\[ivtv-devel\\].*")
	("mail.Algorithm-Forge" "^Subject:.*\\[algorithm-forge\\].*")
	("mail.Texas-Flood" "^Subject:.*\\[Flood\\].*")
        ("mail.Salesforce" "^Subject:.*Community Subscription.*")
        ("mail.Flex" "^Subject:.*\\[flexcoders\\].*")
	("mail.Leaf-user" "^Subject:.*\\[Leaf-user\\].*")
       	("mail.Lists" "^Subject:.*\\[FestoolOwnersGroup\\].*")
;	("mail.Bugtraq" "^\\(To:\\|Cc:\\|CC:\\|Resent\\|Sender:\\).*bugtraq@securityfocus.\\(com\\|org\\)")
;	("mail.Bugtraq" "^\\(To:\\|Cc:\\|CC:\\|Resent\\|Sender:\\).*@cert.org")
;	("mail.Bugtraq" "^Subject:.*\\[SECURITY\\].*")
	("mail.other" "")))

;; Sent items
;(setq gnus-message-archive-group "nnimap:INBOX.Sent") 
; (setq gnus-message-archive-method
;       '(nnfolder "archive"
; 		 (nnfolder-get-new-mail nil)
;                  (nnfolder-inhibit-expiry t)
;                  (nnfolder-directory "~/Mail/sent-mail/")
;                  (nnfolder-active-file "~/Mail/sent-mail/active")))

; (setq gnus-message-archive-group
;       '((if (message-news-p)
;             "sent-news"
;           "sent-mail")))

(add-hook 'gnus-summary-exit-hook 'gnus-summary-bubble-group)

;; Supercite
;;(add-hook 'mail-citation-hook 'trivial-cite)
;(setq news-reply-header-hook nil)

;;(autoload 'trivial-cite "tc" t t)
;;(setq message-cite-function 'trivial-cite)
;; we want a space after the citation-char '>'
(setq tc-citation-string "> ")
;; we want to toggle with S-mouse-2 (tc-unfill-paragraph) the auto. filled
;; paragraphes (they are highlighted if you move the mouse over it)
(setq tc-mouse-overlays t)
;; This can avoid the "malformed field" error
(setq tc-gnus-nntp-header-hack t)
;; customize the attribution

(defun tc-english-attribution (date name)
  "Produce the standard attribution string, using the real name."
  (let ((date (assoc "date" tc-strings-list))
	(email (assoc "email-addr" tc-strings-list))
        (name (assoc "real-name" tc-strings-list)))
    (if (and (null name) (null email))
	"An unnamed person wrote:"
      (if (null date)
	  (concat (cdr (or name email)) " wrote:")
	(concat "On " (cdr date) ", " (cdr (or name email)) " wrote:")))))

(defun tc-danish-attribution (date name)
  "Produce the standard attribution string, using the real name."
  (let ((date (assoc "date" tc-strings-list))
	(email (assoc "email-addr" tc-strings-list))
        (name (assoc "real-name" tc-strings-list)))
    (if (and (null name) (null email))
	(concat "Den " (cdr date) " skrev en ukendt person:")
      (if (null date)
	  (concat (cdr (or name email)) " skrev:")
	(concat "Den " (cdr date) " skrev " (cdr (or name email)) ":")))))

(setq tc-debug-level 2)
;(setq tc-make-attribution 'kai-tc-simple-attribution)
(setq tc-make-attribution 'tc-fancy-attribution)
(setq tc-groups-functions '(("[d]k" . tc-danish-attribution)
                            (nil . tc-english-attribution)))
;; Show topics
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)
(setq gnus-group-line-format
      "%M%m\%S\%p\%P\%5y: %-50,50G %6t  Last read on %6,6~(cut 2)d\n")

;; Because flyspell overrides M-Tab
;; (defun restore-bbdb-keys ()
;;   "*When composing a message, if both bbdb and flyspell are used, restore the
;; bbdb key bindings in all headers likely to need name expansion."
;;   (interactive)
;;   (message "restore keys")
;;   (map-extents (lambda (e unused) (delete-extent e))
;; 	       nil nil nil nil nil 'restore-bbdb-keys t)
;;   (when (and (eq major-mode 'message-mode)
;; 	     (eq (lookup-key message-mode-map [(meta tab)])
;; 		 'bbdb-complete-name)
;; 	     (eq (key-binding [(meta tab)]) 'flyspell-auto-correct-word))
;;     (save-excursion
;;       (let ((limit (progn (goto-char 1)
;;                           (search-forward mail-header-separator)
;; 			  (point-at-bol))))
;; 	(make-local-hook 'kill-buffer-hook)
;; 	(goto-char 1)
;; ;        (message (format "limit %d re ser %d " limit))
;; ;	(while (re-search-forward "^\\(\\(From\\|Sender\\)\\|\\(\\(Mail-Copies-\\)?To\\)\\|\\([GBF]?[Cc][Cc]\\)\\|\\(Reply-[Tt]o\\)\\): " limit)
;; 	(while (re-search-forward "^\\(\\(From\\|Sender\\)\\|\\(\\(Mail-Copies-\\)?To\\)\\|\\([GBF]?[Cc][Cc]\\)\\|\\(Reply-[Tt]o\\)\\): " limit t)
;; 	  (let* ((start (point))
;; 		 (end (or (and (re-search-forward "^[A-Z][^: \n\t]+: " limit t)
;; 			       (goto-char (point-at-bol)))
;; 			  limit))
;; 		 (extent (make-extent start end)))
;;             (message "set keys")
;; 	    (set-extent-property extent 'keymap message-mode-map)
;; 	    (set-extent-property extent 'restore-bbdb-keys t)
;; 	    (add-hook 'kill-buffer-hook `(lambda () (delete-extent ,extent))
;; 		      nil t)))
;; 	))
;;     ))

(add-hook 'mail-mode-hook     'turn-on-auto-fill)
(add-hook 'message-mode-hook     'turn-on-auto-fill)
;(add-hook 'message-setup-hook     'bbdb-insinuate-message)
;(add-hook 'message-setup-hook     'restore-bbdb-keys)


(add-hook 'gnus-message-setup-hook
          (lambda ()
	    (flyspell-mode t)
;            (restore-bbdb-keys)
            (cond
             ((string= "" gnus-newsgroup-name) 
              (ispell-change-dictionary "da"))
             ((string-match "^\\(dk\\.\\|worldonline\\.dk\\)" gnus-newsgroup-name)
              (ispell-change-dictionary "da"))
             (t
              (ispell-change-dictionary "en")))
            ))

;; (setq
;;  ;:* Whether to let a document define certain fonts.
;;  w3-user-fonts-take-precedence t
;;  ;:* Whether to let a document define certain colors about itself.
;;  ;; Like foreground and background colors and pixmaps, color of links
;;  ;; and visited links, etc.
;;  w3-user-colors-take-precedence t
;;  ;:* Whether to let a document specify a CSS stylesheet.
;;  w3-honor-stylesheets nil
;;  ;:* Use terminal graphics characters for drawing tables and rules if available.
;;  w3-use-terminal-characters nil
;;  ;:* Use terminal graphics characters for tables and rules even on a tty.
;;  w3-use-terminal-characters-on-tty nil
;;  ;:* The character to use to create a horizontal rule.
;;  ;; Must be the character's code, not a string.  This character is
;;  ;; replicated across the screen to create a division.  If nil W3 will
;;  ;; use a terminal graphic character if possible.
;;  w3-horizontal-rule-char 45
;;  ;:* Fetch frames - can be:
;;  ;; nil         no frame display whatsoever
;;  ;; 'as-links   display frame hyperlinks, but do not fetch them
;;  ;; 'ask        display frame hyperlinks and ask whether to fetch them
;;  ;; t           display frame hyperlinks and fetch them.
;;  w3-display-frames nil
;; )

(setq 
  ;; Usually the groups are larger than the default 200 articles, so
  ;; don't ask until it exceeds 400 articles.
  gnus-large-newsgroup 400
  gnus-thread-hide-subtree t
  ;; number that says how much each sub-thread should be indented
  gnus-thread-indent-level 2
  ;; don't confirm catchup
  gnus-interactive-catchup nil

  ;; Don't ignore subject changes when treading
  ;gnus-thread-ignore-subject nil

  ;; Delete expired mail after 60 days
  nnmail-expiry-wait 60
)

;;(setq gnus-summary-line-format "%U%R%z%(%I%-55,55s %[%n%]%)\n")
;;(setq gnus-summary-line-format "%U%R%z%I%(%[%5L: %-20,20n%]%)%3t %-80,80s %10d\n")

;; Article display
(setq  gnus-article-display-hook
        '(
 	 ;; hide unwanted headers if `gnus-have-all-headers' is nil
          ;;	 gnus-article-hide-headers-if-wanted 
 	 ;; convert the current article date to time lapsed since it was sent
 	 gnus-article-date-lapsed
 	 ;; toggle hiding of headers that aren't very interesting
          ;;	 gnus-article-hide-boring-headers
 	 ;; translate overstrikes into bold text
 	 gnus-article-treat-overstrike
 	 ;; do a naive translation of a quoted-printable-encoded article 
 	 gnus-article-de-quoted-unreadable
 	 ;; remove all blank lines from the beginning of the article
 	 gnus-article-strip-leading-blank-lines
 	 ;; remove all trailing blank lines from the article
 	 gnus-article-remove-trailing-blank-lines
 	 ;; replace consecutive blank lines with one empty line
 	 gnus-article-strip-multiple-blank-lines
 	 ;; highlight current article 
 	 gnus-article-highlight
 	 ;; emphasize text according to `gnus-emphasis-alist'
 	 gnus-article-emphasize
 	 ;; look for an X-Face header and display it if present
 	 gnus-article-display-x-face
 	 ;; display "smileys" as small graphical icons 
 	 gnus-smiley-display
 	 ;; add buttons to the head of the article 
 	 gnus-article-add-buttons-to-head
 	 ;; toggle hiding of any PGP headers and signatures in the current article 
 	 gnus-article-hide-pgp
	 ;; Wrap long lines
	 gnus-article-fill-long-lines
 	 ))

;; Prefer plain to html & rtf
(eval-after-load "mm-decode"
 '(progn 
      (add-to-list 'mm-discouraged-alternatives "text/html")
      (add-to-list 'mm-discouraged-alternatives "text/richtext")))


;; Display html as buttons and open in external viewer
;; (setq mm-inline-media-tests
;;       (cons '("text/html" nil (lambda (h) nil))
;;             mm-inline-media-tests))

;; (push "text/html" mm-inline-override-types)
;; (setq mm-text-html-renderer nil)

;; Customization
;;*================================
;;* Scoring away stuff I find boring
;(setq   gnus-use-adaptive-scoring t)
;(defvar gnus-default-adaptive-score-alist
;  '((gnus-unread-mark)
;    (gnus-ticked-mark (from 4))
;    (gnus-dormant-mark (from 5))
;    (gnus-del-mark (from -4) (subject -1))
;    (gnus-read-mark (from 1) (subject 1))
;    (gnus-expirable-mark (from -1) (subject -1))
;    (gnus-killed-mark (from -1) (subject -3))
;    (gnus-kill-file-mark (from -9999))
;    (gnus-ancient-mark (subject -1))
;    (gnus-low-score-mark (subject -1))
;    (gnus-catchup-mark (subject -1))
;    )
;  )

;;*================================
;;* Formatting the summary buffer: sorting by thread
;* gnus-thread-sort-by-author     - Sort threads by root author.
;* gnus-thread-sort-by-chars      - Sort threads by root article octet length.
;* gnus-thread-sort-by-date       - Sort threads by root article date.
;* gnus-thread-sort-by-lines      - Sort threads by root article Lines header.
;* gnus-thread-sort-by-number     - Sort threads by root article number.
;* gnus-thread-sort-by-score      - Sort threads by root article score.
;* gnus-thread-sort-by-subject    - Sort threads by root subject.
;* gnus-thread-sort-by-total-score - Sort threads by the sum of all scores in the thread.
;;*================================
;(setq gnus-thread-sort-functions
;      '(gnus-thread-sort-by-number
;	gnus-thread-sort-by-date
;	gnus-thread-sort-by-subject
;	gnus-thread-sort-by-author
;	gnus-thread-sort-by-score
;	gnus-thread-sort-by-total-score))


;; Sort groups based on level & score

(setq imap-ping-interval (* 4 60))
(setq imap-ping-timer nil)

(defun imap-ping-handler ()
  ;; ping all active IMAP servers in `nnimap-server-buffer-alist'
  (when (boundp 'nnimap-server-buffer-alist)
    (let ((servers nil))
      (mapc
       (lambda (server-buffer)
         (let ((server (car server-buffer))
               (buffer (cadr server-buffer)))
           (when (and (get-buffer buffer) (not (member server servers)))
             (ignore-errors
               (with-local-quit
                 (with-temp-message
                     (format "Pinging %s..." server)
                   (imap-send-command-wait "NOOP" buffer)
                   (message "Pinging %s...done" server))))
             (setq servers (cons server servers)))))
       nnimap-server-buffer-alist)))

  (let* ((current (current-time))
	 (timer imap-ping-timer)
	 ;; compute the time when this timer will run again
	 (next-time (timer-relative-time
		     (list (aref timer 1) (aref timer 2) (aref timer 3))
		     (* 5 (aref timer 4)) 0)))
    ;; if the activation time is far in the past, skip executions
    ;; until we reach a time in the future.  This avoids a long
    ;; pause if Emacs has been suspended for hours.
    (or (> (nth 0 next-time) (nth 0 current))
	(and (= (nth 0 next-time) (nth 0 current))
	     (> (nth 1 next-time) (nth 1 current)))
	(and (= (nth 0 next-time) (nth 0 current))
	     (= (nth 1 next-time) (nth 1 current))
	     (> (nth 2 next-time) (nth 2 current)))
	(progn
	  (timer-set-time timer (timer-next-integral-multiple-of-time
				 current imap-ping-interval)
			  imap-ping-handler)
	  (timer-activate timer)))))

(setq imap-ping-timer
      (run-at-time t imap-ping-interval 'imap-ping-handler))

(defun jao-gnus-goto-google ()
  (interactive)
  (when (memq major-mode '(gnus-summary-mode gnus-article-mode))
    (when (eq major-mode 'gnus-article-mode) 
      (gnus-article-show-summary))
    (let* ((article (gnus-summary-article-number))
           (header (gnus-summary-article-header article))
           (id (substring (mail-header-id header) 1 -1)))
      (browse-url 
       (format "http://groups.google.com/groups?selm=%s" id)))))


(defvar *jao-mails* 
        "jeppe@ingolfs\\.dk\\|jnm@fleetzone\\.dk")

(defun gnus-user-format-function-j (headers)
  (let ((to (gnus-extra-header 'To headers)))
    (if (string-match *jao-mails* to)
        (if (string-match "," to) "~" "»")
      (if (or (string-match *jao-mails* 
                            (gnus-extra-header 'Cc headers))
              (string-match *jao-mails* 
                            (gnus-extra-header 'BCc headers)))
          "~"
        " "))))

(setq gnus-user-date-format-alist
      '(((gnus-seconds-today) . "Today, %H:%M")
        ((+ 86400 (gnus-seconds-today)) . "Yesterday, %H:%M")
        (604800 . "%A %H:%M") ;;that's one week
        ((gnus-seconds-month) . "%A %d")
        ((gnus-seconds-year) . "%B %d")
        (t . "%B %d '%y"))) ;;this one is used when no other does match

(setq gnus-summary-line-format
      (concat "%U%R %~(pad-right 2)t%* %uj %B%~(max-right 30)~(pad-right 30)n  "
              "%~(max-right 90)~(pad-right 90)s %-135=%&user-date;\n"))
