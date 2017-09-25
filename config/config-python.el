;;; config-python.el --- python configuration file

;;; Commentary:

;;; Code:
(require 'config-package)
(require 'config-prog)
(require 'config-completion)

;; ;; https://github.com/jorgenschaefer/elpy
;; (use-package elpy
;;   :ensure t
;;   :config
;;   (elpy-enable))

;; (add-hook 'python-mode-hook 'turn-on-ctags-auto-update-mode)
(add-hook 'python-mode-hook 'highlight-indent-guides-mode)

(use-package company-jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook #'(lambda ()
                                  (add-to-list 'company-backends 'company-jedi))))

(use-package flycheck-mypy
  :ensure t
  :config
  (add-hook 'python-mode-hook #'(lambda ()
                                  (add-to-list 'flycheck-disabled-checkers 'python-flake8)
                                  (add-to-list 'flycheck-disabled-checkers 'python-pylint)
                                  (add-to-list 'flycheck-disabled-checkers 'python-pycompile)
                                  (add-to-list 'flycheck-python-mypy-args "--ignore-missing-imports")
                                  (flycheck-mode))))

;; remove really dumb indentation rule when inside docstring
;; NOTE: it appears that :inside-docstring isn't documented
;; https://emacs.stackexchange.com/questions/26435/how-can-i-disable-indentation-rules-within-docstrings-in-python-mode
(when (and (>= emacs-major-version 25)
           (>= emacs-minor-version 1))
  (defun $python-mode-noindent-docstring (&optional _previous)
    (when (eq (car (python-indent-context)) :inside-docstring)
      'noindent))
  (advice-add 'python-indent-line :before-until #'$python-mode-noindent-docstring))

(provide 'config-python)

;;; config-python.el ends here
