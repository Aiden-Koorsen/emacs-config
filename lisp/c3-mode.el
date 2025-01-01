;;; c3-mode.el --- Major mode for editing C3 language -*- lexical-binding: t -*-

;;; Code:

;; Define the basic keywords and operators for the C3 language.
(defvar c3-keywords
  '("if" "else" "while" "for" "return" "break" "continue" "struct" "union"
    "enum" "typedef" "sizeof" "switch" "case" "default" "static" "const" 
    "inline" "defer" "fn" "module" "import"))

(defvar c3-types
  '("int" "float" "double" "bool" "char" "void" "u8" "u16" "u32" "u64"
    "i8" "i16" "i32" "i64" "f32" "f64" "String" "String\\[\\]"))

(defvar c3-constants
  '("true" "false" "null"))

(defvar c3-operators
  '("+" "-" "*" "/" "%" "=" "==" "!=" "<" ">" "<=" ">=" "&&" "||" "!" "&" "|"
    "^" "~" "<<" ">>"))

;; Syntax highlighting using font-lock
(setq c3-font-lock-keywords
      `((,(regexp-opt c3-keywords 'words) . font-lock-keyword-face)
        (,(regexp-opt c3-types 'words) . font-lock-type-face)
        (,(regexp-opt c3-constants 'words) . font-lock-constant-face)
        (,(regexp-opt c3-operators) . font-lock-builtin-face)
        ("\\('[^']*'\\)" . font-lock-string-face)   ;; Highlight character literals
        ("\\(\"[^\"]*\"\\)" . font-lock-string-face) ;; Highlight string literals
        ("\\<\\(0x[0-9A-Fa-f]+\\|[0-9]+\\)\\>" . font-lock-constant-face))) ;; Numeric literals

;; Define the mode's syntax table
(defvar c3-mode-syntax-table
  (let ((syntax-table (make-syntax-table)))
    ;; Single-line comment start '//'
    (modify-syntax-entry ?/ ". 124" syntax-table)
    (modify-syntax-entry ?/ ". 12b" syntax-table)   ;; Start comment
    (modify-syntax-entry ?\n "> b" syntax-table)    ;; End comment
    
    ;; Multi-line comment start '/*' and end '*/'
    (modify-syntax-entry ?* ". 23" syntax-table)    ;; End of multi-line comment

    ;; Operator characters
    (modify-syntax-entry ?+ "." syntax-table)
    (modify-syntax-entry ?- "." syntax-table)
    (modify-syntax-entry ?= "." syntax-table)
    (modify-syntax-entry ?% "." syntax-table)
    syntax-table))

;; Indentation logic (basic)
(defun c3-indent-line ()
  "Indent the current line of C3 code."
  (interactive)
  (let ((indent-level (c3-calculate-indentation)))
    (if indent-level
        (indent-line-to indent-level)
      (indent-line-to 0))))

(defun c3-calculate-indentation ()
  "Calculate the indentation for the current line in C3 mode."
  (save-excursion
    (beginning-of-line)
    (if (bobp)  ;; Beginning of buffer
        0
      (let ((not-indented t)
            (indent-level 0))
        (while not-indented
          (forward-line -1)
          (if (looking-at "^[ \t]*}")  ;; Dedent for closing brace
              (setq indent-level (current-indentation)
                    not-indented nil)
            (if (looking-at "^[ \t]*{")  ;; Indent for opening brace
                (setq indent-level (+ (current-indentation) tab-width)
                      not-indented nil)
              (if (bobp)
                  (setq not-indented nil)))))
        indent-level))))

;; Define the actual mode function
(define-derived-mode c3-mode prog-mode "C3"
  "Major mode for editing C3 language files."
  :syntax-table c3-mode-syntax-table
  (setq font-lock-defaults '(c3-font-lock-keywords))
  (setq-local indent-line-function 'c3-indent-line))

;; File extension association
(add-to-list 'auto-mode-alist '("\\.c3\\'" . c3-mode))

(provide 'c3-mode)

;;; c3-mode.el ends here
