;;; -*- lexical-binding: t; buffer-read-only: t -*-
(defvar the-minimum-emacs-version "27.0"
  "THE does not support any Emacs version below this.")

(setq vc-handled-backends nil)

(if (version< emacs-version the-minimum-emacs-version)
    (error (concat "THE Emacs requires at least Emacs %s, "
  		   "but you are running Emacs %s")
  	   the-minimum-emacs-version emacs-version)
  (defvar the-lib-file (concat user-emacs-directory "the.org")
    "File containing main THE configuration. This file is loaded
        by init.el.")
  
  (unless (file-exists-p the-lib-file)
    (error "Library file %S does not exist" the-lib-file))

  (org-babel-load-file the-lib-file t)
  (run-hooks 'the-after-init-hook))
