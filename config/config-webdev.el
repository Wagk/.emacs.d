;;; config-webdev.el --- Typescript, javascript, and related topics

;;; Commentary:

;;; Code:
(require 'config-package)
(require 'config-helm)

(use-package typescript-mode
  :ensure t)

(use-package tide
  :ensure t
  :after typescript-mode
  :config
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook 'tide-setup))

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

(use-package groovy-mode
  :ensure t
  :config
  (progn (require 'fill-column-indicator)
         (add-hook 'groovy-mode-hook 'turn-on-fci-mode))
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
