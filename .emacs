;; 
;; emacs setting file by Meiosis
;;

;; 关闭报警声
(setq visible-bell t)

;; 加入系统path变量
(setenv "PATH" (concat 
                  "/usr/local/bin" 
                  ":" 
                  (getenv "PATH"))) 

;; 启动后显示空buffer
(add-hook 'after-init-hook
		  '(lambda ()
			 (switch-to-buffer
			  (get-buffer-create "blank buffer*"))))

;; 不自动保存正在编辑的文档
(setq auto-save-default nil)

;; 设置tab缩进
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; mode-line 显示时间
(display-time)

;; 设置括号匹配按键
(global-set-key "%" 'match-paren)

;; 光标到括号上才用%匹配
(defun match-paren (arg)
"Go to the matching paren if on a paren; otherwise insert %."
(interactive "p")
(cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
((looking-at "\\s\)") (forward-char 1) (backward-list 1))
(t (self-insert-command (or arg 1)))))

;; mew收发邮件设置
(add-to-list 'load-path "~/.emacs.d/site-lisp/Mew")
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; tab的风格,用了ruby的C源代码的编写风格
(c-add-style
 "ruby-source"
 '("bsd"
    (c-basic-offset . 4)
    (tab-width . 4)
    (c-offsets-alist
     (case-label . 0)
     (label . 0)
     (statement-case-intro . 4))))
 (setq c-default-style
             '((c-mode . "ruby-source")))

;; 像VI那样C-o 在下面起一行并缩进
(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent)
)
(setq column-number-mode t) 
(define-key global-map "\C-o" 'vi-open-line-below)

;; 滚动条设置
(setq scroll-margin 3
      scroll-conservatively 10000)

;; 默认主模式为文本模式
(setq default-major-mode 'text-mode)

;; 高亮匹配括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
(mouse-avoidance-mode 'animate)

;; 进行语法加亮
(global-font-lock-mode t)

;; 不要在鼠标点击的那个地方插入剪贴板内容
(setq mouse-yank-at-point t)

;; 禁止启动信息
(setq inhibit-startup-message t)

(add-to-list 'load-path "~/.emacs.d")

(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(set-face-attribute 'default nil :height 140)

(global-set-key "%" 'match-paren)
(defun match-paren (arg) 
  "Go to the matching paren if on a paren; otherwise insert %." 
  (interactive "p") 
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1)) 
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1)) 
    (t (self-insert-command (or arg 1))))) 

;; ido智能提示插件
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;; textmate风格的查找
(add-to-list 'load-path "~/.emacs.d/site-lisp/textmate")
(require 'textmate)
(textmate-mode)

;; org-mode　配置
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/todo.org"
							 "~/org/finance.org"
							 "~/org/remind.org"
							 "~/org/english.org"))

;; git-emacs git插件
(add-to-list 'load-path "~/lib/emacs/git-emacs")
(require 'git-emacs)

;; python　设置
(defun python-reinstate-current-directory ()
  ;;(python-send-string "import sys")
  (python-send-string "sys.path[0:0] = ['']"))
(add-hook 'inferior-python-mode-hook 'python-reinstate-current-directory)

;; pyemacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(global-set-key [(ctrl f12)] 'eval-buffer)

;; anything
(add-to-list 'load-path "~/.emacs.d/site-lisp/anything")
(require 'anything-config)
(global-set-key (kbd "M-O") 'anything)

;;erc irc聊天室设置
(setq erc-default-coding-system '(utf-8 . utf-8))
(setq erc-nick "meiosis"
      erc-user-full-name "Meiosis Chen")

;;erc 自动保存log
(require 'erc-log)
(erc-log-mode 1)
(setq erc-log-channels-directory "~/log/erc/"
      erc-save-buffer-on-part t
      erc-log-file-coding-system 'utf-8
      erc-log-write-after-send t
      erc-log-write-after-insert t)
(unless (file-exists-p erc-log-channels-directory)
  (mkdir erc-log-channels-directory t))


;; weibo 新浪微薄设置
(add-to-list 'load-path "~/.emacs.d/site-lisp/weibo.emacs")
(require 'weibo)

;; org2blog org-mode中直接发送wordpress
(add-to-list 'load-path "~/.emacs.d/site-lisp/xml-rpc")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org2blog")
(require 'xml-rpc)
(require 'org2blog-autoloads)
(setq org2blog/wp-blog-alist
           '(("wordpress"
              :url "http://zhengjiushijie.com/xmlrpc.php"
              :username "zhengjiushijie"
              :confirm t
              :tags-as-categories nil)))

;; ecb 设置
(add-to-list 'load-path "~/.emacs.d/site-lisp/ecb")
(setq stack-trace-on-error t)
(setq semantic-load-turn-useful-things-on t)
(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 0.25)
(defun ecb-toggle ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (ecb-activate)))
(global-set-key [f2] 'ecb-toggle)

;; ruby-mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby-mode")
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;; inf-ruby
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; rinari
(add-to-list 'load-path "~/.emacs.d/site-lisp/jump")
(add-to-list 'load-path "~/.emacs.d/site-lisp/rinari")
(require 'rinari)

;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))

;; rails
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-rails")
(require 'rails)

;; yasnippet
(add-to-list 'load-path
			 "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)

(setq yas/root-directory "~/.emacs.d/site-lisp/yasnippet/snippets")
(yas/load-directory yas/root-directory)
(yas/load-directory "~/.emacs.d/mysnippets")
(yas/global-mode 1)

;; 解决yasnippet与org-mode的冲突
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

;; 解决yasnippet与ruby-mode冲突
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))
(yas/advise-indent-function 'ruby-indent-line)

;; emacs设置自动生成
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cursor-color "#52676f")
 '(display-time-mode t)
 '(ecb-options-version "2.40")
 '(show-paren-mode t)
 '(tool-bar-mode nil))
;; '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 自体设置
(set-frame-font "Menlo-15")
(set-fontset-font
	(frame-parameter nil 'font)
	'han
	(font-spec :family "Hiragino Sans GB" ))

;; 加载主题
(load-theme 'wheatgrass)

