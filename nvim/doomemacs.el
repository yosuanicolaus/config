;; 241223 backup, want to change from doom emacs to spacemacs

;; enable "viw" to select everything related with underscores
(modify-syntax-entry ?_ "w")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 13))

(setq doom-theme 'doom-monokai-spectrum)
(setq display-line-numbers-type 'relative)
