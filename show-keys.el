;;; show-keys.el --- Minor mode which displays the keys you've typed

;; Copyright (C) 2012 Craig Andera

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use,
;; copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following
;; conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;; OTHER DEALINGS IN THE SOFTWARE.

;; Author: Craig Andera <candera@wangdera.com>

;; Commentary: Invoke this minor mode to continuously update the
;; *shown-keys* buffer with the keys you've typed. Ignores keys bound
;; to certain commands, like self-insert-command, since that would get
;; pretty noisy.
;;
;; Installation:
;; (add-to-path 'load-path "/path/to/show-keys.el")
;; (require 'show-keys)

;; TODO: Add support for customization

(defvar show-keys-limit 100) ; Currently unused. Intent is to trim
                             ; displayed older keys after this many
                             ; commands
(defvar show-keys-buffer nil)
(defvar show-keys-ignored-commands '(self-insert-command
                                     delete-backward-char
                                     paredit-backward-delete))

(define-minor-mode show-keys-mode
    "Displays the keys you've typed recently in the *shown-keys* buffer."
  :lighter " (sk)"
  :global t
  :group 'show-keys
  (if show-keys-mode
      (progn
        (add-hook 'pre-command-hook 'show-keys-command-hook)
        (setq show-keys-buffer (get-buffer-create "*shown-keys*"))
        (let ((orig-window (selected-window)))
          (view-buffer-other-window show-keys-buffer)
          (select-window orig-window)))
    (remove-hook 'pre-command-hook 'show-keys-command-hook)))

(defun show-keys-command-hook ()
  "When show-keys-mode is enabled, fires after every command.
Updates the *shown-keys* buffer with the keys that were typed."
  (unless (member this-command show-keys-ignored-commands)
    (let ((deactivate-mark nil))
      (with-current-buffer show-keys-buffer
        (let ((buffer-read-only nil)
              (orig-window (selected-window))
              (show-buffer-window (get-buffer-window show-keys-buffer t)))
          (when show-buffer-window
            (select-window show-buffer-window t))
          (goto-char (point-max))
          (insert (format "%s (%s)\n"
                          (key-description (this-command-keys-vector))
                          this-command))
          (when show-buffer-window
            (select-window orig-window t)))))))

(provide 'show-keys)
