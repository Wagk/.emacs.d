(use-package parinfer
  :general
  (parinfer-mode-map
   "\"" nil) ;; let smartparens do its thing
  :hook ((clojure-mode . parinfer-mode)
	 (common-lisp-mode . parinfer-mode)
	 (scheme-mode . parinfer-mode)
	 (lisp-mode . parinfer-mode)
	 (hy-mode . parinfer-mode))
  :init
  (progn (setq parinfer-extensions
	       '(defaults       ; should be included.
		  pretty-parens  ; different paren styles for different modes.
		  evil           ; If you use Evil.
		  smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
		  smart-yank))))   ; Yank behavior depend on mode.

(use-package rainbow-delimiters
  :commands (rainbow-delimiters-mode))

(use-package elisp-mode
  :ensure nil
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
	 (emacs-lisp-mode . parinfer-mode)
	 (emacs-lisp-mode . update-evil-shift-width)))
