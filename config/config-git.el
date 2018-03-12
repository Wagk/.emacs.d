;;; config-git.el --- git-related configuration

;;; Commentary:

;;; Code:
(require 'config-package)
(require 'config-evil)

(use-package magit
  :commands magit-status
  :init
  (general-define-key :prefix my-default-evil-leader-key
                      ", ," 'magit-status)
  :config
  (with-eval-after-load 'aggressive-fill-paragraph
    (add-hook 'git-commit-setup-hook 'aggressive-fill-paragraph-mode))
  (with-eval-after-load 'fill-column-indicator
    (add-hook 'git-commit-setup-hook 'turn-on-fci-mode))
  (add-hook 'magit-popup-mode-hook #'(lambda () (display-line-numbers-mode -1)))
  )

(use-package evil-magit
  :after magit
  :demand t
  :config
  (evil-magit-init))

;; https://github.com/nonsequitur/git-gutter-plus
(use-package git-gutter+
  :diminish git-gutter+-mode
  :bind (:map evil-normal-state-map
              ("[ h" . git-gutter+-previous-hunk)
              ("] h" . git-gutter+-next-hunk)
              ("g h s" . git-gutter+-stage-hunks)
              ("g h u" . git-gutter+-revert-hunks)
              ("g h h" . git-gutter+-show-hunk-inline-at-point)
              )
  :defer 1
  ;; :hook (prog-mode . git-gutter+-mode)
  :config
  ;; refer to the hacks made in config-colors.el.
  ;; We do this to make the gutter things look nice
  (unless (display-graphic-p)
    (set-face-foreground 'git-gutter+-modified "magenta")
    (set-face-background 'git-gutter+-modified nil)
    (set-face-foreground 'git-gutter+-added "green")
    (set-face-background 'git-gutter+-added nil)
    (set-face-foreground 'git-gutter+-deleted "red")
    (set-face-background 'git-gutter+-deleted nil))
  (setq git-gutter+-hide-gutter t)
  ;; use git-gutter+-diffinfo-at-point to get the range of the hunk,
  ;; extract the range beg-end,
  ;; then set the textobject to that range
  ;; (require 'evil)

  ;; we're forced to put it here because the global mode must be done afterwards
  ;; (??)
  (use-package git-gutter-fringe+
    :if (display-graphic-p)
    :after git-gutter+
    :demand t
    )

  (global-git-gutter+-mode)
  )

;;TODO: either find or implement some kind of git hunk textobject

(provide 'config-git)

;;; config-git.el ends here
