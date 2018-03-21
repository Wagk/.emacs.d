;;; config-project.el --- projectile and project management packages

;;; Commentary:

;;; Code:
(require 'config-package)
(require 'config-helm)
(require 'config-org)
(require 'config-evil)

(use-package projectile
  :demand t
  :config
  (projectile-mode)
  )

(use-package helm-projectile
  :after (projectile)
  :init
  (general-define-key :states 'normal
                      :prefix my-default-evil-leader-key
                      "p p" 'helm-projectile)
  )

(use-package org-projectile
  :after (projectile)
  :init
  (general-define-key :states 'normal
                      :prefix my-default-evil-leader-key
                      "o p" 'org-projectile:project-todo-completing-read)
  :config
  (org-projectile:per-repo)
  (setq org-projectile:per-repo-filename ".todo.org"
        org-agenda-files (append org-agenda-files (org-projectile:todo-files)))
  (add-to-list 'org-capture-templates (org-projectile:project-todo-entry "o"))
  )


;; For when we're more comfortable with org
;; (use-package org-projectile
;;   :ensure t
;;   :after org
;;   :config
;;   (org-projectile:per-repo)
;;   (setq org-projectile:per-repo-filename ".todo.org"
;;         org-agenda-files (append org-agenda-files
;;                                  (org-projectile:todo-files))))

;; "]"        'org-projectile:template-or-project

(provide 'config-project)

;;; config-project.el ends here
