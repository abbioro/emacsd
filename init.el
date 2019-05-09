(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;;; Main configuration
(fset 'yes-or-no-p 'y-or-n-p)
(setq disabled-command-function nil)
(setq ring-bell-function 'ignore)
(setq confirm-kill-emacs 'yes-or-no-p)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(setq org-fontify-whole-heading-line t)
(load-theme 'leuven t)

(when (eq system-type 'darwin)
  ;; Configure titlebar to match theme
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . nil))
  (add-to-list 'default-frame-alist '(ns-appearance . light)))

;; Disable backup and lockfiles (annoying)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Whitespace settings (spaces only)
(setq-default indent-tabs-mode nil)
(setq-default require-final-newline nil)
(setq-default mode-require-final-newline nil)

;; Move customizations to custom.el
(setq-default custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;;; OS settings
(pcase system-type
  ('darwin (set-face-attribute 'default nil :font "menlo 10"))
  ('windows-nt (set-face-attribute 'default nil :font "consolas 8")))

;;; Modes
(show-paren-mode t)
(column-number-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(desktop-save-mode t)

;;; Hooks
(add-hook 'org-mode-hook 'auto-fill-mode)

;;; Keybinds
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; PTT key
(global-unset-key (kbd "<f2> <f2>"))

;;; Package settings

;; Calc
(require 'calc)
(global-set-key (kbd "<f9>") 'calc)
(global-set-key (kbd "C-<f9>") 'full-calc)
(setq math-additional-units
      '((b nil "Bit")                   ; Overrides "barn"
        (B "8 * b" "Byte")
        ;; IEC byte prefixes
        (PiB "1024 * TiB" "Peta Byte")
        (TiB "1024 * GiB" "Tera Byte")
        (GiB "1024 * MiB" "Giga Byte")
        (MiB "1024 * KiB" "Mega Byte")
        (KiB "1024 * B" "Kilo Byte")
        ;; IEC bit prefixes
        (Pib "1024 * Tib" "Peta Bit")
        (Tib "1024 * Gib" "Tera Bit")
        (Gib "1024 * Mib" "Giga Bit")
        (Mib "1024 * Kib" "Mega Bit")
        (Kib "1024 * b" "Kilo Bit"))
      math-units-table nil)

;; Magit
(require 'magit)
(global-set-key (kbd "<f10>") 'magit-status)
(global-set-key (kbd "C-x g") 'magit-status)
(setq magit-diff-refine-hunk 'all)
;; Always use the entire frame for Magit
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
;; Disable built-in VC for git (recommended by magit manual)
(setq vc-handled-backends (delq 'Git vc-handled-backends))

;; Dired
(require 'dired)
(setq wdired-allow-to-change-permissions t)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;; Ediff
(require 'ediff)
;; Don't open a new frame for ediff (annoying)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; Put files side by side
(setq ediff-split-window-function (quote split-window-horizontally))
