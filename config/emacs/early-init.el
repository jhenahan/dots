;;; -*- lexical-binding: t; no-byte-compile: t -*-

(setq load-prefer-newer t)
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(defun the--advice-fix-display-graphic-p (func &optional display)
  "Fix `display-graphic-p' so it works while loading the early init-file."
  (if display
      (funcall func display)
    initial-window-system))
  
(advice-add #'display-graphic-p :around
            #'the--advice-fix-display-graphic-p)

