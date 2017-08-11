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
      '(;; generally useful packages
        company
        company-jedi
        rainbow-mode
	rainbow-delimiters
	smartparens
        showkey
        ;; git/github
	magit
	magithub
        ;; python related packages
        jedi
	pytest
        ;; themes
        noctilux-theme
        dracula-theme
	yasnippet))
		 
(mapc 'install-if-needed my-packages)

(showkey-log-mode t)

;; show the function you are in
(which-function-mode t)

;; company is the completion backend
(global-company-mode t)

;; nicer parenthesis handling
(smartparens-global-mode t)

;; show the parens
(show-paren-mode t)

;; show column number
(column-number-mode t)

;; show line number
(global-linum-mode t)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)

(yas-global-mode t)

;; python specific stuff
(require 'company-jedi)

;; various settings for Jedi
(setq
 jedi:complete-on-dot t
 jedi:setup-keys t
 py-electric-colon-active t
 py-smart-indentation t)

(venv-workon "emacs-demo")

(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'company-backends 'company-jedi)
            (hack-local-variables)
            (jedi:setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)
            (local-set-key (kbd "M-D") 'ca-python-remove-pdb)
            (local-set-key [f6] 'pytest-module)))


(load-library "magit")
;; (load-library "magithub")
;; (magithub-feature-autoinject t)
(global-set-key "\C-xg" 'magit-status)

(load-theme 'noctilux)

(provide 'init-new)

;;; init-new.el ends here
