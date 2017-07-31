;;; config-webdev.el --- Typescript, javascript, and related topics

;;; Commentary:

;;; Code:
(require 'config-package)
(require 'config-helm)

;; TODO(pangt): when this takes a relative path, give a relative path
;; (currently it's only relative to user-init-dir)
(load-user-config-file "./config/config-typescript.el")

(use-package emmet-mode
  :ensure t
  :bind (:map emmet-mode-keymap
              ("<tab>" . emmet-next-edit-point)
              ("<backtab>" . emmet-prev-edit-point))
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable emmet's css abbreviation.
  (setq emmet-move-cursor-between-quotes t) ;; default nil
  )

;; not sure if this inherits from prog-mode
(use-package groovy-mode
  :ensure t
  :config
  (progn (require 'fill-column-indicator)
         (add-hook 'groovy-mode-hook 'turn-on-fci-mode))
  (progn (require 'evil-core)
         (evil-define-key 'insert 'groovy-mode-map
           (kbd "RET") 'comment-indent-new-line))
  )

(use-package php-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package helm-emmet
  :ensure t)

(add-to-list 'auto-mode-alist '("\\Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\Jenkinsfile\\'" . groovy-mode))

(provide 'config-webdev)

;;; config-webdev.el ends here
