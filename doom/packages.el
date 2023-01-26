(package! org-fragtog)

(package! zoxide)

(package! org-appear
  :recipe (:host github
           :repo "awth13/org-appear"))

(unpin! org-roam)
(package! org-roam-ui)

(package! circadian)

(package! stan-mode)

(package! org-auto-tangle
  :recipe (:host github :repo "yilkalargaw/org-auto-tangle"))

(package! salv
  :recipe (:host github :repo "alphapapa/salv.el"))

(package! peep-dired)

(package! org-fc
  :recipe (:host github :repo "l3kn/org-fc" :files (:defaults "awk" "demo.org")))

(package! org-caldav)

(package! pretty-hydra)  ;; dependency
(package! org-media-note :recipe (:host github :repo "yuchen-lea/org-media-note"))

(package! company-prescient)
(package! vertico-prescient)

(package! emacsql-sqlite3)

(package! activity-watch-mode)
