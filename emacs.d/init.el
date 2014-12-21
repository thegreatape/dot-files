; show line numbers
(global-linum-mode t)

; disable infernal beeping
(setq ring-bell-function 'ignore)

; disable toolbar
(tool-bar-mode -1)


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
  :init
  (progn
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

    (evil-mode t)))

(use-package markdown-mode
  :ensure t)

(use-package elisp-slime-nav
  :ensure t
  :init
  (progn
    (defun elisp-navigation-hook ()
      (elisp-slime-nav-mode)
      (turn-on-eldoc-mode))
    (add-hook 'emacs-lisp-mode-hook 'elisp-navigation-hook)
    (evil-define-key 'normal emacs-lisp-mode-map (kbd "K")
      'elisp-slime-nav-describe-elisp-thing-at-point)))

