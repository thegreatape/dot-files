; show line numbers
(global-linum-mode t)

; set up package management with use-package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(push "~/.emacs.d/site-lisp/use-package" load-path)
(require 'use-package)

(use-package ujelly-theme
	     :ensure t)

(use-package evil
  :ensure t
  :init (evil-mode t))
