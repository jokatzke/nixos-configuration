(setq! user-full-name "Jonas Opitz"
       user-mail-address "jonas.opitz@live.de")

(use-package! zoxide
  :init
  (defun custom/dired-jump-with-zoxide (&optional other-window)
    (interactive "P")
    (zoxide-open-with nil (lambda (file) (dired-jump other-window file)) t))
  (map! :leader
        :desc "Find file using zoxide" "f z" #'zoxide-find-file
        :desc "Open folder in dired using zoxide" "f Z" #'custom/dired-jump-with-zoxide
        )
  )

(plist-put! +ligatures-extra-symbols
            :true          nil
            :false         nil
            :int           nil
            :float         nil
            :str           nil
            :bool          nil
            :list          nil
            )

(global-whitespace-mode -1)

(use-package! activity-watch-mode
  :defer nil
  :init
  (global-activity-watch-mode)
  )

(setq! frame-title-format '(:eval (concat (projectile-project-p) "%b - Doom Emacs")))

(setq! doom-font                (font-spec :family "FiraCode Nerd Font" :size 15)
       doom-variable-pitch-font (font-spec :family "Open Sans"           :size 16))

(setq doom-theme 'doom-one-light)

(setq! display-line-numbers-type 'relative)

(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-major-mode-icon t
        doom-modeline-indent-info nil

        doom-themes-padded-modeline t
        ))
;; (add-hook! 'doom-modeline-mode-hook
;;   (progn
;;     (set-face-attribute 'header-line nil
;;                         :background (face-background 'mode-line)
;;                         :foreground (face-foreground 'mode-line))
;;     ))

(with-eval-after-load "ispell"
  ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
  ;; dictionary' even though multiple dictionaries will be configured
  ;; in next line.
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-program-name "hunspell")
  ;; Configure German and English.
  (setq ispell-dictionary "de_DE,en_US")
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "de_DE,en_US")
  ;; For saving words to the personal dictionary, don't infer it from
  ;; the locale, otherwise it would save to ~/.hunspell_de_DE.
  (setq ispell-personal-dictionary "~/.config/personal_dictionaries/hunspell_personal"))

;; The personal dictionary file has to exist, otherwise hunspell will
;; silently not use it.
(unless (file-exists-p ispell-personal-dictionary)
  (write-region "" nil ispell-personal-dictionary nil 0))

(setq langtool-http-server-host "localhost"
      langtool-http-server-port 8081
      langtool-default-language nil
      )

(flycheck-define-checker vale
  "A checker for prose"
  :command ("vale" "--output" "line"
            source)
  :standard-input nil
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
  :modes (markdown-mode org-mode text-mode)
  )
(add-to-list 'flycheck-checkers 'vale 'append)

(add-hook! 'org-mode-hook (salv-mode))

(use-package! doom-snippets
  :defer t
  :init
  (map! :leader
        :desc "Add new snippet"
        "i n" #'yas-new-snippet)
  (map! :nvig "C-e" #'yas-expand)
  )

(map! :desc "company-complete" "C-SPC" #'+company-complete)

(use-package! prescient
  :config
  (prescient-persist-mode 1)
  (setq! prescient-history-length 100
         prescient-frequency-decay 0.997
         prescient-frequency-threshold 0.05)
  (setq! prescient-filter-method '(literal regexp anchored))
  (setq! prescient-sort-full-matches-first t)
  (custom-set-faces!
    '(prescient-primary-highlight       :inherit (outline-4))
    '(prescient-secondary-highlight     :inherit (outline-1) :underline t)
    )
  )

(use-package! company-prescient
  :after company
  :config
  (company-prescient-mode 1)
  (setq! company-prescient-sort-length-enable nil)
  )

(use-package! vertico-prescient
  :after vertico
  :config
  (vertico-prescient-mode 1)
  )

(use-package! avy
  :defer t
  :init
  (map! :nv "g s l" #'avy-goto-line)
  (map! :nv "g s 1" #'avy-goto-word-1)
  (map! :nv "g s 2" #'avy-goto-char-2)
  (map! :nv "g s s" #'avy-goto-char-timer)
  ;; set avy decision characters to dvorak home-row
  (setq avy-keys '(?a ?o ?e ?u ?h ?t ?n ?s))
  ;; search through all windows on all open frames
  (setq avy-all-windows 'all-frames)
  ;; set the timer for avy-goto-char-timer
  (setq avy-timeout-seconds 0.4)
  (setq avy-style 'at-full)
  )

(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "M-,")

(map! :nvig "C-'" #'er/expand-region)

(setq! +evil-want-o/O-to-continue-comments nil)

(add-hook! 'evil-command-window-mode-hook #'turn-off-smartparens-mode)
(add-hook! 'minibuffer-setup-hook #'turn-off-smartparens-mode)

(evil-define-key 'normal dired-mode-map
  ;; allow "normal" vim-movement to navigate the file system
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  )

(setq! delete-by-moving-to-trash t
       trash-directory "~/.local/share/Trash/files/")

(use-package! peep-dired
  :defer t
  :custom
  (peep-dired-cleanup-on-disable t)
  (peep-dired-ignored-extensions '("mkv" "iso" "mp4"))
  :init
  (evil-define-key 'normal peep-dired-mode-map
    ;; (kbd "<SPC>") 'peep-dired-scroll-page-down
    ;; (kbd "C-<SPC>") 'peep-dired-scroll-page-up
    (kbd "<backspace>") 'peep-dired-scroll-page-up
    (kbd "j") 'peep-dired-next-file
    (kbd "k") 'peep-dired-prev-file)
  (add-hook 'peep-dired-hook 'evil-normalize-keymaps)
  (map! :leader
        (:prefix ("d" . "dired")
         :desc "Open dired" "d" #'dired
         :desc "Dired jump to current" "j" #'dired-jump
         (:after dired
          :map dired-mode-map
          :desc "Toggle image previews" "p" #'peep-dired
          :desc "Dired view file" "v" #'dired-view-file
          )
         )
        )
  )

(setq! ledger-reports
       '(("total budget" "ledger --empty -f ~/ledger/main.ledger bal ^budget -X EUR")
         ("total balance" "ledger --empty -f ~/ledger/main.ledger bal -X EUR")
         ("bal" "%(binary) -f %(ledger-file) bal")
         ("reg" "%(binary) -f %(ledger-file) reg")
         ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
         ("account" "%(binary) -f %(ledger-file) reg %(account)"))
       )

(setq! org-cite-global-bibliography
       '(
         "~/Books/Academics/library.bib"
         )
       )

(use-package! citar
  :defer t

  :custom
  ;; set the file paths
  (citar-bibliography  '("~/Books/Academics/library.bib"))
  (citar-library-paths '("~/Books/Academics/"))
  (citar-notes-paths   '("~/org-roam/references"))

  ;; define a template to be used when creating a new bibliography note
  (citar-templates
   '((main . "${author editor:30}   ${date year issued:4}    ${title:110}")
     (suffix . "     ${=type=:20}    ${tags keywords keywords:*}")
     (preview . "${author editor} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
     (note . "Notes on ${author editor}, ${title}") ; For new notes
     ))

  ;; Configuring all-the-icons. From
  ;; https://github.com/bdarcus/citar#rich-ui
  (citar-symbols
   `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) .
      ,(all-the-icons-faicon "file-o" :face 'kb/citar-icon-dim :v-adjust -0.1) )
     (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) .
           ,(all-the-icons-material "speaker_notes" :face 'kb/citar-icon-dim :v-adjust -0.3))
     (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) .
           ,(all-the-icons-octicon "link" :face 'kb/citar-icon-dim :v-adjust 0.01))))
  (citar-symbol-separator "  ")

  :init
  ;; Run `citar-org-update-pre-suffix' after inserting a citation to immediately
  ;; set its prefix and suffix
  (advice-add 'org-cite-insert :after #'(lambda (args)
                                          (save-excursion
                                            (left-char) ; First move point inside citation
                                            (citar-org-update-pre-suffix))))

  ;; Here we define a face to dim non 'active' icons, but preserve alignment.
  ;; Change to your own theme's background(s)
  (defface kb/citar-icon-dim
    '((((background dark)) :foreground "#212428")
      (((background light)) :foreground "#f0f0f0"))
    "Face for having icons' color be identical to the theme
  background when \"not shown\".")
  )

(defun kb/citar-org-update-pre-suffix ()
  "Change the pre/suffix text of the reference at point.

My version also adds a space in the suffix so I don't always have
to manually add one myself."
  (interactive)

  ;; Enable `typo' typographic character cycling in minibuffer. Particularly
  ;; useful in adding en- and em-dashes in citation suffixes (e.g. for page
  ;; ranges)
  (when (featurep 'typo)
    (add-hook 'minibuffer-mode-hook 'typo-mode)) ; Enable dashes

  (let* ((datum (org-element-context))
         (datum-type (org-element-type datum))
         (ref (if (eq datum-type 'citation-reference) datum
                (error "Not on a citation reference")))
         (key (org-element-property :key ref))
         ;; TODO handle space delimiter elegantly.
         (pre (read-string "Prefix text: " (org-element-property :prefix ref)))
         (post (read-string "Suffix text: " (org-element-property :suffix ref))))

    ;; Change post to automatically have one space prior to any user-inputted
    ;; suffix
    (setq post
          (if (string= (replace-regexp-in-string "\s-*" "" post) "")
              ""         ; If there is nothing of substance (e.g. an empty string)
            (replace-regexp-in-string "^[\s-]*" " " post))) ; Only begin with one space

    (setf (buffer-substring (org-element-property :begin ref)
                            (org-element-property :end ref))
          (org-element-interpret-data
           `(citation-reference
             (:key ,key :prefix ,pre :suffix ,post)))))

  ;; Remove hook if it was added earlier
  (remove-hook 'minibuffer-mode-hook 'typo-mode))
(advice-add 'citar-org-update-pre-suffix :override #'kb/citar-org-update-pre-suffix)

(use-package! org-noter
  :defer t
  :after (:any org pdf-view)
  :custom
  (org-noter-notes-search-path '("~/org-roam/references"))
  (org-noter-notes-window-location 'other-frame)
  (org-noter-always-create-frame nil)
  (org-noter-hide-other nil)
  )

(map! :map pdf-view-mode-map
      :localleader
      (:prefix ("e" . "Org noter")
       :desc "Start session"          "e"     #'org-noter
       :desc "Create skeleton"        "s"     #'org-noter-create-skeleton
       :desc "Insert note"            "n"     #'org-noter-insert-note
       :desc "Insert precise note"    "p"     #'org-noter-insert-precise-note
       :desc "End Session"            "d"     #'org-noter-kill-session
       )
      (:prefix ("a" . "Annotations")
       :desc "Markup" "a" #'pdf-annot-add-markup-annotation
       :desc "Highlight" "h" #'pdf-annot-add-highlight-markup-annotation
       :desc "Text" "t" #'pdf-annot-add-markup-annotation
       :desc "Strike-through" "s" #'pdf-annot-add-strikeout-markup-annotation
       :desc "Squiggly" "~" #'pdf-annot-add-squiggly-markup-annotation
       :desc "Underline" "_" #'pdf-annot-add-underline-markup-annotation
       :desc "Underline" "u" #'pdf-annot-add-underline-markup-annotation
       :desc "Delete" "d" #'pdf-annot-delete
       )
      :desc "Occur" "/" #'pdf-occur
      :desc "Outline" "o" #'pdf-outline
      )

(setq! org-directory "~/org/")

(add-hook! 'org-mode-hook (display-line-numbers-mode 1))
(add-hook! 'org-mode-hook (hl-line-mode -1))

(setq! org-hide-emphasis-markers t)
(use-package! org-appear
  :defer t
  :after org
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t
        org-appear-autosubmarkers t
        org-appear-autoentities t
        org-appear-autokeywords t
        org-appear-inside-latex t)
  )

(add-hook! 'org-mode-hook #'mixed-pitch-mode)
(setq mixed-pitch-variable-pitch-cursor nil)

(after! org
  (setq! org-src-preserve-indentation nil
         org-edit-src-content-indentation 0))

(after! org
  (general-auto-unbind-keys)
  (map!
   :map org-mode-map
   :localleader
   (:prefix "g"
    ;; if you jump in org-mode using a link, go back to before jumping
    :desc "Go back from link" "b" #'org-mark-ring-goto
    :desc "Search org buffer" "s" #'org-occur
    )
   (:prefix "i"
    :desc "Item" "i" #'org-insert-item
    :desc "Task" "t" #'org-insert-todo-heading-respect-content
    )
   )
  )

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(after! org
  (setq! org-startup-folded 'content)
  )

(after! org
  (custom-set-faces!
    '(org-document-title :height 2.0)
    '(org-level-1 :height 1.75 :weight bold :extend nil :inherit (outline-1))
    '(org-level-2 :height 1.5  :extend nil :inherit (outline-2))
    '(org-level-3 :height 1.25 :extend nil :inherit (outline-3))
    '(org-level-4 :height 1.1  :extend nil :inherit (outline-4))
    )
  )

(after! org-superstar
  ;; list of bullets to use
  (setq! org-superstar-headline-bullets-list '(32 32))
  ;; do not cycle through bullets
  (setq! org-superstar-cycle-headline-bullets nil)
  ;; bullet to use for leading stars
  (setq! org-superstar-leading-bullet " ")
  ;; non-nil -> hide leading stars
  (setq! org-superstar-remove-leading-stars nil)
  )

(after! org
  (setq! org-cycle-separator-lines 2)
  )

(require 'ox-extra)
(ox-extras-activate  '(ignore-headlines))

(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(after! org
  (map!
   :map org-mode-map
   :localleader
   (:prefix ("v" . "Literate programming")
    :desc "Tangle" "b" #'org-babel-tangle
    :desc "Tangle file" "f" #'org-babel-tangle-file
    :desc "Execute subtree" "s" #'org-babel-execute-subtree
    )
   )
  )

(setq! org-roam-directory (file-truename "~/org-roam"))
(setq! org-roam-database-connector 'sqlite3)

(org-roam-db-autosync-mode)

(setq! org-roam-capture-templates
       '(
         ("d" "default" plain
          "%?"
          :if-new (file+head
                   "default/${slug}.org" ;; file-name
                   "#+title: ${title}\n#+filetags:\n\n" ;; meta-data
                   )
          :unnarrowed t
          )
         ("f" "functionality" plain
          (file "~/org-roam/functionality/templates/functionality_template.org")
          :if-new (file+head
                   "functionality/${slug}.org" ;; file-name
                   "#+title: ${title}\n#+filetags:\n\n" ;; meta-data
                   )
          :unnarrowed t
          )
         ("s" "secret" plain
          "%?"
          :if-new (file+head
                   "secrets/${slug}.org" ;; file-name
                   "#+title: ${title}\n#+filetags:\n\n" ;; meta-data
                   )
          :unnarrowed t
          )
         ))

(cl-defmethod org-roam-node-hierarchy ((node org-roam-node))
  (let ((level (org-roam-node-level node)))
    (concat
     (when (> level 0) (concat (org-roam-node-file-title node) " > "))
     (when (> level 1) (concat (string-join (org-roam-node-olp node) " > ") " > "))
     (org-roam-node-title node))))
(setq! org-roam-node-display-template "${hierarchy:*} ${tags:20}")

(setq! org-roam-node-default-sort nil)

(use-package! org-roam-ui
  :after org-roam
  :init
  (map! :map doom-leader-notes-map
        :desc "Show Graph" "r g" #'org-roam-ui-mode)
  )

(use-package! org-media-note
  :hook (org-mode .  org-media-note-mode)
  :bind (
         ("H-v" . org-media-note-hydra/body))  ;; Main entrance
  :config
  (setq org-media-note-screenshot-image-dir "~/org-roam/.images/")  ;; Folder to save screenshot
  )

(solaire-global-mode -1)

(with-eval-after-load 'ox-latex
  (add-to-list
   'org-latex-classes
   '("thesis" ;; Master's Thesis class
     "\\documentclass{thesis}"
     ("\\chapter{%s}" . "\\chapter*{%s}")
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
     )
   )
  )

(setq! org-latex-packages-alist '(("" "bm" t)
                                  ("" "mathtools" t)
                                  ))

(add-hook! 'org-mode-hook #'turn-on-org-cdlatex)

(use-package! org-fragtog
  :defer t
  :after org
  :hook (org-mode . org-fragtog-mode)
  )

(setq! org-startup-with-latex-preview t)

(setq! org-preview-latex-default-process 'dvisvgm)

(setq! org-latex-compiler "lualatex")

(setq org-export-allow-bind-keywords t)

(setq custom/org-export-with-broken-links nil)
(setq org-export-with-broken-links custom/org-export-with-broken-links)

;; export headlines to separate files
;;
(defun custom/org-export-headlines-to-pdf ()
  "Export all subtrees that are *not* tagged with :noexport: to
separate files.

Subtrees that do not have the :EXPORT_FILE_NAME: property set
are exported to a filename derived from the headline text."
  (interactive)
  (save-buffer)

  ;; temporarily export with broken links
  (setq org-export-with-broken-links t)

  (let ((modifiedp (buffer-modified-p)))
    (save-excursion
      (goto-char (point-min))
      (goto-char (re-search-forward "^*"))
      (set-mark (line-beginning-position))
      (goto-char (point-max))
      (org-map-entries
       (lambda ()
         (let ((export-file (org-entry-get (point) "EXPORT_FILE_NAME")))
           (unless export-file
             (org-set-property
              "EXPORT_FILE_NAME"
              (replace-regexp-in-string " " "_" (nth 4 (org-heading-components)))))
           (deactivate-mark)
           (org-latex-export-to-pdf nil t)
           (unless export-file (org-delete-property "EXPORT_FILE_NAME"))
           (set-buffer-modified-p modifiedp)))
       "-noexport" 'region-start-level)))

  ;; restore org-export broken links behavior
  (setq org-export-with-broken-links custom/org-export-with-broken-links)
  )

(defconst my-gtd-inbox-file "~/gtd/inbox.org")
(defconst my-gtd-main-file "~/gtd/gtd.org")
(defconst my-gtd-someday-file "~/gtd/someday.org")
(defconst my-gtd-tickler-file "~/gtd/tickler.org")

(setq! org-capture-templates '(("t" "Todo [inbox]" entry
                                (file+headline my-gtd-inbox-file "Tasks")
                                "* TODO %i%?")
                               ("i" "Information [inbox]" entry
                                (file+headline my-gtd-inbox-file "Information")
                                "* %i%?")
                               ))

(setq! org-refile-targets '((my-gtd-main-file :maxlevel . 3)
                            (my-gtd-someday-file :maxlevel . 3)
                            (my-gtd-tickler-file :maxlevel . 2)))

(setq! org-agenda-files '("~/gtd/inbox.org"
                          "~/gtd/gtd.org"
                          "~/gtd/tickler.org"
                          ))

(setq! org-agenda-custom-commands
      '(("w" "At Work" tags-todo "@work"
         ((org-agenda-overriding-header "Work")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
        ("p" "At the PC" tags-todo "@pc"
         ((org-agenda-overriding-header "PC")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
        ("h" "At Home" tags-todo "@home"
         ((org-agenda-overriding-header "Home")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
        ("t" "Tinkering" tags-todo "@tinkering"
         ((org-agenda-overriding-header "Tinkering")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
        ))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq! should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq! should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(setq! org-agenda-span 17)

(use-package! org-caldav
  :after org
  :config
  (setq!
   org-icalendar-timezone "Europe/Berlin"
   org-caldav-url "http://192.168.178.74:18080/remote.php/dav/calendars/joopitz"
   org-caldav-calendar-id "jonas-tasks"
   org-caldav-inbox '(file+headline "~/gtd/tickler.org" "Appointments")
   ;; also include archived entries
   org-caldav-files '("~/gtd/tickler.org" "~/gtd/tickler.org_archive")
   ;; do not sync TODO entries
   org-caldav-sync-todo nil
   org-caldav-todo-deadline-schedule-warning-days nil
   org-icalendar-include-todo nil
   org-icalendar-use-deadline '(event-if-not-todo)
   org-icalendar-use-scheduled '(event-if-not-todo)
   ;; set a default reminder for exported entries
   org-icalendar-alarm-time 30
   )
  )

(use-package org-fc
  :after org
  :custom
  (org-fc-directories '("~/org-roam/"))
  ;; symmetrical fuzzy interval, larger than the default
  (org-fc-algo-sm2-fuzz-max 1.2)
  (org-fc-algo-sm2-fuzz-min 0.8333)
  ;; custom intervals for new cards
  (org-fc-algo-sm2-intervals '(0.0 0.5 3.0 7.0))
  :config
  (require 'org-fc-keymap-hint)
  :init
  ;; set keys that were overridden by evil-mode
  ;; keys while viewing a prompt
  (evil-define-minor-mode-key 'normal 'org-fc-review-flip-mode
    (kbd "RET") 'org-fc-review-flip
    (kbd "n") 'org-fc-review-flip
    (kbd "p") 'org-fc-review-edit
    (kbd "s") 'org-fc-review-suspend-card
    (kbd "q") 'org-fc-review-quit
    )
  ;; keys while evaluating the result
  (evil-define-minor-mode-key 'normal 'org-fc-review-rate-mode
    (kbd "a") 'org-fc-review-rate-again
    (kbd "h") 'org-fc-review-rate-hard
    (kbd "g") 'org-fc-review-rate-good
    (kbd "e") 'org-fc-review-rate-easy
    (kbd "s") 'org-fc-review-suspend-card
    (kbd "q") 'org-fc-review-quit
    )
  ;; keys while in the dashboard
  (evil-define-key 'normal org-fc-dashboard-mode-map
    (kbd "q") 'kill-current-buffer
    (kbd "r") 'org-fc-dashboard-review
    )

  ;; general keys
  (map! :leader
        (:prefix "n"
         :nv "f" nil
         (:prefix ("f" . "Flashcards")
          :desc "Dashboard"     "d" (lambda () (interactive) (org-fc-dashboard 'all))
          :desc "Review"        "r" #'org-fc-review-all
          (:prefix ("i" . "Init Flashcard")
           :desc "Normal"        "i" #'org-fc-type-normal-init
           :desc "Normal"        "n" #'org-fc-type-normal-init
           :desc "Cloze"         "c" #'org-fc-type-cloze-init
           :desc "Double"        "d" #'org-fc-type-double-init
           :desc "Text-Input"    "t" #'org-fc-type-text-input-init
           )
          )
         )
        )
  )

(map!
 :leader
 (:prefix "o"
  :desc "Calc" "c" #'calc
  :desc "Calc in whole buffer" "C" #'full-calc
  ))

(set-email-account!
 "gmail.com"
 '((mu4e-sent-folder       . "/Gmail/[Google Mail]/Sent Mail")
   (mu4e-drafts-folder     . "/Gmail/[Google Mail]/Drafts")
   (mu4e-trash-folder      . "/Gmail/[Google Mail]/Trash")
   (mu4e-refile-folder     . "/Gmail/[Google Mail]/All Mail")
   )
 nil
 )
(set-email-account!
 "outlook"
 '((mu4e-sent-folder       . "/Outlook/Sent")
   (mu4e-drafts-folder     . "/Outlook/Drafts")
   (mu4e-trash-folder      . "/Outlook/Deleted")
   (mu4e-refile-folder     . "/Outlook/Inbox")
   )
 t
 )

(use-package! mu4e
  :config
  (setq! mu4e-update-interval 300
         message-send-mail-function 'message-send-mail-with-sendmail
         )
  )

(add-hook 'elfeed-search-mode-hook #'elfeed-update)

(map! :leader
      (:desc "RSS Feed" "o f" #'elfeed))
