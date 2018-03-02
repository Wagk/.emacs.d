;;; config-lint.el --- linting plugins

;;; Commentary:

;;; Code:
(require 'config-package)

(use-package flycheck
  :disabled t
  ;; :demand t ;; this is very important
  ;; :hook (prog-mode . flycheck-mode-on-safe)
  ;; (add-hook 'prog-mode-hook 'flycheck-mode-on-safe)
  )

(provide 'config-lint)

;;; config-lint.el ends here
