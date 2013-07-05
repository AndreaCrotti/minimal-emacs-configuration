;; make more packages available with the package installer
(setq to-install
      '("python-mode" "magit" "yasnippet"))

(when (locate-library "package")
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (dolist ((x to-install))
    (package-install x)))


;; Python mode settings
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)

;; Flymake settings for Python
(require 'flymake)
(defun flymake-python-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "epylint" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-python-init))

(add-hook 'python-mode-hook 'activate-flymake)

(require 'magit)
(global-set-key "\C-xg" 'magit-status)

;; yasnippet configuration
(require 'yasnippet)
