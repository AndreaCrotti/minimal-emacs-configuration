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
        ;; python packages
        jedi

        ;; themes
        noctilux-theme
        dracula-theme))
		 
(mapc 'install-if-needed my-packages)

;; (showkey-tooltip-mode t)

(which-function-mode t)

(global-company-mode t)
(smartparens-global-mode t)
(show-paren-mode t)
(column-number-mode t)
(global-linum-mode t)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)

;; python specific stuff
(require 'company-jedi)

(setq
 jedi:complete-on-dot t
 jedi:setup-keys t
 py-electric-colon-active t
 py-smart-indentation t)

(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'company-backends 'company-jedi)
            (hack-local-variables)
            (jedi-setup-venv)
            (jedi:setup)
            (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            ;; (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)
            (local-set-key (kbd "M-D") 'ca-python-remove-pdb)
            (local-set-key [f6] 'pytest-module)
            ;; (local-set-key "\C-ca" 'pytest-all)
            ;; (local-set-key "\C-cm" 'pytest-module)
            ;; (local-set-key "\C-c." 'pytest-one)
            ;; (local-set-key "\C-cd" 'pytest-directory)
            ;; (local-set-key "\C-cpa" 'pytest-pdb-all)
            ;; (local-set-key "\C-cpm" 'pytest-pdb-module)
            ;; (local-set-key "\C-cp." 'pytest-pdb-one)
            ))

(load-theme 'noctilux)

(provide 'init-new)

;;; init-new.el ends here
