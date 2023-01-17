;;; doom-decay-theme.el --- inspired by Decay -*- no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup doom-decay-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-decay-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-decay-theme
  :type 'boolean)

(defcustom doom-decay-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-decay-theme
  :type 'boolean)

(defcustom doom-decay-comment-bg doom-decay-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-decay-theme
  :type 'boolean)

(defcustom doom-decay-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-decay-theme
  :type '(choice integer boolean))

(eval-and-compile
  (defcustom doom-decay-region-highlight t
    "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
    :group 'doom-decay-theme
    :type 'symbol))

;;
(def-doom-theme decay
  "LOL I just copied the decay theme and changed the colors to mine :)"

  ;; name        default   256       16
  ((bg         '("#13171b" nil       nil            ))
   (bg-alt     '("#13171b" nil       nil            ))
   (base0      '("#242931" "black"   "black"        ))
   (base1      '("#242931" "#1e1e1e" "brightblack"  ))
   (base2      '("#2C333F" "#2e2e2e" "brightblack"  ))
   (base3      '("#373E4C" "#262626" "brightblack"  ))
   (base4      '("#434C5E" "#3f3f3f" "brightblack"  ))
   (base5      '("#485263" "#525252" "brightblack"  ))
   (base6      '("#9099AB" "#6b6b6b" "brightblack"  ))
   (base7      '("#D8DEE9" "#979797" "brightblack"  ))
   (base8      '("#F0F4FC" "#dfdfdf" "white"        ))
   (fg         '("#dee1e6" "#ECECEC" "white"        ))
   (fg-alt     '("#e3e6eb" "#bfbfbf" "brightwhite"  ))

   (grey       base4)
   (red        '("#e05f65" "#ff6655" "red"          )) ;; Decay11
   (orange     '("#e5646a" "#E08A65" "brightred"    )) ;; Decay12
   (green      '("#94f7c5" "#99bb66" "green"        )) ;; Decay14
   (teal       '("#78dba9" "#44B8B1" "brightgreen"  )) ;; Decay7
   (yellow     '("#f1cf8a" "#ECBE7B" "yellow"       )) ;; Decay13
   (blue       '("#75aaf0" "#51afef" "brightblue"   )) ;; Decay9
   (dark-blue  '("#70a5eb" "#2257A0" "blue"         )) ;; Decay10
   (magenta    '("#c68aee" "#c678dd" "magenta"      )) ;; Decay15
   (violet     '("#cb8ff3" "#a9a1e1" "brightmagenta")) ;; ??
   (cyan       '("#79c3ee" "#46D9FF" "brightcyan"   )) ;; Decay8
   (dark-cyan  '("#74bee9" "#5699AF" "cyan"         )) ;; ??

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-decay-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if doom-decay-brighter-comments dark-cyan base5) 0.25))
   (constants      blue)
   (functions      teal)
   (keywords       blue)
   (methods        teal)
   (operators      blue)
   (type           teal)
   (strings        green)
   (variables      base7)
   (numbers        magenta)
   (region         (pcase doom-decay-region-highlight
                     (`frost teal)
                     (`snowstorm base7)
                     (_ base4)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-decay-brighter-modeline)
   (-modeline-pad
    (when doom-decay-padded-modeline
      (if (integerp doom-decay-padded-modeline) doom-decay-padded-modeline 4)))

   (region-fg
    (when (memq doom-decay-region-highlight '(frost snowstorm))
      base0))

   (modeline-fg     nil)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        (doom-blend base0 base5 0.2)
      base1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-blend base0 base5 0.2)
      `(,(doom-darken (car base0) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  (((region &override) :foreground region-fg)

   ((line-number &override) :foreground (doom-lighten 'base5 0.2))
   ((line-number-current-line &override) :foreground base7)
   ((paren-face-match &override) :foreground red :background base3 :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground base3 :background red :weight 'ultra-bold)
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light)
   ((vimish-fold-fringe &override)  :foreground teal)

   (font-lock-comment-face
    :foreground comments
    :slant 'italic
    :background (if doom-decay-comment-bg (doom-lighten bg 0.05)))
   (font-lock-function-name-face
    :foreground magenta
    :slant 'italic)
   (font-lock-variable-name-face
    :foreground violet
    :slant 'italic)
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (doom-modeline-project-root-dir :foreground base6)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; ediff
   (ediff-fine-diff-A    :background (doom-darken violet 0.4) :weight 'bold)
   (ediff-current-diff-A :background (doom-darken base0 0.25))

   ;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; highlight-symbol
   (highlight-symbol-face :background (doom-lighten base4 0.1) :distant-foreground fg-alt)

   ;; highlight-thing
   (highlight-thing :background (doom-lighten base4 0.1) :distant-foreground fg-alt)

   ;; ivy
   ((ivy-current-match &override) :foreground region-fg :weight 'semi-bold)


   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background base0)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ()
  )

;;; doom-decay-theme.el ends here
