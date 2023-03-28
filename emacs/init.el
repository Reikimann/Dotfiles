;; -*- lexical-binding: t -*-
;; Please edit the Emacs.org file instead of this. Init.el is auto-generated.
(defvar reiki/default-font-size 130)
(defvar reiki/default-fixed-font "Liga SFMono Nerd Font")
(defvar reiki/default-variable-font "Iosevka Aile")

(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name)

(scroll-bar-mode -1)        ;Disable visible scrollbar
(tool-bar-mode -1)          ;Disable the toolbar
(menu-bar-mode -1)          ;Disable the menu bar
(tooltip-mode -1)           ;Disable tooltips
(set-fringe-mode 10)        ;Give some breathing room

(setq use-dialog-box nil)   ;Dont popup dialog-boxes when prompting

(setq visible-bell t)       ;Enables visual bell (turn off to hear sound. Unless we ignore it)
(setq ring-bell-function 'ignore) ;;BUT ignore it, to see and hear nothing

(save-place-mode 1)         ;Remember and restore cursor location

;; Line numbers (relative)
(column-number-mode)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
;; Explicitly define a width to reduce the cost of on-the-fly computation
(setq-default display-line-numbers-width 2) ; Change to 3 to view four digits

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                pdf-view-mode-hook
                doc-view-minor-mode
                tetris-mode-hook
                markdown-mode-hook
                dired-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Sets transparency (v29+)
(set-frame-parameter (selected-frame) 'alpha-background 95)
;; (add-to-list 'default-frame-alist 'alpha-background 95) ;; This screws up startup (besides, dont know what it does xD)

(set-face-attribute 'default nil
                    :font reiki/default-fixed-font
                    :height 130)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil
                    :font reiki/default-fixed-font
                    :height 130)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
                    :font reiki/default-variable-font
                    :height 130
                    :weight 'light)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Save what you enter into minibuffer
(setq history-length 25)
(savehist-mode 1)

;; Blank scratch buffer (almost)
(setq initial-scratch-message ";; Scratch buffer: YEET!")

;; Remember recently edited files
(recentf-mode 1)

;; Tabs!
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil) ;Use spaces instead of tabs

;; Sentences end with one space
(setq sentence-end-double-space nil)

;; Contrary to what many Emacs users have in their configs, you don't need more
;; than this to make UTF-8 the default coding system:
(set-language-environment "UTF-8")
;; ...but 'set-language-environment' also sets 'default-input-method', which is
;; a step too opinionated.
(setq default-input-method nil)

;; When emacs asks for "yes" or "no", let "y" or "n" suffice
(setq use-short-answers t)

(setq blink-cursor-interval 0.6)
(blink-cursor-mode 10) ; Stops blinking after X, if 0 disable blinking
(setq-default cursor-in-non-selected-windows t) ; Hides cursor when nil if window loses focus

;; Smooth scrolling (kinda)
(setq scroll-margin 10)
(setq scroll-step 1)
(setq scroll-conservatively 101)

;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate syntax highlighting right after scrolling, which should
;; quickly self-correct. 
(setq fast-but-imprecise-scrolling t)

;; Don't resize the frames in steps; it looks weird, especially in tiling window
;; managers, where it can leave unseemly gaps.
(setq frame-resize-pixelwise t)

;; But do not resize windows pixelwise, this can cause crashes in some cases
;; when resizing too many windows at once or rapidly.
(setq window-resize-pixelwise nil)

(setq native-comp-async-report-warnings-errors nil)

(defun reiki/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'reiki/display-startup-time)

;; Shave seconds off startup time by starting the scratch buffer in
;; `fundamental-mode', rather than, say, `org-mode' or `text-mode', which pull
;; in a ton of packages.
(setq initial-major-mode 'fundamental-mode)

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

(setq use-package-verbose t)

;; Emacs29+
(setq package-native-compile t)

(use-package auto-package-update
  :defer t
  :custom
  (auto-package-update-interval 14)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "16:00"))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general)

(general-create-definer reiki/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")

(reiki/leader-keys
  "SPC" '(execute-extended-command :which-key "M-x")
  ;; Nav
  "." '(find-file :which-key "find file")
  "," '(consult-recent-file :which-key "recent files")
  ;; Buffers
  "q" '(kill-current-buffer :which-key "kill buff")
  "Q" '(save-buffers-kill-terminal :which-key "Quit emacs")
  "e" #'((lambda () (interactive) (find-file (locate-user-emacs-file "Emacs.org"))) :which-key "Emacs config")
  "j" #'((lambda () (interactive) (switch-to-buffer (other-buffer))) :which-key "Prev buff")
  )

(reiki/leader-keys
  ;; "Applications"
  "a" '(:ignore a :which-key "Apps")
  "ad" '(dired-jump :which-key "Dired")
  ;; Hydra
  "s" '(:ignore s :which-key "Hydras")
  "ss" '(hydra-text-scale/body :which-key "Scale text")
  "st" '(hydra-theme-switcher/body :which-key "Choose theme")
  "sl" '(hydra-links/body :which-key "Links")
  ;; Buffers
  "b" '(:ignore b :which-key "Buffer")
  "bb" '(consult-buffer :which-key "Switch buffer")
  "br" '(revert-buffer :which-key "Revert buffer")
  "bs" '(save-buffer :which-key "Save buffer")
  "bk" '(kill-buffer :which-key "Kill buffer")
  ;; Org
  "o" '(:ignore o :which-key "Org")
  "oc" '(org-capture :which-key "Capture")
  "oh" '(consult-org-heading :which-key "Headings")
  "oa" '(org-agenda :which-key "Org agenda")
  "oe" '(org-export-dispatch :which-key "Org export")
  "op" '(org-present :which-key "Org present")
  ;; Help
  "h" '(:ignore h :which-key "Help/Emacs")
  "hm" '(evil-lookup :which-key "Manuals")
  "hv" '(describe-variable :which-key "Des. variable")
;; TODO: Find alternative to counsel
  "hb" '(counsel-descbinds :which-key "Des. bindings") ; Depends on counsel
  "hf" '(describe-function :which-key "Des. func")
  "hF" '(describe-face :which-key "Des. face")
  "hg" '(customize-group :which-key "Customize group")
  "hM" '(describe-mode :which-key "Des. mode")
  "hs" '(describe-symbol :which-key "Des. symbol")
  "hk" '(describe-key :which-key "Des. key")
  ;; Modes
  "m" '(:ignore m :which-key "Modes")
  "me" '(emacs-lisp-mode :which-key "Elisp mode")
  "mi" '(lisp-interaction-mode :which-key "Lisp interaction mode")
  "mo" '(org-mode :which-key "Org mode")
  "mt" '(text-mode :which-key "Text mode")
  ;; Help/emacs packages
  "hp" '(:ignore p :which-key "Packages")
  "hpr" '(package-refresh-contents :which-key "Refresh packages")
  "hpi" '(package-install :which-key "Install package")
  "hpd" '(package-delete :which-key "Delete package")
  "hpl" '(list-packages :which-key "List packages")
  "hpu" '(auto-package-update-now-async :which-key "Package update")
  ;; Toggles
  "t" '(:ignore t :which-key "Toggles")
  "tv" '(visual-line-mode :which-key "Visual line mode")
  "tm" '(minimap-mode :which-key "Minimap mode")
  "tn" '(display-line-numbers-mode :which-key "Display line numbers")
  "ta" '(variable-pitch-mode :which-key "Variable pitch mode")
  "tc" '(evilnc-comment-or-uncomment-lines :which-key "Comment line")
  "tf" '(visual-fill-column-mode :which-key "Visual fill column mode")
  "tR" '(read-only-mode :which-key "Read only mode")
  "tr" '(display-fill-column-indicator-mode :which-key "Fill column indicator")
  ;; Windows
  "w" '(:ignore w :which-key "Window")
  "wN" '(make-frame :which-key "New frame")
  "w|" '(split-window-right :which-key "Split right")
  "w-" '(split-window-below :which-key "Split below")
  "wd" '(evil-window-delete :which-key "delete window")
  "wl" '(evil-window-right :which-key "Move right")
  "wh" '(evil-window-left :which-key "Move left")
  "wj" '(evil-window-down :which-key "Move down")
  "wk" '(evil-window-up :which-key "Move up")
  )

;; Vim like modal editting
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;;(define-key evil-motion-state-map "/" 'swiper) ; Replace normal search with swiper

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)


  ;; Setting cursor colors
  (setq evil-emacs-state-cursor    '("#ebcb8b" box))
  (setq evil-normal-state-cursor   '("#649bce" box))
  (setq evil-visual-state-cursor   '("#677691" box))
  (setq evil-operator-state-cursor '("#ebcb8b" hollow))
  (setq evil-insert-state-cursor '("#eb998b" (bar . 2)))
  (setq evil-replace-state-cursor  '("#eb998b" hbar))
  (setq evil-motion-state-cursor   '("#ad8beb" box))

  ;; Initial modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'motion)
  (evil-set-initial-state 'pdf-view-mode 'motion))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "Scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished"))

(defhydra hydra-links (:timeout 4)
  "
  Links
  ----------------------------------------------
  _re_ r/Emacs         _g_ Github 
  _aw_ Emacswiki       _aw_ Archwiki
  _y_ Youtube          _n_ Netflix
  _q_ Quit                 ^
  ^                        ^
  "
  ("re" (browse-url "https://www.reddit.com/r/emacs/") "r/Emacs")
  ("ew" (browse-url "https://www.emacswiki.org/") "Emacswiki")
  ("aw" (browse-url "https://wiki.archlinux.org/") "Archwiki")
  ("y" (browse-url "https://www.youtube.com/") "Youtube")
  ("n" (browse-url "https://www.netflix.com/") "Netflix")
  ("g" (browse-url "https://github.com/Reikimann") "Github")
  ("q" nil "cancel"))

(defhydra hydra-theme-switcher (:hint nil)
  "
     Dark                Light
----------------------------------------------
_1_ Tokyo-Night      _z_ One-light 
_2_ Palenight        _x_ Operandi
_3_ Molokai          _c_ Tango
_4_ Gruvbox          _v_ Whiteboard
_5_ Dracula          _b_ Opera-light 
_6_ Henna            _n_ Tomorrow-day 
_q_ Quit             Current: %`custom-enabled-themes
^                        ^
"
  ;; Dark
  ("1" (reiki/load-theme 'doom-tokyo-night) "Tokyo-night")
  ("2" (reiki/load-theme 'doom-palenight) "Palenight")
  ("3" (reiki/load-theme 'doom-molokai) "Molokai")
  ("4" (reiki/load-theme 'doom-gruvbox) "Gruvbox")
  ("5" (reiki/load-theme 'doom-dracula) "Dracula")
  ("6" (reiki/load-theme 'doom-henna) "Henna")

  ;; Light
  ("z" (reiki/load-theme 'doom-one-light) "One-light")
  ("x" (reiki/load-theme 'modus-operandi) "Modus-operandi")
  ("c" (reiki/load-theme 'doom-tango) "Tango")
  ("v" (reiki/load-theme 'whiteboard) "Whiteboard")
  ("b" (reiki/load-theme 'doom-opera-light) "Opera-light")
  ("n" (reiki/load-theme 'doom-tomorrow-day) "Tomorrow-day")
  ("q" nil))

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init
  (load-theme 'doom-tokyo-night t)
  (doom-themes-visual-bell-config))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 18))
  :config
  (setq doom-modeline-buffer-encoding nil 
        doom-modeline-buffer-file-name-style 'file-name ;; Just show file name (no path)
        doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
        doom-modeline-enable-word-count t
        doom-modeline-minor-modes t
        minions-mode 1
        doom-modeline-indent-info t ;; Whether display the indentation information.
        doom-modeline-major-mode-icon t
        ;doom-modeline-buffer-file-name-style 'truncate-except-project
        ))

(use-package minions
  :after doom-modeline)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-prefix-prefix "◉")
  (setq which-key-idle-delay 0.2))

(use-package corfu
  :bind
  (:map corfu-map ("RET" . nil)) ;; Return key is for newline not completions 
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-delay 0.2)         ;; Seconds to wait before showing auto completion
  (corfu-on-exact-match nil)
  (corfu-auto-prefix 0)          ;; Minimum length before showing auto completion
  (corfu-count 10)               ;; Number of candidates to show
  (corfu-scroll-margin 5)        ;; Use scroll margin
  (corfu-popupinfo-hide nil)     ;; Hides docs between candidates
  (corfu-popupinfo-delay '0.1)     ;; Hides docs between candidates
  (corfu-popupinfo-max-width '40)
  (corfu-popupinfo-max-hight '10)
  (corfu-echo-mode nil)
  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :config
  (define-key corfu-map (kbd "M-p") #'corfu-popupinfo-scroll-down)
  (define-key corfu-map (kbd "M-n") #'corfu-popupinfo-scroll-up)
  (define-key corfu-map (kbd "M-d") #'corfu-popupinfo-toggle)
  :init
  (corfu-popupinfo-mode)
  (corfu-history-mode)
  (global-corfu-mode))

(use-package vertico
  :init
  (vertico-mode)

  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         :map minibuffer-local-map
         ("C-j" . next-line-or-history-element)
         ("C-k" . previous-line-or-history-element))

  :config
  (setq vertico-scroll-margin 4)
  (setq vertico-cycle t))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'right)
  ;; The :init configuration is always executed (Not lazy!)
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;; Example configuration for Consult
(use-package consult
  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)
)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))



(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

;; (use-package counsel
;;   :bind (
;;          ("M-x" . counsel-M-x)
;;          ("C-x C-f" . counsel-find-file)
;;          ("C-x b" . counsel-switch-buffer)
;;          )
;;          ;;("C-x b" . counsel-ibuffer)
;;          ;:map minibuffer-local-map
;;          ;("C-r" . 'counsel-minibuffer-history)
;;   :config 
;;   ;; Removes recentfiles/bookmarks from counsel-switch-buffer if set to nil
;;   (setq counsel-switch-buffer-preview-virtual-buffers t))

;; (use-package ivy
;;   :diminish
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :demand
;;   :config
;;   (setq ivy-extra-directories nil) ;; Hides . and .. directories
;;   (setq ivy-initial-inputs-alist nil) ;; Don't start searches with ^
;;   (setq ivy-on-del-error-function #'ignore) ; Inhibits deletion closing the minibuffer
;;   (setq ivy-wrap t) ;; Wrap around to top, when on last item
;;   (ivy-mode 1)

;;   ;; Shows a preview of the face in counsel-describe-face
;;   (add-to-list 'ivy-format-functions-alist '(counsel-describe-face . counsel--faces-format-function)))

;; ;; Nice icons in Ivy. Replaces all-the-icons-ivy.
;; (use-package all-the-icons-ivy-rich
;;   :after ivy
;;   :init (all-the-icons-ivy-rich-mode 1)
;;   :config
;;   (setq all-the-icons-ivy-rich-icon-size 1.0))

;; (use-package ivy-rich
;;   :after ivy
;;   :init
;;   (setq ivy-rich-path-style 'abbrev)
;;   :config
;;   (ivy-rich-mode 1))

;; (use-package ivy-prescient
;;   :disabled t
;;   :after counsel
;;   :config
;;   ;; don't prescient sort these commands
;;   (dolist (command '(counsel-find-file))
;;     (setq ivy-prescient-sort-commands (append ivy-prescient-sort-commands (list command))))
;;   ;(:not swiper swiper-isearch ivy-switch-buffer)
;;   (setq prescient-sort-length-enable nil) ; Disables sort by length
;;   (prescient-persist-mode 1)
;;   (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-function helpful-variable helpful-macro helpful-callable helpful-key helpful-command helpful-at-point helpful-symbol)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package minimap
  :commands minimap-mode
  :config
  (setq minimap-window-location 'right)
  (setq minimap-minimum-width '20)
  (setq minimap-width-fraction '0.075)
  ;(add-to-list 'minimap-major-modes 'org-mode)
  )

(defun reiki/org-mode-setup ()
  ;; (variable-pitch-mode 1)
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :commands (org-capture org-agenda)
  :hook (org-mode . reiki/org-mode-setup)
  :config
  (setq org-ellipsis " ⤵" ;  ⬎ ▼ ▾ ↷ ⤦ ⤸
        org-hide-emphasis-markers t) ;;hides markers like /italic/ or *bold*

  (setq org-return-follows-link t)
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-startup-folded 'show2levels) ;; Org files starts folded (first X levels)
  ;; (setq org-startup-folded 'content)

  (setq org-preview-latex-image-directory (concat user-emacs-directory "ltximg/"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-agenda-files
        '("~/dox/OrgFiles/Personal/Tasks.org"
          "~/dox/OrgFiles/Personal/Habits.org"
          "~/dox/OrgFiles/Personal/Birthdays.org"))

  ;; C-c C-t
  (setq org-todo-keywords
    '((sequence "TODO(t)" "DOING(d)" "NEXT(n)" "|" "DONE(D!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "FAILED" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;;C-c C-q 
  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("@school" . ?S)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("note" . ?n)
       ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/dox/OrgFiles/Personal/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/dox/OrgFiles/Personal/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/dox/OrgFiles/Personal/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/dox/OrgFiles/Personal/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ("m" "Metrics Capture")
      ("mw" "Water" table-line (file+headline "~/dox/OrgFiles/Personal/Metrics.org" "Water")
       "| %U | %^{Cups} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture)))

  (reiki/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))) ; "◉" "○" "◈" "◇" "✳"

(defun reiki/visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . reiki/visual-fill))

(defun reiki/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font reiki/default-fixed-font :weight 'medium :height (cdr face)))
  ;; (set-face-attribute (car face) nil :font reiki/default-variable-font :weight 'light :height (cdr face)))

;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
  )

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  ;; Appears only when in evil-insert-mode
  ;; (setq org-appear-trigger 'manual)
  ;; (add-hook 'org-mode-hook (lambda ()
  ;;                            (add-hook 'evil-insert-state-entry-hook
  ;;                                      #'org-appear-manual-start
  ;;                                      nil
  ;;                                      t)
  ;;                            (add-hook 'evil-insert-state-exit-hook
  ;;                                      #'org-appear-manual-stop
  ;;                                      nil
  ;;                                      t)))
  :custom
  (org-appear-autolinks 't))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t))))

(setq org-confirm-babel-evaluate nil)

;; Remember to figure out what this allows
;;(push '("conf-unix" . conf-unix) org-src-lang-modes)

(with-eval-after-load 'org
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(setq org-latex-compiler "lualatex")

(use-package org-present
  :defer
  :config
  (add-hook 'org-present-mode-hook 'reiki/org-present-start)
  (add-hook 'org-present-mode-quit-hook 'reiki/org-present-end)
  (add-hook 'org-present-after-navigate-functions 'reiki/org-present-prepare-slide)
  )

;; Automatically tangle our Emacs.org config file when we save it
(defun reiki/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'reiki/org-babel-tangle-config)))

(defun reiki/lsp-mode-setup ()
  (setq lsp-headerlined-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . reiki/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-hover nil)
  :custom
  (setq lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config

  (general-define-key
    :keymaps 'lsp-mode-map
    :prefix lsp-keymap-prefix
    "d" '(dap-hydra t :wk "debugger")))

(use-package evil-nerd-commenter
  :defer 0
  ;:bind ("M-/" . evilnc-comment-or-uncomment-lines)
  )

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  ;; :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/coding")
    (setq projectile-project-search-path '("~/coding")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit
  :commands magit-status)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :defer 0
  ;; :hook (prog-mode . smartparens-mode)
  :init (smartparens-mode))

(use-package tex
  :mode ("\\.tex\\'" . latex-mode)
  ;; :defer t
  :ensure auctex
  :config
  (setq TeX-ignore-warnings t
        latex-run-command "latexmk" ;TODO: change to latexmk
        tex-directory (concat user-emacs-directory "tex-tmp")

        TeX-parse-self t ; parse on load
        TeX-auto-save t  ; parse on save

        ;; Use directories in a hidden away folder for AUCTeX files.
        Tex-auto-local (concat user-emacs-directory "auctex/auto/")
        Tex-style-local (concat user-emacs-directory "auctex/style/")

        Tex-source-correlate-mode t
        Tex-source-correlate-method 'synctex

        TeX-show-compilation nil

        ;; Don't start the Emacs server when correlating sources.
        TeX-source-correlate-start-server nil

        ;; Automatically insert braces after sub/superscript in `LaTeX-math-mode'.
        TeX-electric-sub-and-superscript t
        ;; Just save, don't ask before each compilation.
        TeX-save-query nil)

  ;; To use pdfview with auctex:
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
        TeX-source-correlate-start-server t)

  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  (add-hook 'TeX-after-compilation-finished-functions (lambda (filename) (shell-command "latexmk -silent -c")))

  :general
  (general-define-key
   :prefix ","
   :states 'normal
   :keymaps 'LaTeX-mode-map
   "" nil
   "a" '(TeX-command-run-all :which-key "TeX run all")
   "c" '(TeX-command-master :which-key "TeX-command-master")
   "e" '(LaTeX-environment :which-key "Insert environment")
   "s" '(LaTeX-section :which-key "Insert section")
   "m" '(TeX-insert-macro :which-key "Insert macro")
   )
  )

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :config
  (setq org-fragtog-preview-delay 0.3)
  )

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :ensure nil
  :config
  (add-hook 'markdown-mode-hook #'reiki/visual-fill)
  (add-hook 'markdown-mode-hook #'visual-line-mode)
  (dolist (face '((markdown-header-face-1 . 1.2)
                  (markdown-header-face-2 . 1.1)
                  (markdown-header-face-3 . 1.05)
                  (markdown-header-face-4 . 1.0)
                  (markdown-header-face-5 . 1.0)))
    (set-face-attribute (car face) nil :weight 'normal :height (cdr face)))
)

(use-package pdf-tools
  :init
  (pdf-loader-install)
  :config
  (setq-default pdf-view-display-size 'fit-height)
  (setq pdf-view-continous nil)
  (setq pdf-view-midnight-colors '("#ffffff" . "#121212" ))
  :general
  (general-define-key :states 'motion :keymaps 'pdf-view-mode-map
                      "j" 'pdf-view-next-page
                      "k" 'pdf-view-previous-page

                      "C-j" 'pdf-view-next-line-or-next-page
                      "C-k" 'pdf-view-previous-line-or-previous-page

                      "H" 'pdf-view-fit-height-to-window
                      "0" 'pdf-view-fit-height-to-window
                      "W" 'pdf-view-fit-width-to-window
                      "K" 'pdf-view-enlarge
                      "J" 'pdf-view-shrink

                      "q" 'kill-this-buffer
                      "g" 'revert-buffer

                      ;; Arrows for movement as well
                      (kbd "<down>") 'pdf-view-next-line-or-next-page
                      (kbd "<up>") 'pdf-view-previous-line-or-previous-page

                      (kbd "<down>") 'pdf-view-next-line-or-next-page
                      (kbd "<up>") 'pdf-view-previous-line-or-previous-page

                      (kbd "<left>") 'image-backward-hscroll
                      (kbd "<right>") 'image-forward-hscroll
                      ))

;; Moves backups to specified directory
(setq backup-directory-alist `(("." . , (expand-file-name "tmp/backups/" user-emacs-directory))))

;; auto-save-mode doesn't create4 the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(setq create-lockfiles nil)

(use-package tetris
  :ensure nil
  :defer t
  :config
  (evil-collection-tetris-setup)
  )

(use-package elfeed
  :commands 'elfeed
  :config
  (setq elfeed-search-filter "@3-months-ago +unread")
  (setq elfeed-db-directory (concat user-emacs-directory "elfeed/"))
  (setq elfeed-enclosure-default-dir (concat user-emacs-directory "elfeed/"))
  (setq elfeed-feeds
        '("https://archlinux.org/feeds/news"
          "https://www.reddit.com/r/emacs/.rss")))

;(setenv "BASH_ENV" "~/.bashrc")
(defun reiki/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . reiki/configure-eshell)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

;; View all pages in DocView-mode
(setq doc-view-continuous t)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho -A --group-directories-first"))
  :config
  (setq dired-kill-when-opening-new-dired-buffer t)
  ;; TODO: Figure out how this works
  ;; (setq dired-guess-shell-alist-user '(
  ;;                                      ;; ("\\.pdf\\'" "zathura")
  ;;                                      ("\\.doc\\'" "libreoffice")
  ;;                                      ("\\.docx\\'" "libreoffice")
  ;;                                      ("\\.ppt\\'" "libreoffice")
  ;;                                      ("\\.pptx\\'" "libreoffice")
  ;;                                      ("\\.xls\\'" "libreoffice")
  ;;                                      ("\\.xlsx\\'" "libreoffice")
  ;;                                      ("\\.jpg\\'" "nsxiv")
  ;;                                      ("\\.png\\'" "nsxiv")))
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
  :config
  (setq all-the-icons-dired-monochrome nil))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(defun reiki/load-theme (theme)
  "Enhance `load-theme' by first disabling enabled themes."
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))


;;; Org-present-functions

(defun reiki/org-present-start ()
  "Sets options to enhance look for org-present."
  ;; Set a blank header line string to create blank space at the top
  (setq header-line-format " ")

  ;; Display inline images automatically
  (org-display-inline-images)

  (org-appear-mode -1)

  (evil-define-key '(normal) org-present-mode-keymap (kbd "w") 'evil-forward-word-begin)
  (evil-define-key '(normal) org-present-mode-keymap (kbd "j") 'evil-next-visual-line)
  (evil-define-key '(normal) org-present-mode-keymap (kbd "k") 'evil-previous-visual-line)
  (evil-define-key '(normal) org-present-mode-keymap (kbd "C-k") 'org-present-prev)
  (evil-define-key '(normal) org-present-mode-keymap (kbd "C-j") 'org-present-next)

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font reiki/default-variable-font :weight 'medium :height (cdr face)))

  ;; Tweak font sizes
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                     (header-line (:height 4.0) variable-pitch)
                                     (org-document-title (:height 1.75) org-document-title)
                                     (org-code (:height 1.55) org-code)
                                     (org-verbatim (:height 1.55) org-verbatim)
                                     (org-block (:height 1.25) org-block)
                                     (org-block-begin-line (:height 0.7) org-block))))

(defun reiki/org-present-end ()
  "Disables unneeded options set by reiki/org-present-start."
  ;; Clear the header line format by setting to `nil'
  (setq header-line-format nil)

  ;; Stop displaying inline images
  (org-remove-inline-images)

  (org-appear-mode)

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font reiki/default-fixed-font :weight 'medium :height (cdr face)))

  ;; Reset font customizations
  (setq-local face-remapping-alist '((default default default))))

(defun reiki/org-present-prepare-slide (buffer-name heading)
  "Enhances legibility and overview in org-present"
  ;; Show only top-level headlines
  (org-overview)

  ;; Unfold the current entry
  (org-show-entry)

  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))

  ;;; End of Org-present-functions

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
