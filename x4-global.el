(mapc (lambda (pkg)
	(add-to-list 'load-path (concat "~/.emacs.d/personal/vendor/" pkg)))
      '("workgroups.el/" "eproject" "emacs-flymake-perlcritic" "nyan-mode" "emacs-skype" "emacs-minimap"))

(menu-bar-mode t)
(setq default-frame-alist '((font . "Inconsolata-10")))
(set-default-font "Inconsolata-10")
(add-to-list 'package-archives
	     '("SunriseCommander" . "http://joseito.republika.pl/sunrise-commander/"))

;; Dired+ - use it instead of regular dired
(require 'dired+)

;; Sunrise Commander
(require 'sunrise-commander)
(require 'sunrise-x-popviewer)
(require 'sunrise-x-loop)
(require 'sunrise-x-mirror)

;; ;; Eproject
;; (require 'eproject)
;; (require 'eproject-extras)
;; (define-key eproject-mode-map (kbd "C-c C-c p f") #'eproject-find-file)
;; (define-key eproject-mode-map (kbd "C-c C-c p b") #'eproject-ibuffer)
;; (define-key eproject-mode-map (kbd "C-c C-c p c") #'eproject-compile)
;; (define-key eproject-mode-map (kbd "C-c C-c p v") #'eproject-revisit-project)
;; (define-key eproject-mode-map (kbd "C-c C-c p o") #'eproject-open-all-project-files)
;; (define-key dot-eproject-mode-map (kbd "C-c C-c p r") #'eproject-reinitialize-project)

;; Workgroups configs
(require 'workgroups)
(setq wg-prefix-key (kbd "C-z"))
(setq wg-morph-on nil)
(workgroups-mode t)

;(require 'skype)
;(setq skype--my-user-handle "x4lldux")

(require 'w3m-load)
(require 'minimap)

;; Load ElScreen
;;(load "elscreen" "ElScreen" t)
;;(require 'elscreen-w3m)
;;(require 'elscreen-gf)
;;(require 'elscreen-color-theme)


(setq stack-trace-on-error t)
;;(ecb-activate)

;; Nyan cat mode
(require 'nyan-mode)
(nyan-mode t)
;;(nyan-start-animation)

;; buffer-move
(require 'buffer-move)

;; If flymake_perlcritic isn't in your path.
(setq flymake-perlcritic-command "~/.emacs.d/personal/emacs-flymake-perlcritic/bin/flymake_perlcritic")
;; Lets set it to be the most severe available.
(setq flymake-perlcritic-severity 1)
(require 'flymake-perlcritic)

(custom-set-variables
 '(cperl-highlight-variables-indiscriminately t)
 '(display-time-mode t)
 '(indent-tabs-mode t)
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(tab-always-indent (quote complete))
 )

(require 'rainbow-delimiters)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t (:foreground "green"))))
 ;; '(highlight ((t (:background "grey25"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "CadetBlue3"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "LemonChiffon"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "RosyBrown"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "PaleGreen2"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "DarkGoldenrod2"))))
 '(show-paren-match ((t (:underline "#73d216"))))
 '(show-paren-mismatch ((t (:underline "#ff1f18")))))


					;;(require `notify)

;; Fill column indicator
(setq fill-column 80)
(setq default-fill-column 80)
(require 'fill-column-indicator)
;; (setq fci-rule-color (face-foreground 'default))
(fci-mode 1)

;; General text-mode personallizations
(defun x4--after-text-mode ()
  "Execute after text-mode hook"
  (setq scroll-error-top-bottom 1)
  (prelude-turn-off-whitespace) ;; FIXIT: whitespace-mode works on
  (global-whitespace-mode -1)
  (linum-mode 1)
  )
(add-hook 'text-mode-hook 'x4--after-text-mode)

;; General programming personallizations
(defun x4--after-prog-mode ()
  "Execute after programming-mode hook"
  (prelude-turn-off-whitespace)
  ;; (flyspell-mode 1)
  ;; (flyspell-prog-mode 1)
  (rainbow-delimiters-mode 1)
  (flymake-mode 1)
  (linum-mode 1)
  ;;  (ruby-block-mode -1)
  )
(add-hook 'prelude-prog-mode-hook 'x4--after-prog-mode t)
;(add-hook 'prelude-prog-mode-hook 'flyspell-mode)
;(add-hook 'prelude-prog-mode-hook 'flyspell-prog-mode)

(remove-hook 'message-mode-hook 'prelude-turn-on-flyspell)
(remove-hook 'text-mode-hook 'prelude-turn-on-flyspell)

;; WTF?! why is this needed for linum to work in CPerl?
(add-hook 'cperl-mode-hook
  (lambda() (linum-mode 1)))

(global-set-key [home] 'x4-smarter-beginning-of-line)
(global-set-key "\C-a" 'x4-smarter-beginning-of-line)
					;;(global-set-key [(shift insert)] 'x4-yank-primary-at-point)


(autoload 'template-mode "template-mode")
(setq auto-mode-alist
(append '(("\\.tt$" . template-mode)) auto-mode-alist ))
