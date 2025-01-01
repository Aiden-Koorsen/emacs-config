(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages") t)
(package-initialize)

;; Stuff For OCAML
;; Stuff for OCAML
(add-to-list 'load-path
"C:/Users/aiden/AppData/Local/opam/default/share/emacs/site-lisp")
(require 'ocp-indent)

;; Ensure that theme is installed
(unless (package-installed-p 'solarized-theme)
  (package-refresh-contents)
  (package-install 'solarized-themes))

;; Load theme
;;(load-theme 'solarized-dark t)
(setq custom-theme-directory "~/.emacs.d/themes/")
(load-theme 'wombat-2 t)

(setq make-backup-files nil) ; stop creating ~ files

;; Eclipse-like C-backspace
(defun my-kill-back ()
  (interactive)
  (if (bolp)  ; beginning of line, just delete 1
      (backward-delete-char 1)
    (if (string-match "[^[:space:]]" (buffer-substring (point-at-bol) (point)))
        ;; There's a word on the line, delete it
        (backward-kill-word 1)
      (delete-region (point-at-bol) (point))))) ; all whitespace, delete it

(global-set-key [C-backspace] 'my-kill-back)

(setq menu-bar-select-buffer-function 'switch-to-buffer)

;; Disable bunch of clutter
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Disable the title screen
(setq inhibit-startup-screen t)

;; Start auto complete for brackets ;)
(electric-pair-mode 1)

;; Start line number mode
(global-display-line-numbers-mode 1)

;; Put all backup files in the saves directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; Set default tab size to 2
(setq-default tab-width 2)

;; Setup starting directory
(setq default-directory "C:/projects/")

;; Set font
(set-face-attribute 'default nil
                    :family "Consolas" :height 100)

;; Hopefully resize numbers
(add-hook 'text-scale-mode-hook (lambda() (face-remap--remap-face 'line-number)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 '(markdown-mode lua-mode yasnippet-snippets ## yasnippet solarized-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/lisp")
(load "odin-mode")
(load "c3-mode")
