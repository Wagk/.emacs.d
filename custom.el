(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(centered-window-mode nil)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "f4b09aed5ada9438495c8758658bd338b3746eb35a4bd95d64b61047d40c4ab5" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "04886f04f33dfc156dc60b5a4b1f6f67da710eae8b39af6cf72f5f0b908948ee" default)))
 '(fci-rule-color "#073642")
 '(helm-mode t)
 '(helm-mode-fuzzy-match t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(ivy-mode t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (color-theme-solarized org-projectile helm-emmet misc-cmds persp-projectile perspective tide typescript-mode json-mode git-gutter-fringe+ git-gutter+ helm-fuzzier helm-descbinds helm-describe-modes neotree rainbow-delimiters evil-mc epa-file helm-flx helm-swoop counsel evil-visualstar buffer-move transpose-frame helm-hunks highlight-indent-guides org-brain helm-org-rifle evil-indent-textobject evil-cleverparens evil-lion vi-tilde-fringe vi-tilde-fringe-mode beacon centered-window-mode git-gutter-fringe sublimity-attractive which-key linum-relative spu company-jedi markdown-mode emmet-mode php-mode dockerfile-mode powerline powerline-evil git-gutter guide-key flycheck aggressive-indent whitespace-cleanup-mode evil-matchit evil-vimish-fold groovy-mode fireplace company-quickhelp ## discover helm-company elpy evil-tabs docker-tramp evil-text-object-python tramp-term company powershell use-package solarized-theme org-evil helm evil-surround evil-replace-with-register evil-numbers evil-magit evil-leader evil-commentary evil-args)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(projectile-mode t nil (projectile))
 '(safe-local-variable-values
   (quote
    ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook
            (quote write-contents-functions)
            (lambda nil
              (delete-trailing-whitespace)
              nil))
           (require
            (quote whitespace))
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
     (whitespace-style face tabs trailing lines-tail))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sublimity-mode nil)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(truncate-lines t)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(window-divider-mode t)
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"])
 '(yas-snippet-dirs
   (quote
    ("c:/Users/Pang/AppData/Roaming/.emacs.d/snippets" yas-installed-snippets-dir "c:/Users/Pang/AppData/Roaming/.emacs.d/elpa/elpy-20170414.319/snippets/"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((((background dark) (type graphic)) (:foreground "#586e75" :background "#073642")) (((background dark) (type tty) (min-colors 256)) (:foreground "brightgreen" :background "black")) (((background dark) (type tty) (min-colors 16)) (:foreground "brightgreen" :background "black")) (((background dark) (type tty) (min-colors 8)) (:foreground "green" :background "black")) (((background light) (type graphic)) (:foreground "#93a1a1" :background "#eee8d5")) (((background light) (type tty) (min-colors 256)) (:foreground "brightcyan" :background "white")) (((background light) (type tty) (min-colors 16)) (:foreground "brightcyan" :background "white")) (((background light) (type tty) (min-colors 8)) (:foreground "cyan" :background "white"))))
 '(org-level-1 ((((background dark) (type graphic)) (:inherit outline-1)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-1)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-1)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-1)) (((background light) (type graphic)) (:inherit outline-1)) (((background light) (type tty) (min-colors 256)) (:inherit outline-1)) (((background light) (type tty) (min-colors 16)) (:inherit outline-1)) (((background light) (type tty) (min-colors 8)) (:inherit outline-1))))
 '(org-level-2 ((((background dark) (type graphic)) (:inherit outline-2)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-2)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-2)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-2)) (((background light) (type graphic)) (:inherit outline-2)) (((background light) (type tty) (min-colors 256)) (:inherit outline-2)) (((background light) (type tty) (min-colors 16)) (:inherit outline-2)) (((background light) (type tty) (min-colors 8)) (:inherit outline-2))))
 '(org-level-3 ((((background dark) (type graphic)) (:inherit outline-3)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-3)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-3)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-3)) (((background light) (type graphic)) (:inherit outline-3)) (((background light) (type tty) (min-colors 256)) (:inherit outline-3)) (((background light) (type tty) (min-colors 16)) (:inherit outline-3)) (((background light) (type tty) (min-colors 8)) (:inherit outline-3))))
 '(org-level-4 ((((background dark) (type graphic)) (:inherit outline-4)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-4)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-4)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-4)) (((background light) (type graphic)) (:inherit outline-4)) (((background light) (type tty) (min-colors 256)) (:inherit outline-4)) (((background light) (type tty) (min-colors 16)) (:inherit outline-4)) (((background light) (type tty) (min-colors 8)) (:inherit outline-4))))
 '(org-level-5 ((((background dark) (type graphic)) (:inherit outline-5)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-5)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-5)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-5)) (((background light) (type graphic)) (:inherit outline-5)) (((background light) (type tty) (min-colors 256)) (:inherit outline-5)) (((background light) (type tty) (min-colors 16)) (:inherit outline-5)) (((background light) (type tty) (min-colors 8)) (:inherit outline-5))))
 '(org-level-6 ((((background dark) (type graphic)) (:inherit outline-6)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-6)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-6)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-6)) (((background light) (type graphic)) (:inherit outline-6)) (((background light) (type tty) (min-colors 256)) (:inherit outline-6)) (((background light) (type tty) (min-colors 16)) (:inherit outline-6)) (((background light) (type tty) (min-colors 8)) (:inherit outline-6))))
 '(org-level-7 ((((background dark) (type graphic)) (:inherit outline-7)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-7)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-7)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-7)) (((background light) (type graphic)) (:inherit outline-7)) (((background light) (type tty) (min-colors 256)) (:inherit outline-7)) (((background light) (type tty) (min-colors 16)) (:inherit outline-7)) (((background light) (type tty) (min-colors 8)) (:inherit outline-7))))
 '(org-level-8 ((((background dark) (type graphic)) (:inherit outline-8)) (((background dark) (type tty) (min-colors 256)) (:inherit outline-8)) (((background dark) (type tty) (min-colors 16)) (:inherit outline-8)) (((background dark) (type tty) (min-colors 8)) (:inherit outline-8)) (((background light) (type graphic)) (:inherit outline-8)) (((background light) (type tty) (min-colors 256)) (:inherit outline-8)) (((background light) (type tty) (min-colors 16)) (:inherit outline-8)) (((background light) (type tty) (min-colors 8)) (:inherit outline-8)))))
