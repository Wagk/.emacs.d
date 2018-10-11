(use-package diminish)
(use-package bind-key)

;; https://github.com/noctuid/general.el
(use-package general
  :demand t
  :straight (:host github :repo "noctuid/general.el" :branch "master")
  :commands (general-define-key)
  :init
  (defconst my-default-evil-leader-key "SPC"))

;; (use-package use-package-ensure-system-package)

;; https://github.com/emacscollective/auto-compile
(use-package auto-compile
  :demand t
  :custom
  (load-prefer-newer t)
  (auto-compile-verbose t)
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

(use-package auto-package-update
  :commands (auto-package-update-now
	     auto-package-update-at-time
	     auto-package-update-maybe)
  :custom
  (auto-package-update-delete-old-versions t
					   "We already version them on
					   git")
  (auto-package-update-prompt-before-update t
					    "NO SURPRISES")
  (auto-package-update-interval 14
				"update once every 2 weeks (the count
				is in days)"))

;; local configuration variables
(progn (my-ensure-local-el-file-exists)
       (load (at-user-init-dir "local.el")))

(use-package evil
  :demand t
  :straight (:host github :repo "emacs-evil/evil" :branch "master")
  :commands (evil-set-initial-state
	     evil-insert-state
	     evil-ex-define-cmd)
  :general
  (global-map
   "C-u" nil) ;; Disable universal argument
  (:keymaps 'insert
	    "C-u"    'kill-whole-line
	    "C-l"    'evil-complete-next-line)
  (:keymaps 'motion
	    "C-u"    'evil-scroll-up)
  (:keymaps 'normal
	    "Y"      '/evil-copy-to-end-of-line
	    "gt"     '(lambda () (interactive) (other-frame 1))
	    "gT"     '(lambda () (interactive) (other-frame -1))
	    "C-\\"   '/lang-toggle ;; binding for eng <-> jap
	    "g o"    'ff-find-other-file
	    "g a"    'describe-char)
  (:keymaps 'inner
	    "/"      '/inner-forward-slash)
  (:keymaps 'outer
	    "e"      'my-evil-a-buffer
	    "/"      '/a-forward-slash)
  (:keymaps 'minibuffer-local-map
	    "C-w"    'backward-kill-word)
  :custom
  (evil-want-C-u-scroll  t
			 "Emacs uses `C-u' for its
			 `universal-argument'function. It conflicts
			 with scroll up in evil-mode")
  (evil-want-integration nil
			 "`evil-collections' demands that this be
			 disabled to work")
  (evil-want-keybinding nil
			"`evil-collections' wants this to be
			disabled,https://github.com/emacs-evil/evil-collection/issues/60")
  (evil-want-Y-yank-to-eol t
			   "Y has the default behavior of functioning
			   identically to yy. Change it to function
			   similarly to dd, and cc instead.")
  (evil-regexp-search t
		      "Use regular expressions while searching instead
		      of plaintext matching.")
  (evil-want-C-u-scroll t
			"In vim, <C-u> maps to half page up. In Emacs,
			it corresponds to a universal argument that
			might augment a function call. We prefer the
			scrolling.")
  (evil-split-window-below t
			   "`set splitbelow` in vim")
  (evil-vsplit-window-right t
			    "`set splitright` in vim")
  (evil-auto-indent t
		    "Automatically indent when inserting a newline")
  :config
  (defun update-evil-shift-width ()
    "We do this otherwise packages like parinfer would mess up with
    the indentation, since their default is 4 but lisp-mode defaults
    are generally 2."
    (interactive)
    (customize-set-variable 'evil-shift-width lisp-body-indent))

  ;; Back to our regularly scheduled programming
  (fset 'evil-visual-update-x-selection 'ignore)
  (evil-select-search-module 'evil-search-module 'evil-search)

  (evil-ex-define-cmd "sh[ell]"    'shell) ;; at least shell shows its keymaps
  (evil-ex-define-cmd "tabn[ew]"   'make-frame)
  (evil-ex-define-cmd "tabe[dit]"  'make-frame)
  (evil-ex-define-cmd "qw[indow]"  'delete-frame)
  (evil-ex-define-cmd "restart"    'restart-emacs)
  (evil-ex-define-cmd "init"       'find-user-init-file)
  (evil-ex-define-cmd "local"      'find-user-local-file)
  (evil-ex-define-cmd "me[ssage]"  'find-message-buffer)
  (evil-ex-define-cmd "config"     'find-user-config-file)

  ;; nmap Y y$
  (defun /evil-copy-to-end-of-line ()
    "Yanks everything from point to the end of the line"
    (interactive)
    (evil-yank (point) (point-at-eol)))

  ;; https://stackoverflow.com/questions/18102004/emacs-evil-mode-how-to-create-a-new-text-object-to-select-words-with-any-non-sp/22418983#22418983
  (defmacro /evil-define-and-bind-text-object (key start-regex end-regex)
    (let ((inner-name (make-symbol "inner-name"))
	  (outer-name (make-symbol "outer-name")))
      `(progn
	 (evil-define-text-object ,inner-name (count &optional beg end type)
	   (evil-select-paren ,start-regex ,end-regex beg end type count nil))
	 (evil-define-text-object ,outer-name (count &optional beg end type)
	   (evil-select-paren ,start-regex ,end-regex beg end type count t))
	 (define-key evil-inner-text-objects-map ,key (quote ,inner-name))
	 (define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))

  ;; https://www.emacswiki.org/emacs/RegularExpression
  (/evil-define-and-bind-text-object "/" "/" "/")
  (/evil-define-and-bind-text-object "\\" "\\" "\\")
  (/evil-define-and-bind-text-object "|" "|" "|")

  (evil-define-text-object my-evil-a-buffer (count &optional beg end type)
    "Select entire buffer"
    (evil-range (point-min) (point-max)))

  (add-hook 'evil-normal-state-entry-hook 'evil-ex-nohighlight)
  (evil-mode))

(use-package helm
  :defer 2
  :commands (helm-mini)
  :straight (:host github :repo "emacs-helm/helm" :branch "master")
  :general
  ("C-h C-h" 'helm-apropos
   "C-h h"   'helm-apropos)
  (:states 'normal
   "-"     'helm-find-files) ;; emulate vim-vinegar
  (:states  'normal
   :prefix my-default-evil-leader-key
   "<SPC>"  'helm-M-x
   "TAB"    'helm-resume
   "y y"    'helm-show-kill-ring
   "b b"    'helm-mini
   "m m"    'helm-bookmarks)
  (:keymaps 'helm-map
   "C-w" 'evil-delete-backward-word
   "\\"  'helm-select-action
   "C-j" 'helm-next-line
   "C-k" 'helm-previous-line
   "C-d" 'helm-next-page
   "C-u" 'helm-previous-page
   "C-l" 'helm-next-source
   "C-h" 'helm-previous-source
   "TAB" 'helm-execute-persistent-action)
  :init
  (evil-ex-define-cmd "bb" 'helm-mini)
  (evil-ex-define-cmd "book[marks]" 'helm-bookmarks)
  :config
  (setq helm-idle-delay 0.0
        helm-input-idle-delay 0.01
        helm-quick-update t
	helm-recentf-fuzzy-match t
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
  (helm-mode))

(use-package restart-emacs
  :straight (:host github :repo "iqbalansari/restart-emacs" :branch "master")
  :commands (restart-emacs))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-screen t)

(setq-default require-final-newline t)

(setq ring-bell-function 'ignore)

(setq w32-pipe-read-delay 0)

(setq tab-always-indent 'complete)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'after-make-frame-functions 'select-frame)

(customize-set-variable 'sentence-end-double-space nil)

(add-hook 'after-change-major-mode-hook '(lambda () (modify-syntax-entry ?_ "w"))

(customize-set-variable 'frame-background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)

(use-package solarized-theme
  :demand t
  :custom
  (solarized-use-variable-pitch nil)
  (solarized-distinct-fringe-background nil)
  (solarized-high-contrast-mode-line nil)
  (solarized-use-less-bold t)
  (solarized-use-more-italic nil)
  (solarized-scale-org-headlines nil)
  (solarized-height-minus-1 1.0)
  (solarized-height-plus-1 1.0)
  (solarized-height-plus-2 1.0)
  (solarized-height-plus-3 1.0)
  (solarized-height-plus-4 1.0)
  :config
  (load-theme 'solarized-dark t))
