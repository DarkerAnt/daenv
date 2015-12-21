(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 83 :width normal)))))

;; [package management]
;; MELPA
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
    (package-initialize))

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

;; [evil mode]
(use-package evil
  :ensure t
  :init (evil-mode 1))

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
