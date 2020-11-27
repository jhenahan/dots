;;; -*- lexical-binding: t; buffer-read-only: t -*-
(defvar the--init-file-loaded-p nil
    "Non-nil if the init-file has already been loaded.
This is important for Emacs 27 and above, since our early
init-file just loads the regular init-file, which would lead to
loading the init-file twice if it were not for this variable.")

(cond
 ;; If already loaded, do nothing. But still allow re-loading, just
 ;; do it only once during init.
 ((and (not after-init-time) the--init-file-loaded-p))

 (t
  (setq the--init-file-loaded-p t)
  (defvar the-minimum-emacs-version "27.0"
    "THE does not support any Emacs version below this.")
  
  (setq package-enable-at-startup nil)
  
  (setq custom-file (expand-file-name
  		   (format "custom-%d-%d.el" (emacs-pid) (random))
  		   temporary-file-directory))
  (if (version< emacs-version the-minimum-emacs-version)
      (error (concat "THE Emacs requires at least Emacs %s, "
  		   "but you are running Emacs %s")
  	   the-minimum-emacs-version emacs-version)
    (let ((link-target
           (file-symlink-p (or user-init-file
    			   load-file-name
    			   buffer-file-name))))

      (defvar the-lib-file (expand-file-name
    			"the.org"
    			user-emacs-directory)
        "File containing main THE configuration. This file is loaded
        by init.el.")
    
      (unless (file-exists-p the-lib-file)
        (error "Library file %S does not exist" the-lib-file))
      (defvar the--finalize-init-hook nil
      	  "Hook run unconditionally after init, even if it fails.
      Unlike `after-init-hook', this hook is run every time the
      init-file is loaded, not just once.")
      (org-babel-load-file the-lib-file)
      (run-hooks 'the--finalize-init-hook)
      )
    )
  ))
