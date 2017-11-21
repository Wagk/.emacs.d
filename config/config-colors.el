;;; config-colors.el --- colorscheme configurations

;;; Commentary:

;;; Code:
(require 'config-package)

(setq frame-background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)

;; (use-package base16-theme
;;   :if (not (display-graphic-p))
;;   :config
;;   (load-theme 'base16-solarized-dark t))

;; (use-package moe-theme
;;   :demand t
;;   :if (not (display-graphic-p))
;;   :config
;;   (moe-dark))

;; (use-package color-theme-solarized
;;   :demand t
;;   ;; :if (display-graphic-p)
;;   :config
;;   (color-theme-solarized)
;;   (setq solarized-termcolors 256)
;;   (load-theme 'solarized t)
;;   )

(use-package solarized-theme
  :demand t
  ;; :if (display-graphic-p)
  :config
  (setq solarized-use-variable-pitch nil
        solarized-distinct-fringe-background t
        solarized-high-contrast-mode-line t)
  (load-theme 'solarized-dark t))

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


(provide 'config-colors)

;;; config-colors.el ends here
