;;; config-helm.el --- Helm configuration

;;; Commentary:
;; Really this is for fuzzy finding in general

;;; Code:
(require 'config-package)
(require 'config-evil)

;; Install ivy as a contingency
(use-package ivy
  :bind (:map ivy-minibuffer-map
              ("C-w" . ivy-backward-kill-word)
              ("C-u" . ivy-backward-kill-line)
              ("C-j" . ivy-next-line)
              ("C-k" . ivy-previous-line))
  :config
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t))

(use-package swiper)

(use-package counsel
  :bind (("M-x" . counsel-M-x)))

(use-package helm
  :after (general)
  :demand t
  :init
  (general-define-key "C-h C-h" 'helm-apropos
                      "C-h h" 'helm-apropos)
  (general-define-key :states 'normal
                      "-" 'helm-find-files) ;; emulate vim-vinegar
  (general-define-key
   :states 'normal
   :prefix my-default-evil-leader-key
                      "<SPC>" 'helm-M-x
                      "TAB"   'helm-resume
                      "y"     'helm-show-kill-ring
                      ;; "h h"   'helm-apropos
                      "-"     'helm-find-files
                      "b"     'helm-mini
                      "m m"     'helm-bookmarks)
  :bind(:map helm-map
             ("C-w" . evil-delete-backward-word)
             ("\\"  . helm-select-action)
             ("C-j" . helm-next-line)
             ("C-k" . helm-previous-line)
             ("C-n" . helm-next-page)
             ("C-p" . helm-previous-page)
             ("C-l" . helm-next-source)
             ("C-h" . helm-previous-source)
             ("TAB" . helm-execute-persistent-action))
  :config
  (setq helm-idle-delay 0.0
        helm-input-idle-delay 0.01
        helm-quick-update t)
  (setq helm-recentf-fuzzy-match t
        helm-locate-fuzzy-match nil ;; locate fuzzy is worthless
        helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-semantic-fuzzy-match t
        helm-apropos-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-lisp-fuzzy-completion t
        helm-completion-in-region-fuzzy-match t
        helm-split-window-in-side-p t
        helm-use-frame-when-more-than-two-windows nil)
  (progn (helm-autoresize-mode)
         (setq helm-autoresize-min-height 40 ;; these values are %
               helm-autoresize-max-height 40))
  (helm-mode)
  )

;; TODO: when defining helm desckeys make sure a global binding is also presentw
;; C-h seems broken (We've been overwriting it to enable terminal backspace)

(use-package helm-describe-modes
  :bind (("C-h m" . helm-describe-modes))
  ;; :config
  ;; (evil-leader/set-key "m" 'helm-describe-modes)
  )

(use-package helm-descbinds
  :bind (("C-h b" . helm-descbinds))
  :config
  (helm-descbinds-mode))

(use-package helm-swoop
  :disabled
  :init
;;;###autoload
  (defun /helm-swoop-vis () (interactive)
         (helm-swoop :$query "" :$multiline 4))
  :bind (:map helm-swoop-map
              ("C-w" . evil-delete-backward-word))
  ;; :config
  ;; (defun /helm-swoop-vis () (interactive)
  ;;        (helm-swoop :$query "" :$multiline 4))
  ;; no annoying under mouse highlights
  ;;(setq helm-swoop-pre-input-function (lambda () nil))
  )

(use-package helm-fuzzier
  :after helm
  :demand t
  :config
  (helm-fuzzier-mode))

(use-package helm-flx
  :after helm
  :demand t
  :config
  (helm-flx-mode)
  (setq helm-flx-for-helm-find-files t
        helm-flx-for-helm-locate t))

(use-package helm-dash)

;; commenting it out because it has conflicting bindings in its own map
;; (use-package helm-hunks
;;   :commands (helm-hunks
;;              helm-hunks-current-buffer
;;              helm-hunks-staged
;;              helm-hunks-staged-current-buffer)
;;   :config
;;   (progn (require 'git-gutter+)
;;          (add-hook 'helm-hunks-refresh-hook 'git-gutter+-refresh)
;;          )
;;   (setq helm-hunks-preview-diffs t)
;;   (evil-leader/set-key
;;     "." 'helm-hunks-current-buffer))

;; (helm-mode 1)

(provide 'config-helm)

;;; config-helm.el ends here
