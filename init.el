
(defvar reiki/default-font-size 130)
(defvar reiki/default-fixed-font "Liga SFMono Nerd Font")

;; Basic Configuration ------------------------------------------------

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ;Disable visible scrollbar
(tool-bar-mode -1)          ;Disable the toolbar
(tooltip-mode -1)           ;Disable tooltips
(set-fringe-mode 10)        ;Give some breathing room

(menu-bar-mode -1)          ;Disable the menu bar

(setq use-dialog-box nil)   ;Dont popup dialog-boxes when prompting

;; Set up the visible bell
(setq visible-bell t)

(save-place-mode 1)         ;Remember and restore cursor location

;; Smooth scrolling (kinda)
(setq scroll-margin 10)
(setq scroll-step 1)

;; Line numbers (relative)
(column-number-mode)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Save what you enter into minibuffer
(setq history-length 25)
(savehist-mode 1)

;; Remember recently edited files
(recentf-mode 1)

;; Font Configuration ------------------------------------------------

(set-face-attribute 'default nil :font reiki/default-fixed-font :height reiki/default-font-size)

;; Set the fixed pitch face
;;(set-face-attribute 'fixed-pitch nil :font "Liga SFMono Nerd Font" :height 160)

;; Set the variable pitch face
;;(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 180 :weight 'regular)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Package Manager Configuration -----------------------------------------

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Cleanup Configuration -------------------------------------------------

;; Moves backups to specified directory
(setq backup-directory-alist `(("." . , (expand-file-name "tmp/backups/" user-emacs-directory))))

;; auto-save-mode doesn't create4 the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(setq create-lockfiles nil)

;; Basic UI Configuration ------------------------------------------------

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 16)))

(use-package doom-themes
  :init (load-theme 'doom-tokyo-night t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Ivy Configuration ------------------------------------------------

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :demand
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;; Keybind Configuration ------------------------------------------------

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2))

(use-package general
  :config
  (general-create-definer reiki/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (reiki/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")
   "s" 'save-buffer))

;; Vim like modal editting
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(reiki/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))


;; Projectile Configuration ------------------------------------------------

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/dox/coding")
    (setq projectile-project-search-path '("~/dox/coding")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))


;; Org Mode Configuration ------------------------------------------------

(defun reiki/org-mode-setup ()
  ;;(variable-pitch-mode 1)
  (org-indent-mode)
  (visual-line-mode 1))


(use-package org
  :hook (org-mode . reiki/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)) ;;hides markers like /italic/ or *bold*

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Set faces for heading levels
(dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.0)
                (org-level-6 . 1.0)
                (org-level-7 . 1.0)
                (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font reiki/default-fixed-font :weight 'regular :height (cdr face)))

;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
			'(("^ *\\([-]\\) "
			    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(defun reiki/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . reiki/org-mode-visual-fill))


;; Other Configuration ------------------------------------------------

;; View all pages in DocView-mode
(setq doc-view-continuous t)

;; Install latex-preview-pane if needed
(unless (package-installed-p 'latex-preview-pane)
  (package-install 'latex-preview-pane))

(use-package command-log-mode)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
