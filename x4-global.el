(setq x4--personal-vendor-path "~/.emacs.d/personal/vendor/")
(mapc (lambda (pkg)
        (add-to-list 'load-path (concat x4--personal-vendor-path pkg)))
      '("workgroups.el/" "eproject" "emacs-flymake-perlcritic" "nyan-mode"
        "emacs-skype" "emacs-minimap" "emacs-jabber" "myfixme" "golden-ratio.el/"))

(setq-default mode-line-format
              '("%e"
                (:eval
                 (if
                     (display-graphic-p)
                     #(" " 0 1
                       (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                   #("-" 0 1
                     (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))))
                mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification
                #("  " 0 2
                  (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                mode-line-position
                (which-func-mode
                 ("" which-func-format))
                (wg-mode-line-display-on
                 (:eval
                  (replace-regexp-in-string "no workgroups" "NWG" (wg-mode-line-string))))
                (vc-mode vc-mode)
                #(" " 0 1
                  (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                mode-line-modes
                (global-mode-string
                 ("" global-mode-string
                  #("  " 0 2
                    (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))))
                (:eval
                 (unless
                     (display-graphic-p)
                   #("-%-" 0 3
                     (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))))))

(load-theme 'sanityinc-tomorrow-night t)
(menu-bar-mode t)
(setq set-mark-command-repeat-pop 't)
(setq default-frame-alist '((font . "Inconsolata-9")))
(set-default-font "Inconsolata-9")
(add-to-list 'package-archives
             '("SunriseCommander" . "http://joseito.republika.pl/sunrise-commander/") t)
(add-to-list 'package-archives
             '("marmalade"        . "http://marmalade-repo.org/packages/") t
             )


;; moves point to the farthest possible position. If point is already there, the command signals an error.
(setq scroll-error-top-bottom 't)

;; Dired+ - use it instead of regular dired
(require 'dired+)
(toggle-diredp-find-file-reuse-dir 1)

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

;;(require 'skype)
;;(setq skype--my-user-handle "x4lldux")

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
 '(indent-tabs-mode nil)
 '(tab-width 4)
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
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
 '(show-paren-match ((t (:inverse-video nil :underline "#73d216"))))
 '(show-paren-mismatch ((t (:underline "#ff1f18")))))


;;(require `notify)

;; Fill column indicator
(setq fill-column 80)
(setq default-fill-column 80)
(require 'fill-column-indicator)
;; (setq fci-rule-color (face-foreground 'default))
(fci-mode 1)

(defun x4--after-text-mode ()
  "Execute after text-mode hook"
  (setq scroll-error-top-bottom 1)
  (whitespace-mode -1)
  (global-whitespace-mode -1)
  (linum-mode 1)
  (fci-mode 1)

  )
(add-hook 'prelude-text-mode-hook 'x4--after-text-mode t)

(require 'myfixme)

;; General programming personallizations
(defun x4--after-prog-mode ()
  "Execute after programming-mode hook"

  (message "x4--after-prog-mode")
  (whitespace-mode -1)
  (flyspell-mode -1)
  ;; (flyspell-prog-mode -1)
  (rainbow-delimiters-mode 1)
  (linum-mode 1)
  (fci-mode 1)
  (myfixme-mode 1)
  ;; (flymake-mode 1)
  )
(add-hook 'prelude-prog-mode-hook 'x4--after-prog-mode t)

;; WTF?! why is this needed for linum to work in CPerl?
;; cperl-mode probobly dosn't derivie from prog-mode
(add-hook 'cperl-mode-hook (lambda ()
                             (prelude-prog-mode-defaults)
                             (x4--after-prog-mode)
                             (run-hooks 'prelude-prog-mode-hook)
                             ))


(remove-hook 'message-mode-hook 'flyspell-mode)
(remove-hook 'text-mode-hook 'flyspell-mode)

(global-set-key [home] 'x4-smarter-beginning-of-line)
(global-set-key "\C-a" 'x4-smarter-beginning-of-line)
(global-set-key [(shift insert)] 'x4-yank-primary-at-point)


(autoload 'template-mode "template-mode")
(setq auto-mode-alist
(append '(("\\.tt$" . template-mode)) auto-mode-alist ))
(require 'smex)
(smex-initialize)
(global-set-key (kbd "<menu>") 'smex)
(global-set-key (kbd "M-x") 'smex)

;; Workgroups configs
(require 'workgroups)
(setq wg-default-session-file "~/.emacs.d/savefile/default-workgroups-session")
(setq wg-prefix-key (kbd "C-z"))
(setq wg-morph-on nil)
(workgroups-mode t)


;; Scroll by a single line
(global-set-key (kbd "S-M-<down>")  '(lambda () (interactive)
                                       (let ((pos (point)))
                                         (scroll-down-line)
                                         (set-window-point (selected-window) pos)
                                         )))
(global-set-key (kbd "S-M-<up>")  '(lambda () (interactive)
                                     (let ((pos (point)))
                                       (scroll-up-line)
                                       (set-window-point (selected-window) pos)
                                       )))

(delete-selection-mode 1)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
