; show line numbers
(global-linum-mode t)

; disable infernal beeping
(setq ring-bell-function 'ignore)

; disable toolbar
(tool-bar-mode -1)

; disable scrollbars
(set-scroll-bar-mode nil)

; don't blink the cursor
(blink-cursor-mode 0)

; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

; highlight matching parens
(show-paren-mode)

; hide splash screen
(setq inhibit-splash-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

; don't create backup~ files
(setq make-backup-files nil)

; treat underscores as word characters everywhere
(add-hook 'after-change-major-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

; remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; use spaces instead of tabs for indentation
(setq-default indent-tabs-mode nil)

; set tab stops every 2 characters
(setq tab-stop-list (number-sequence 2 120 2))

; default to 2 space indentation
(setq-default tab-width 2)

; set up us the fonts
(setq my-font-size 13)

(defun set-font (size)
  (let ((monaco (concat "Monaco:pixelsize=" (number-to-string size) ":weight=normal:slant=normal:width=normal:spacing=100:scalable=true")))
    (set-face-attribute 'default nil :font monaco)
    (set-frame-font monaco nil t)))
(defun embiggen-font ()
  (interactive)
  (setq my-font-size (+ my-font-size 1))
  (set-font my-font-size))
(defun debiggen-font ()
  (interactive)
  (setq my-font-size (- my-font-size 1))
  (set-font my-font-size))

(global-set-key (kbd "M-=") 'embiggen-font)
(global-set-key (kbd "M--") 'debiggen-font)
(set-font my-font-size)

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

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
    (evil-leader/set-key "pp" 'projectile-switch-project)
    (evil-leader/set-key "cl" 'evilnc-comment-or-uncomment-lines)
    (evil-leader/set-key "n" 'rename-current-buffer-file)))

(use-package evil
  :ensure t
  :init
  (progn
    ; changing indentation with < and > should use tab-width's worth of indent
    (custom-set-variables '(evil-shift-width tab-width))

    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

    (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
    (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
    (define-key evil-insert-state-map (kbd "M-v") 'evil-paste-after)

    ; Bind escape to quit minibuffers
    (defun minibuffer-keyboard-quit ()
        "Abort recursive edit.
      In Delete Selection mode, if the mark is active, just deactivate it;
      then it takes a second \\[keyboard-quit] to abort the minibuffer."
        (interactive)
        (if (and delete-selection-mode transient-mark-mode mark-active)
        (setq deactivate-mark  t)
          (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
          (abort-recursive-edit)))

    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
    (global-set-key [escape] 'evil-exit-emacs-state)

    (evil-mode t)))

; make control-W delete backwards in the minibuffer
(define-key minibuffer-local-map (kbd "C-w") 'backward-kill-word)

(use-package evil-nerd-commenter :ensure t)

(use-package atom-dark-theme :ensure t)

;;
;; writing mode stuff to emulate vim's goyo plugin
;;
(setq writing-mode-settings-enabled nil)

(defun set-writing-fringe ()
  (let ((padding (/ (- (window-pixel-width)
		       (* 80 (frame-char-width)))
		    2)))
    (set-window-fringes (selected-window) padding padding)))

(defun toggle-writing-mode-settings ()
  (interactive)
  (if writing-mode-settings-enabled
	(progn
	  (set-window-fringes nil 10) ; reset window margins
	  (linum-mode 1)              ; enable line numbering
    (visual-line-mode 0)        ; disable soft word wrapping
	  (setq writing-mode-settings-enabled nil))
	(progn
	  (set-writing-fringe)        ; set nice writing margins
	  (linum-mode 0)              ; disable line numbering
    (visual-line-mode 1)        ; enable soft word wrapping
	  (setq writing-mode-settings-enabled t))))
(evil-leader/set-key "gp" 'toggle-writing-mode-settings)

(use-package markdown-mode :ensure t)

(use-package coffee-mode
  :ensure t
  :init
  (progn
    (defun coffee-vi-o ()
      "work-around indentation being broken in coffeescript + evil when inserting a new line below the current line"
      (interactive)
      (progn
        (evil-append-line 1)
        (coffee-newline-and-indent)
        (evil-insert 1)
        ))
    (defun coffee-vi-O ()
      "work-around indentation being broken in coffeescript + evil when inserting a new line above the current line"
      (interactive)
      (progn
        (evil-previous-line)
        (coffee-vi-o)
        ))
    (evil-define-key 'normal coffee-mode-map (kbd "o") 'coffee-vi-o)
    (evil-define-key 'normal coffee-mode-map (kbd "O") 'coffee-vi-O)

    ;; coffee-mode's tab-width has to be set manually for some reason
    (setq coffee-tab-width 2))
  )

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

; always start find-file from projectile-defined project root
(add-hook 'find-file-hook (lambda ()
			    (setq default-directory (projectile-project-root))))

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
(use-package haml-mode :ensure t)

(use-package projectile-rails
  :ensure t
  :init
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

(use-package scss-mode
  :ensure t
  :init
   (setq css-indent-offset 2))

(use-package evil-matchit
  :ensure t
  :init
  (global-evil-matchit-mode 1))

(use-package enh-ruby-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
    (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))))
