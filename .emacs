;; Detect OS
(defvar w32 (string-match "windows" (symbol-name system-type)))
(defvar darwin (string-match "darwin" (symbol-name system-type)))
(defvar linux (string-match "gnu/linux" (symbol-name system-type)))

;; Don't create backup files
(setq make-backup-files nil)

;; Set tab distance in spaces
(setq c-basic-offset 4)

;; Syntax highlighting
(global-font-lock-mode t)

;; Add load dir for external packages 
(add-to-list 'load-path "~/.emacs.d/site-lisp")

; Load editing modes
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'django-html-mode "django-html-mode" "Django template mode" t)
(autoload 'js2-mode "js2" nil t)
(autoload 'ruby-mode "ruby-mode" "Ruby mode" t)
(autoload 'css-mode "css-mode" "CSS mode" t)
(autoload 'light-symbol-mode "light-symbol" "Light Symbol Mode" t)
(autoload 'setnu-mode "setnu" "Line Number Mode" t)

;; Associate file extensions with major modes
(setq auto-mode-alist
      (append '(("\\.tal$"   . sgml-mode))
			  '(("\\.js$"    . js2-mode))
			  '(("\\.css$"   . css-mode))
			  '(("\\.rb$"    . ruby-mode))
			  '(("\\.py$"    . python-mode))
			  '(("\\.djhtml$"    . django-html-mode))
			  auto-mode-alist))

; Lose the GUI
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Load some useful minor modes by default
(show-paren-mode)
(transient-mark-mode)

;; MacOS X specific stuff
(setq mac-option-modifier 'hyper)
;;(setq mac-command-modifier 'meta)

;; Custom delete keybinds
(global-set-key "\C-h" 'backward-kill-word)
(global-set-key "\M-h" 'backward-delete-char-untabify)
(global-set-key "\C-p" 'kill-word)
(global-set-key "\M-p" 'delete-char)

;; Custom navigation keybindings
(global-set-key "\C-\M-l" 'forward-word)
(global-set-key "\C-\M-j" 'backward-word)

;; Custon functional keybindings
(global-set-key "\C-n" 'setnu-mode)
(global-set-key "\C-r" 'query-replace)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-/" 'hippie-expand)

;; Set hippie-expand functions
(setq hippie-expand-try-functions-list '( yas/hippie-try-expand 
					  try-expand-all-abbrevs
					  try-expand-dabbrev
					  try-expand-dabbrev-all-buffers
					  try-expand-dabbrev-from-kill
					  try-complete-file-name-partially
					  try-complete-file-name
					  try-complete-lisp-symbol-partially 
					  try-complete-lisp-symbol))

;; Set default font
(if w32 (set-face-font 'default "-outline-Monaco-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1"))

;; No silly splash screens, please
(setq inhibit-startup-message t)

;; Enable up and downcase region 
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Enable badass buffer switching
(iswitchb-mode)

;; Lorem ipsum filler text stuff
(load "lorem-ipsum")

;; Buffer-wide collapsing / expanding
(defun toggle-selective-display()
  (interactive)
  (set-selective-display (if selective-display nil 1)))
;;(global-set-key (quote [f2 116]) (quote toggle-selective-display))

;; Line-break unborking
(defun dos-unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))
(defun unix-dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;; TODO move one-offs to seperate file
(defun tal-textify()
  "Replace old-style span replacement with new text expansion"
  (interactive)
  (query-replace-regexp "<span tal:replace=\"\\([^\"]*\\\)\"/>" "${\\1}"))

(defun tal-uri-fix()
  (interactive)
  (query-replace-regexp "\\(<span tal:replace=\"\[^\"]*getURI\"/>\\|${[^}]*URI}\\)" "\\1/"))

;; custom macros
(fset 'jsdoc-comment
	  [?/ ?* ?* return ? ])
(global-set-key "\M-'" 'jsdoc-comment)

;; override annoying beep function
(setq ring-bell-function (lambda() ))

;; yasnippet setup
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/site-lisp/snippets")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js2-auto-indent-flag nil)
 '(js2-basic-offset 4)
 '(js2-highlight-level 3)
 '(js2-idle-timer-delay 0.4)
 '(js2-use-font-lock-faces nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )