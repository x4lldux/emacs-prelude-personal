;; Smart begining of the line
(defun x4-smarter-beginning-of-line ()
  "Move point to first beginning-of-line or non-whitespace character or first non-whitespace after comment."
  (interactive "^")
  (let (
    (oldpos (point))
    (indentpos (progn
             (back-to-indentation)
             (point)
             )
           )
    (textpos (progn
           (beginning-of-line-text)
           (point)
           )
         )
    )
    (cond
     ((> oldpos textpos) (beginning-of-line-text))
     ((and (<= oldpos textpos) (> oldpos indentpos))  (back-to-indentation))
     ((and (<= oldpos indentpos) (> oldpos (line-beginning-position))) (beginning-of-line))
     (t (beginning-of-line-text))
     )
    )
  )

;; clear function for eshell
(defun eshell/clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))


;; Better window swapping - ignores ECB
(require 'cl)
(defun non-ecb-window-list ()
  (if (boundp 'ecb-dedicated-special-buffers)
      (remove-if
       #'(lambda (window)
       (find (window-buffer window) (ecb-dedicated-special-buffers)))
       (window-list))
    (window-list)))

;; Needed for new prelude-swap-windows fun
(defmacro count-non-ecb-windows ()
  (length (non-ecb-window-list)))

;; redefine prelude's swap windows function to work with ECB
(defun prelude-swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-non-ecb-windows) 2))
     (message "You need exactly 2 windows to do this."))
    (t
     (let* ((w1 (first (non-ecb-window-list)))
        (w2 (second (non-ecb-window-list)))
        (b1 (window-buffer w1))
        (b2 (window-buffer w2))
        (s1 (window-start w1))
        (s2 (window-start w2)))
       (set-window-buffer w1 b2)
       (set-window-buffer w2 b1)
       (set-window-start w1 s2)
       (set-window-start w2 s1)))))

(defun prelude-swap-windows ()
  ;;(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((num-windows (count-windows))
      (i (count-windows)))
      (while  (> i 0)
    (let* ((w1 (elt (window-list) i))
           (w2 (elt (window-list) (- (% i num-windows) 1)))
           (b1 (window-buffer w1))
           (b2 (window-buffer w2))
           (s1 (window-start w1))
           (s2 (window-start w2)))
      (set-window-buffer w1 b2)
      (set-window-buffer w2 b1)
      (set-window-start w1 s2)
      (set-window-start w2 s1)
      (setq i (1- i))))))))

(defun prelude-swap-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 1)
      (num-windows (count-windows)))
      (while  (< i num-windows)
    (let* ((w1 (elt (window-list) i))
           (w2 (elt (window-list) (+ (% i num-windows) 1)))
           (b1 (window-buffer w1))
           (b2 (window-buffer w2))
           (s1 (window-start w1))
           (s2 (window-start w2)))
      (set-window-buffer w1 b2)
      (set-window-buffer w2 b1)
      (set-window-start w1 s2)
      (set-window-start w2 s1)
      (setq i (1+ i))))))))

(defun x4-yank-primary-at-point ()
  "Yank from primary selection at point"
  (interactive "^")
  (let ((primary
     (cond
      ((eq system-type 'windows-nt)
       ;; MS-Windows emulates PRIMARY in x-get-selection, but not
       ;; in x-get-selection-value (the latter only accesses the
       ;; clipboard).  So try PRIMARY first, in case they selected
       ;; something with the mouse in the current Emacs session.
       (or (x-get-selection 'PRIMARY)
           (x-get-selection-value)))
      ((fboundp 'x-get-selection-value) ; MS-DOS and X.
       ;; On X, x-get-selection-value supports more formats and
       ;; encodings, so use it in preference to x-get-selection.
       (or (x-get-selection-value)
           (x-get-selection 'PRIMARY)))
      ;; FIXME: What about xterm-mouse-mode etc.?
      (t
       (x-get-selection 'PRIMARY)))))
    (unless primary
      (error "No selection is available"))
    (push-mark (point))
    (insert primary)))
