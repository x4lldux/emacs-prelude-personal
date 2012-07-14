;; Smart begining of the line
(defun x4-smarter-beginning-of-line ()
  "Move point to first beginning-of-line or non-whitespace character or first non-whitespace after comment."
  (interactive "^")
  (if (= (point) (line-beginning-position))
      (let ((oldpos (point)))
	(back-to-indentation)
	(if (eq (point) oldpos)
	    (progn
	      (beginning-of-line)
	      (if (eq (point) oldpos)
		  (beginning-of-line-text)
		nil)
	      )
	  (nil))
	)
    (let ((oldpos (point)))
      (back-to-indentation)
      (if (eq (point) oldpos)
	  (progn
	    (beginning-of-line-text)
	    (if (eq (point) oldpos)
		(beginning-of-line)
	      nil)
	    )
	(beginning-of-line))
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

;; (defun x4-yank-primary-at-point ()
;;   "Yank from primary selection at point"
;;   (let (old-x-primary (x-select-enable-primary))
;;     (setq x-select-enable-primary t)
;;     (yank)
;;     (setq x-select-enable-primary 'old-x-primary)
;;     )
;;   )
