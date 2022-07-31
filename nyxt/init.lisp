
(define-configuration browser
  ((session-restore-prompt :never-restore))
  ((external-editor-program '("emacsclient"))))

(define-configuration buffer
    ((default-modes (append '(vi-mode) %slot-default%))
     ))
