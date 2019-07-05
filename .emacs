(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (markdown-mode evil-org evil-smartparens smartparens use-package linum-relative irony-eldoc helm-gtags flycheck-irony evil diminish company-irony color-theme-solarized))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 83 :width normal)))))

;; tabs as spaces
(setq indent-tabes-mode nil)
(setq-default tab-width 4)

;; [package management]
;; MELPA
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
    (package-initialize))

;; ido-mode
(ido-mode 1)

;; use-package
(setq package-list '(use-package))
(or (file-exists-p package-user-dir)
    (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
(eval-when-compile
  (require 'use-package))
(require 'diminish) ;; if you use :diminish
(require 'bind-key) ;; if you use any :bind variant

;; [colors]
;; solarized color theme
(use-package color-theme-solarized
  :ensure t
  :defer t
  :init
    (setq frame-background-mode 'dark)
    (setq solarized-use-terminal-theme t)
    (show-paren-mode 1)
    (load-theme 'solarized))

;; [evil mode]
(use-package evil
  :ensure t
  :init (evil-mode 1)
  :config
     ;; Switch windows with Vim keybindings
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right))

;; relative line numbers
(use-package linum-relative
  :ensure t
  :config
    (global-linum-mode t)
    (linum-relative-on))
    ;; Adds space after line number (does not work)
	;; (defadvice linum-update-window (around linum-dynamic activate)
	;; (let* ((w (length (number-to-string
	;; 					(count-lines (point-min) (point-max)))))
	;; 		(linum-format (concat "%" (number-to-string w) "d ")))
	;; 	ad-do-it))

;; Source code navigation and auto-completion

;-----------------------------;
;        C++ Indentation, Thanks to Joe L.
;-----------------------------;

(c-add-style "uatc-c-style"
  '((c-auto-newline                 . nil)
    (c-basic-offset                 . 4)
    (c-comment-only-line-offset     . 0)
    (c-hanging-braces-alist         . ((substatement-open after)
                                       (brace-list-open)))
    (c-offsets-alist                . ((arglist-close . c-lineup-arglist)
                                       (case-label . 4)
                                       (substatement-open . 0)
                                       (block-open . 0) ; no space before {
                                       (inline-open . 0) ; no space before {
                                       (knr-argdecl-intro . -)
                                       (innamespace . 0)))
    (c-hanging-colons-alist         . ((member-init-intro before)
                                       (inher-intro)
                                       (case-label after)
                                       (label after)
                                       (access-label after)))
    (c-cleanup-list                 . (scope-operator
                                       empty-defun-braces
                                       defun-close-semi))))

(setq-default indent-tabs-mode nil)
(c-set-offset 'comment-intro 0)
(setq c-default-style "uatc-c-style")
; delete whitespace from end of lines
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; commented to try company
;; (use-package rtags
;;   :ensure t
;;   :config
;;     (setq rtags-autostart-diagnostics t)
;; 	(setq rtags-completions-enabled t)
;; 	(push 'company-rtags company-backends)
;;     (global-company-mode)
;;     (setq rtags-show-containing-function t) ;; display function name in rtags-imenu
;; 	(rtags-enable-standard-keybindings)
;; 	(define-key c-mode-base-map (kbd "M-=") (function rtags-symbol-type))
;; 	(define-key c-mode-base-map (kbd "C-]") (function rtags-find-symbol-at-point))
;; 	(define-key c-mode-base-map (kbd "C-}") (function rtags-find-references-at-point))
;; 	(define-key c-mode-base-map (kbd "C-t") (function rtags-location-stack-back))
;; 	;;(define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
;; 	(define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-current-file))
;; 	(define-key c-mode-base-map (kbd "M-/") (function rtags-find-all-references-at-point))
;; 	(define-key c-mode-base-map (kbd "M-i") (function rtags-imenu))
;; 	(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete)))
;; ;; broken??? causes emacs to freeze
;; ;;    (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
;; ;;    (add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running))

;; (use-package flycheck-rtags
;;   :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode)
;;   :config
;;     (require 'flycheck-rtags))

;; (defun my-flycheck-rtags-setup ()
;;   (flycheck-select-checker 'rtags)
;;   (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;;   (setq-local flycheck-check-syntax-automatically nil))
;; ;; c-mode-common-hook is also called by c++-mode
;; (add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

;; ;; broken
;; ;; ;; highlight > 120 character lines
;; ;; (setq column-enforce-column 121)
;; ;; (global-column-enforce-mode)

(use-package company
  :ensure t)

;; [clang]
;; clang format
(load (concat (file-name-as-directory (getenv "CLANG_SRC_PATH")) "tools/clang-format/clang-format.el"))
(global-set-key [C-M-tab] 'clang-format-region)

;; [c/c++ ide]
;; code completion
(use-package company-irony
  :ensure t
  :config
    (eval-after-load 'company
      '(add-to-list 'company-backends 'company-irony)))

;; diagnostic reporting
(use-package flycheck-irony
  :ensure t
  :config
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

;; display symbol and function documentation
;; This seems abandoned. Look here for fix https://github.com/josteink/irony-eldoc
(use-package irony-eldoc
  :ensure t)

(use-package irony
  :ensure t
  :init
    ;; irony-mode (clang complete)
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)
    ;; replace the `completion-at-point' and `complete-symbol' bindings in
    ;; irony-mode's buffers by irony-mode's function
    (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
	'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
	'irony-completion-at-point-async))
    (add-hook 'irony-mode-hook 'my-irony-mode-hook)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (add-hook 'irony-mode-hook 'flycheck-mode)
    (add-hook 'irony-mode-hook 'irony-eldoc)
    (add-hook 'irony-mode-hook 'global-company-mode))

;; tags
(use-package helm
  :ensure t)

(use-package helm-gtags
  :ensure t
  :init
    ;; Enable helm-gtags-mode
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode)
    (add-hook 'java-mode-hook 'helm-gtags-mode)
    ;; remove conflicting evil mode keybindings
    (eval-after-load "evil-maps"
      (define-key evil-motion-state-map "\C-]" nil))
    ;; config options
    (setq
     helm-gtags-use-input-at-cursor t
     helm-gtags-auto-update t
     ;;helm-gtags-display-style 'detail
     helm-gtags-pulse-at-cursor t
     helm-gtags-suggested-key-mapping t))

;; smart parethesis
(use-package smartparens-config
  :ensure smartparens
  :init
    (add-hook 'c++-mode-hook #'smartparens-mode)
    (add-hook 'c-mode-hook #'smartparens-mode)
    (add-hook 'objc-mode-hook #'smartparens-mode)
    (add-hook 'python-mode-hook #'smartparens-mode)
    (add-hook 'asm-mode-hook #'smartparens-mode)
    (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
    ;; config options
    (setq
     ;;smartparens-strict-mode t
     sp-highlight-pair-overlay nil
     ;;sp-highlight-wrap-overlay nil
     sp-highlight-wrap-tag-overlay nil))

(use-package evil-smartparens
  :ensure t
  :init (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

;; org mode support
(use-package evil-org
  :ensure t
  :init
    (setq org-src-fontify-natively t))

;; [markdown]
(use-package markdown-mode
  :ensure t
  :init
	(autoload 'markdown-mode "markdown-mode"
		"Major mode for editing Markdown files" t)
	(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
	(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
	(add-hook 'markdown-mode-hook (lambda () (flyspell-mode 1))))
