;;; init-new.el --- Sample Emacs configuration for Python and github

;;; Commentary:
;;

(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))


(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

(setq my-packages
      '(rainbow-mode
	rainbow-delimiters
	smartparens
	magit
	magithub))
		 
(mapc 'install-if-needed my-packages)

(provide 'init-new)

;;; init-new.el ends here
