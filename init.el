;;; package --- Summary
;;; Commentary:
;;; Code:

;; somehow optimise for garbage collection
;; https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/

;; (defvar default-gc-cons-threshold gc-cons-threshold)

(defvar default-gc-cons-threshold 20000000)

(defun my-minibuffer-setup-hook ()
  "Set the garbage collection threshold to the maximum."
  (setq gc-cons-threshold most-positive-fixnum)
  )

(defun my-minibuffer-exit-hook ()
  "Set the garbage collection threshold to the default."
  (setq gc-cons-threshold default-gc-cons-threshold)
  )

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;; While initing, max out gc threshold
(setq gc-cons-threshold most-positive-fixnum)

;;datetime things
(defvar current-date-time-format "%Y-%m-%dT%H:%M:%S"
  "Format of date to insert with `insert-current-date-time' func.
See help of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "Insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert (format-time-string current-date-time-format (current-time))))

(defun find-user-init-file ()
  "Edit `user-init-file` without opening a new window."
  (interactive)
  (find-file user-init-file)
  )

(defun user-emacs-subdirectory (subdir)
  "Not sure if needed, but I don't like how arbitrary `~/.emacs.d/` is.
SUBDIR should not have a `/` in front."
  (concat user-emacs-directory subdir)
  )


;; Packages

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-2" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/")) ;
(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/")) ; https://marmalade-repo.org/packages/#windowsinstructions
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  )
;; (package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t) ;; make sure we download when necessary

(add-to-list 'load-path (user-emacs-subdirectory "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (package-install 'el-get)
  (require 'el-get)
  )
(add-to-list 'el-get-recipe-path (user-emacs-subdirectory "el-get-user/recipes"))
(el-get 'sync)

(use-package async
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1)
  )


(use-package elpy
  :config
  (elpy-enable); TODO: configure elpy
  )

;; ;; Example el-get-sources
;; (setq el-get-sources
;;       '(:name yasnippet
;;            :type github
;;            :pkgname "joaotavora/yasnippet"
;;            :after (yas-global-mode 1)
;;            )
;;       )

(use-package yasnippet
  :config
  (yas-global-mode 1)
  )

;; activate helm mode
(use-package helm
  :config
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key helm-map (kbd "C-w") 'evil-delete-backward-word)
  )

(use-package helm-org-rifle)

(use-package git-gutter
  :config
  (if (display-graphic-p) (use-package git-gutter-fringe))
  (global-git-gutter-mode 1)
  )

(use-package helm-hunks
  :commands (helm-hunks
             helm-hunks-current-buffer
             helm-hunks-staged
             helm-hunks-staged-current-buffer)
  :config
  (add-hook 'helm-hunks-refresh-hook 'git-gutter+-refresh)
  )

;;solarized dark theme
(use-package solarized-theme
  :config
  (setq solarized-use-variable-pitch nil
        solarized-scale-org-headlines nil
        solarized-high-contrast-mode-line t) ;;unscrew org layout
  (load-theme 'solarized-dark t)
  )

(use-package powershell)

(use-package beacon
  :config
  (beacon-mode 0)
  )

;; (use-package indent-guide ;; this might be a performance hit
;;   :config
;;   (set-face-background 'indent-guide-face "#073642")
;;   (setq indent-guide-delay 0.0
;;      indent-guide-char " ")
;;   (indent-guide-global-mode)
;;   )

(use-package highlight-indent-guides
  :config
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  ;; character || column || fill
  (setq highlight-indent-guides-method 'column
        highlight-indent-guides-character ?\|)
  )

(use-package company
  :config

  (use-package company-quickhelp
    :config
    (company-quickhelp-mode 1)
    (setq company-quickhelp-delay 1)
    )

  (use-package company-jedi
    :config
    (defun my/python-mode-hook ()
      (add-to-list 'python-mode-hook 'company-jedi))
    (add-hook 'python-mode-hook 'my/python-mode-hook)
    )

  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  (use-package helm-company)

  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  (setq company-dabbrev-downcase nil)
  (setq company-idle-delay 0)
  (setq company-require-match nil)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-w") 'company-abort)

  (defun my-universal-complete()
    (interactive)
    (company-complete-selection)
    (company-complete))

  (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-w") 'evil-delete-backward-word)
  (add-hook 'after-init-hook 'global-company-mode)
  )

(use-package projectile
  :config
  (use-package helm-projectile)
  (add-hook 'after-init-hook #'projectile-mode)
  )

(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode 1)
  )

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  )

(use-package spu
  :defer 5 ;; defer package loading for 5 second
  :config (spu-package-upgrade-daily))

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

(use-package tramp-term)

(use-package docker-tramp)

;; (use-package linum-relative)

(use-package which-key
  :config
  ;; (setq which-key-popup-type 'minibuffer)
  (which-key-mode 1)
  )

(use-package groovy-mode)

(use-package php-mode)

(use-package dockerfile-mode)

(use-package markdown-mode)

(use-package minimap)

(use-package multiple-cursors)

(use-package transpose-frame)

(use-package buffer-move)

(use-package origami
  :init
  (use-package dash)
  (use-package s)
  :config
  (global-origami-mode 1)
  ) ;; todo: map z-a, z-r, and z-m to these functions. i want folding dammit

(use-package centered-window-mode
  :config
  (centered-window-mode t)
  )

(use-package sublimity
  :config
  (if (display-graphic-p) (require 'sublimity-attractive))
  )

;; (use-package guide-key
;;   :config
;;   (setq guide-key/guide-key-sequence t)
;;   (guide-key-mode 1)
;;   )

(use-package emmet-mode
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable emmet's css abbreviation.
  (setq emmet-move-cursor-between-quotes t) ;; default nil
  )

(use-package evil-leader
  :init
  (add-to-list 'load-path (user-emacs-subdirectory "packages/evil-leader"))
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "<SPC>"	'helm-M-x
    "f"		'helm-find-files
    "F"		'helm-projectile
    "\\"	'helm-hunks
    "t"		'insert-current-date-time
    "cc"	'comment-or-uncomment-region
    "a"		'evil-lion-left
    "."		'centered-window-mode
    ","		'magit-status
    "/"         'highlight-indent-guides-mode
    )
  )

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)

  :config
  (evil-mode 1)

  (setq sentence-end-double-space nil)
  (evil-set-initial-state 'info-mode 'normal)
  (setq evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
  (setq evil-motion-state-modes nil)
  (define-key global-map (kbd "C-f") 'universal-argument)
  (define-key universal-argument-map (kbd "C-u") nil)
  (define-key universal-argument-map (kbd "C-f") 'universal-argument-more)
  (define-key global-map (kbd "C-u") 'kill-whole-line)
  (eval-after-load 'evil-maps
    '(progn
       (define-key evil-motion-state-map (kbd "C-f") nil)
       (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)

       (define-key evil-normal-state-map (kbd "gt") '(lambda () (interactive) (other-frame 1)))
       (define-key evil-normal-state-map (kbd "gT") '(lambda () (interactive) (other-frame -1)))

       (define-key evil-ex-map "b" 'helm-buffers-list)
       (define-key evil-ex-map "e" 'helm-find-files)
       ;; (define-key evil-ex-map "vsp"
       ;;   '(lambda()
       ;;      (interactive)
       ;;      (split-window-horizontally)
       ;;      (other-window 1)
       ;;      ;; (call-interactively #'helm-find-files)
       ;;      )
       ;;   )
       ;; (define-key evil-ex-map "sp"
       ;;   '(lambda()
       ;;      (interactive)
       ;;      (split-window-vertically)
       ;;      (other-window 1)
       ;;      ;; (call-interactively #'helm-find-files)
       ;;      )
       ;;   )
       (define-key evil-ex-map "tabe"
         '(lambda()
            (interactive)
            (make-frame)
            ;; (call-interactively #'helm-find-files)
            )
         )
       )
    )

  ;; Let _ be considered part of a word
  (defadvice evil-inner-word (around underscore-as-word activate)
    (let ((table (copy-syntax-table (syntax-table))))
      (modify-syntax-entry ?_ "w" table)
      ;; (modify-syntax-entry ?- "w" table)
      (with-syntax-table table ad-do-it)
      )
    )
  ;; remap paste command
  (defun evil-paste-after-from-0 ()
    (interactive)
    (let ((evil-this-register ?0))
      (call-interactively 'evil-paste-after)))
  (define-key evil-visual-state-map "p" 'evil-paste-after-from-0)

  ;; change mode-line color by evil state
  (lexical-let ((default-color (cons (face-background 'mode-line)
                                     (face-foreground 'mode-line))))
    (add-hook 'post-command-hook
              (lambda ()
                (let ((color (cond ((minibufferp) default-color)
                                   ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                                   ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                                   ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                                   (t default-color))))
                  (set-face-background 'mode-line (car color))
                  (set-face-foreground 'mode-line (cdr color))))))

  ;;see if we can fix this to make it work or something
  (defun my-vertical-split(&optional COUNT FILE)
    (if (bound-and-true-p centered-window-mode)
        (progn (centered-window-mode nil)
               (evil-window-vsplit COUNT FILE)
               (centered-window-mode t))
      (evil-window-vsplit COUNT FILE)
      )
    )

  ;; This is how you define commands
  ;; (evil-ex-define-cmd "b[utterfly]"  'butterfly)
  (evil-ex-define-cmd "re[cent]"        'helm-recentf)
  (evil-ex-define-cmd "pr[ojectile]"    'helm-projectile)
  (evil-ex-define-cmd "or[gsearch]"     'helm-org-rifle)
  ;; (evil-ex-define-cmd "vsp[lit]"     'my-vertical-split) ;; this won't solve the bug
  (evil-ex-define-cmd "tabn[ew]"        'make-frame)
  ;; (evil-ex-define-cmd "tabe[dit]"        'make-frame)
  (evil-ex-define-cmd "vsp[lit]" '(lambda()
                                    (interactive)
                                    (split-window-horizontally)
                                    (other-window 1)
                                    ;; (call-interactively #'helm-find-files)
                                    )
                      )
  (evil-ex-define-cmd "sp[lit]" '(lambda()
                                   (interactive)
                                   (split-window-vertically)
                                   (other-window 1)
                                   ;; (call-interactively #'helm-find-files)
                                   )
                      )

  (defun my-evil-org-new-item ()
    (interactive)
    (when (org-in-item-p)
      (org-insert-item)
      (evil-next-line-first-non-blank)
      (evil-append 1)
      (insert " ")
      )
    )

  (defun my-evil-org-toggle-checkbox ()
    "If the list element has no checkbox, add one. Do nothing otherwise"
    (interactive)
    ;; (setq prefix-arg '(4)) ;; prefix arguments are WEIRD.
    (save-excursion (org-toggle-checkbox '(4)))
    )

  (defun my-evil-org-new-indent ()
    (interactive)
    (my-evil-org-new-item)
    (org-indent-item)
    )

  (defmacro my-evil-update-cursor-eol(func)
    (lambda ()
      (interactive)
      (func)
      (end-of-line)))

  ;; bind evil normal keymodes inside orgmode
  (evil-declare-key 'normal org-mode-map
    (kbd "L") 'org-shiftright
    (kbd "H") 'org-shiftleft
    (kbd "K") 'org-shiftup
    (kbd "J") 'org-shiftdown
    (kbd "RET") 'my-evil-org-new-item
    (kbd "M-l") 'org-metaright
    (kbd "M-h") 'org-metaleft
    (kbd "M-k") 'org-metaup
    (kbd "M-j") 'org-metadown
    (kbd "M-L") '(my-evil-update-cursor-eol(org-shiftmetaright))
    (kbd "M-H") '(my-evil-update-cursor-eol(org-shiftmetaleft))
    (kbd "M-K") '(my-evil-update-cursor-eol(org-shiftmetaup))
    (kbd "M-L") '(my-evil-update-cursor-eol(org-shiftmetadown))
    )

  (evil-declare-key 'insert org-mode-map
    (kbd "M-l") 'org-metaright
    (kbd "M-h") 'org-metaleft
    (kbd "M-k") 'org-metaup
    (kbd "M-j") 'org-metadown
    (kbd "M-L") 'org-shiftmetaright
    (kbd "M-H") 'org-shiftmetaleft
    (kbd "M-K") 'org-shiftmetaup
    (kbd "M-L") 'org-shiftmetadown
    )
  )

(use-package evil-surround
  :config
  (global-evil-surround-mode 1)
  (setq-default evil-surround-pairs-alist (cons '(?~ . ("~" . "~"))
                                                evil-surround-pairs-alist)))

(use-package evil-args
  :config
  ;; bind evil-args text objects
  (define-key evil-inner-text-objects-map "i" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
  ;; bind evil-forward/backward-args
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg)
  ;; bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args)
  )

;; (use-package evil-numbers
;;   :config
;;   (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
;;   (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
;;   )

;; (use-package evil-vimish-fold
;;   :config
;;   (evil-vimish-fold-mode 1)
;;   )

(use-package evil-args)
(use-package evil-lion
  :config (evil-lion-mode))
(use-package evil-matchit)
(use-package evil-cleverparens)
(use-package evil-commentary)
(use-package evil-replace-with-register)
(use-package evil-text-object-python)
(use-package evil-magit)
(use-package evil-indent-textobject)
(use-package vi-tilde-fringe
  :config (global-vi-tilde-fringe-mode 1))
(use-package evil-visualstar
  :config (global-evil-visualstar-mode))

;; ;; This was causing some performance issues
;; (use-package evil-tabs
;;   :init
;;   (use-package elscreen)
;;   :config
;;   (global-evil-tabs-mode t)
;;   )

(use-package powerline
  :config

  (use-package powerline-evil
    :config
    (powerline-evil-vim-color-theme)
    )

  (powerline-default-theme)
  )

;; orgmode bindings
(use-package org-evil
  :config
  (setq org-M-RET-may-split-line nil) ;; so we can press 'o' in evil and generate the next item
  )

(add-to-list 'auto-mode-alist '("\\Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\Jenkinsfile\\'" . groovy-mode))

(setq custom-file (user-emacs-subdirectory "custom.el"))
(load custom-file)

;; No startup screen
(setq inhibit-startup-screen t)

;; turn on line numbers
(global-linum-mode 0) ;; THIS MIGHT HAVE PERFORMANCE ISSUES

;; set default font
(add-to-list 'default-frame-alist '(font . "Consolas-11"))

;; startup maximised
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; autopairing
(electric-pair-mode 1)

;; indentation
(electric-indent-mode 1)
(setq-default indent-tabs-mode nil)

;; Remove toolbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)

(setq truncate-lines    t
      tab-width         8
      auto-hscroll-mode t)

;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line  "#073642")
;; (set-face-foreground 'highlight nil)

;; Save buffer state
(desktop-save-mode 1)
(setq history-length 250)
(add-to-list 'desktop-globals-to-save 'file-name-history)

;; Display time
(display-time-mode 1)

;; strip whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; org mode maps
(eval-after-load 'org-mode
  '(define-key org-mode-map (kbd "S-SPC") 'org-toggle-checkbox)
  )


;; Remove really annoying bindings
(global-unset-key (kbd "M-:"))

;; Reduce gc threshold to more manageable values:
(setq gc-cons-threshold default-gc-cons-threshold)
