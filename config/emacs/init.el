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
  
  (if (version< emacs-version the-minimum-emacs-version)
      (error (concat "THE Emacs requires at least Emacs %s, "
  		   "but you are running Emacs %s")
  	   the-minimum-emacs-version emacs-version)
      (defvar the-lib-file (concat user-emacs-directory "the.org")
        "File containing main THE configuration. This file is loaded
        by init.el.")
    
      (unless (file-exists-p the-lib-file)
        (error "Library file %S does not exist" the-lib-file))
      (defvar the--finalize-init-hook nil
      	  "Hook run unconditionally after init, even if it fails.
      Unlike `after-init-hook', this hook is run every time the
      init-file is loaded, not just once.")
      ;; HACK
      (let*
          ((org-modified (file-attribute-modification-time (file-attributes the-lib-file)))
           (el-file (concat (file-name-sans-extension the-lib-file) ".el"))
           (el-modified (file-attribute-modification-time (file-attributes el-file)))
           (org-updated-p (time-less-p el-modified org-modified)))
        (delete-file el-file))
      (org-babel-load-file the-lib-file)
      (run-hooks 'the--finalize-init-hook)
    )
  ))
