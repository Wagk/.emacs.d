;;; config-buffer.el --- Buffer visual configuration

;;; Commentary:

;;; Code:

(require 'config-package)
(require 'config-evil)
(require 'config-common)

(use-package color-theme
  :ensure t)

(defconst $solarized-dark-base03   "#002b36")
(defconst $solarized-dark-base02   "#073642")
(defconst $solarized-dark-base01   "#586e75")
(defconst $solarized-dark-base00   "#657b83")
(defconst $solarized-dark-base0    "#839496")
(defconst $solarized-dark-base1    "#93a1a1")
(defconst $solarized-dark-base2    "#eee8d5")
(defconst $solarized-dark-base3    "#fdf6e3")
(defconst $solarized-dark-yellow   "#b58900")
(defconst $solarized-dark-orange   "#cb4b16")
(defconst $solarized-dark-red      "#dc322f")
(defconst $solarized-dark-magenta  "#d33682")
(defconst $solarized-dark-violet   "#6c71c4")
(defconst $solarized-dark-blue     "#268bd2")
(defconst $solarized-dark-cyan     "#2aa198")
(defconst $solarized-dark-green    "#859900")

(use-package solarized-theme
  :ensure t
  :config
  (setq solarized-use-variable-pitch nil
        solarized-distinct-fringe-background t
        solarized-high-contrast-mode-line t))

(use-package base16-theme
  :disabled
  :if (not (display-graphic-p))
  :ensure t
  :config
  (load-theme 'base16-solarized-dark t))

(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\|)
  (progn (require 'evil-leader)
         (evil-leader/set-key
           "'" 'highlight-indent-guides-mode))
  (highlight-indent-guides-mode)
  )

(use-package whitespace-cleanup-mode
  :ensure t
  :diminish t
  :config
  (global-whitespace-cleanup-mode 1))

(use-package hl-todo
  :ensure t
  :config
  (customize-set-variable 'hl-todo-keyword-faces
                          `(("TODO"  . ,$solarized-dark-yellow)
                            ("DEBUG" . ,$solarized-dark-magenta)
                            ("BUG"   . ,$solarized-dark-red)
                            ("DONE"  . ,$solarized-dark-green)
                            ("NOTE"  . ,$solarized-dark-base1)
                            ("HACK"  . ,$solarized-dark-violet)
                            ("FIXME" . ,$solarized-dark-orange)))
  (global-hl-todo-mode))

;; https://github.com/alpaker/Fill-Column-Indicator
(use-package fill-column-indicator
  :ensure t
  :diminish t
  :config
  (setq-default fill-column 80)
  ;; (setq fci-rule-width 23)
  (add-hook 'prog-mode-hook 'turn-on-fci-mode))

(use-package powerline
  :ensure t
  :config
  (powerline-vim-theme))

(use-package multi-term
  :ensure t
  :config
  (cond ((or (eq system-type 'ms-dos)
             (eq system-type 'windows-nt)) (setq multi-term-program "cmd"))
        (t (setq multi-term-program "/bin/bash")))
  (progn (require 'evil)
         (evil-ex-define-cmd "te[rminal]" 'multi-term)))

(use-package unicode-troll-stopper
  :ensure t)

(use-package transpose-frame
  :ensure t)

(use-package buffer-move
  :ensure t)

(use-package crosshairs
  :ensure t)

(defun /line-lengths()
  (let (length)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
        (push (- (line-end-position)
                 (line-beginning-position))
              length)
        (forward-line)))
    ;; we return a list since this is the last form evaluated
    (copy-sequence length)))

(defun /longest-line-length()
  (let ((lines (/line-lengths)))
    ;; return the first element, which should be the largest
    (nth 0 (sort lines '>))))

(defun /centre-window-function()
  ""
  (interactive)
  (let ((margin-size (/ (abs (- (window-width) (/longest-line-length))) 2)))
    (if (not (get '/centre-window-function 'active))
        (progn
          (set-window-margins nil margin-size nil)
          (fringe-mode '(1 . 1))
          (put '/centre-window-function 'active t))
      (progn
        (set-window-margins nil nil nil)
        (fringe-mode nil)
        (put '/centre-window-function 'active nil)))))

(evil-leader/set-key
  ";" '/centre-window-function)

;; Set transparency of emacs
(defun /set-frame-transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(add-hook 'prog-mode-hook 'hs-minor-mode)

(load-theme 'solarized-dark t)

;; no startup screen
(setq inhibit-startup-screen t)

;; startup maximised
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(setq require-final-newline t)

;; remove annoying bell sound
(setq ring-bell-function 'ignore)

;; Save buffer state
(setq history-length 250)

;; Display time
(display-time-mode 1)

;; strip whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(progn (require 'evil-leader)
       (evil-leader/set-key
         "." 'whitespace-mode))

;; automatically refresh buffer when changed outside
(global-auto-revert-mode t)

;; Remove toolbar
(progn (tool-bar-mode -1)
       (menu-bar-mode -1)
       (scroll-bar-mode -1)
       (window-divider-mode -1))

(setq tab-always-indent 'complete)

(setq-default truncate-lines    t  ;; no wrap
              indent-tabs-mode nil ;; do not use tabs when indenting
              tab-width         2
              auto-hscroll-mode t)

;; autopairing
(electric-pair-mode 1)

;; Change "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Frame-related functions
(add-hook 'after-make-frame-functions 'select-frame)

;; adjust autosave and backup directories
(setq backup-directory-alist `(("." . ,(concat user-init-dir "/backups/")))
      delete-old-versions -1
      version-control t
      vc-make-backup-files t
      auto-save-file-name-transforms `((".*" ,(concat user-init-dir "/autosave/") t)))

(provide 'config-buffer)

;;; config-buffer.el ends here
