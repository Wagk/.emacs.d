;;; init.el --- Bootstrap further configurations

;;; Commentary:
;; Useful resources:
;; https://bling.github.io/blog/2013/10/27/emacs-as-my-leader-vim-survival-guide/
;; https://github.com/bbatsov/emacs-lisp-style-guide
;; https://github.com/noctuid/evil-guide

;; Latest builds can be found at:: alpha.gnu.org/gnu/emacs/pretest/windows/
;; https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/

;;; Code:

;; Note that docstrings for variables come *after* the value

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(setq user-full-name    "Pang Tun Jiang"
      user-mail-address "pang.tun.jiang@gmail.com")

;; buffer encoding systems
;; We do this here because the package system might need to know our preferences
(prefer-coding-system 'utf-8)

(defconst user-init-dir
  (file-name-as-directory
   (cond ((boundp 'user-emacs-directory) user-emacs-directory)
         ((boundp 'user-init-directory) user-init-directory)
         (t "~/.emacs.d/"))
   )
  "Sets up the startup directory.")

(defconst user-init-file
  (concat user-init-dir "init.el")
  "Points to init.el")

(defconst user-config-dir
  (file-name-as-directory
   (concat user-init-dir "config"))
  "Directory where all the user configuration files are stored")

;;;###autoload
(defun find-user-init-file ()
  "Edit `user-init-file` without opening a new window."
  (interactive)
  (find-file user-init-file)
  )

(defmacro measure-time (&rest body)
  "Measure the time it takes to evaluate BODY."
  `(let ((time (current-time)))
     ,@body
     (message "%.06f seconds." (float-time (time-since time)))))

;; TODO(pangt): make this take in relative paths
(defun load-user-config-file (file &rest files)
  "Load FILE (and FILES) as configuration.
Assumes that it:
- Is a string path to one or more configuration fila (i.e. elisp)
- Is relative to user-init-dir"
  (interactive "f")
  (measure-time
   (dolist (elem (cons file files))
     (let ((path (expand-file-name (concat user-init-dir elem))))
       (if (file-exists-p path)
           (progn (condition-case nil
                      (measure-time (load-file path))
                    (error
                     (message "There was an error while loading %s" elem)))
                  (message "Loaded %s" path))
         (message "Failed to load %s" path))))))

;; Add to load path our configuration folder
(add-to-list 'load-path user-config-dir)

;; TODO: this prints nothing apparently.
;; (message "Our working directory has the path of %s" (expand-file-name "."))

;; ;; tweak garbage collector before
;; (defvar default-gc-cons-threshold 20000000)
;; (setq gc-cons-threshold most-positive-fixnum)

(let ((gc-cons-threshold most-positive-fixnum))
  ;; local configuration variables
  (load-user-config-file "./local.el")

  ;; load each config file in order
  ;; config loading should prioritise most necessary bits, so in eventuality of
  ;; bad loads we can fix it from inside emacs
  (load-user-config-file
   "./config/config-utility.el"
   "./config/config-package.el"
   "./config/config-common.el"
   "./config/config-vars.el"

   "./config/config-colors.el"

   "./config/config-evil.el"
   "./config/config-helm.el"
   "./config/config-buffer.el"
   "./config/config-startup.el"
   "./config/config-indent.el"
   "./config/config-git.el"
   "./config/config-org.el"
   "./config/config-deft.el"
   "./config/config-project.el"
   "./config/config-lint.el"
   "./config/config-completion.el"
   "./config/config-tags.el"
   "./config/config-fs.el"

   "./config/config-prog.el" ;; program-related configs
   "./config/config-webdev.el"
   "./config/config-lisp.el"
   "./config/config-cpp.el"
   "./config/config-python.el"
   "./config/config-rust.el"

   "./config/config-tex.el"

   "./config/config-diff.el"
   "./config/config-shell.el"
   "./config/config-tramp.el"
   "./config/config-crypto.el"

   "./config/config-draw.el"
   "./config/config-visualise.el"

   "./config/config-japanese.el"
   "./config/config-chinese.el"
   "./config/config-finance.el"
   "./config/config-journal.el"
   "./config/config-web-browsing.el"

   "./config/config-help.el"
   "./config/config-emacs.el"
   )

  ;; Disable ANNOYING customize options
  (setq custom-file (concat user-init-dir "custom.el"))
  (load custom-file 'noerror)
  ;; (garbage-collect)
  )

;; (setq garbage-collection-messages t)
;; (add-hook 'focus-out-hook 'garbage-collect)
;; (setq gc-cons-threshold 20000)
