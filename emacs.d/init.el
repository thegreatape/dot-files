; show line numbers
(global-linum-mode t)

; disable infernal beeping
(setq ring-bell-function 'ignore)

; disable toolbar
(tool-bar-mode -1)

; hide splash screen
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

; don't create backup~ files
(setq make-backup-files nil)

; soft word wrapping
(visual-line-mode t)

; treat underscores as word characters everywhere
(add-hook 'after-change-major-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

; set up package management with use-package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(push "~/.emacs.d/site-lisp/use-package" load-path)
(require 'use-package)

(use-package evil-leader
  :ensure t
  :init (global-evil-leader-mode)
  :config
  (progn
    (evil-leader/set-leader ",")
    (evil-leader/set-key "x" 'helm-M-x)
    (evil-leader/set-key-for-mode 'emacs-lisp-mode "e" 'eval-last-sexp)
    (evil-leader/set-key "b" 'ibuffer)
    (evil-leader/set-key "kb" 'kill-buffer)
    (evil-leader/set-key "t" 'projectile-find-file)
    (evil-leader/set-key "ag" 'projectile-ag)
    (evil-leader/set-key "pp" 'projectile-switch-project)))

(use-package evil
  :ensure t
  :init
  (progn
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

    (evil-mode t)))

(use-package ujelly-theme :ensure t)
(use-package markdown-mode :ensure t)
(use-package coffee-mode :ensure t)

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


(eval-after-load 'ibuffer
  '(progn
     (evil-set-initial-state 'ibuffer-mode 'normal)
     (evil-define-key 'normal ibuffer-mode-map
       (kbd "j") 'ibuffer-forward-line
       (kbd "k") 'ibuffer-backward-line)))

(use-package projectile
  :ensure t
  :init
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'helm)
    (setq projectile-enable-caching t)))

(use-package helm :ensure t)
(use-package helm-projectile :ensure t)
(use-package ag :ensure t)

(use-package clojure-mode :ensure t)
(use-package cider
  :ensure t
  :init
  (progn
    (define-key cider-repl-mode-map (kbd "C-h") 'cider-switch-to-last-clojure-buffer)
    (evil-set-initial-state 'cider-repl-mode 'emacs)
    (evil-leader/set-key-for-mode 'clojure-mode "e" 'cider-eval-last-sexp-to-repl)))

(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize))

(use-package less-css-mode :ensure t)
