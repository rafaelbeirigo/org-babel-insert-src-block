(defun my-org-babel-insert-src-block ()
  (interactive)
  (setq my-org-babel-insert-src-block-name
        (read-string "Name: "))
  (setq my-org-babel-insert-src-block-section-name-header
        (if (string= my-org-babel-insert-src-block-name "") ""
          (concat "@@latex: \\noindent@@ \\langle " my-org-babel-insert-src-block-name " \\rangle\\equiv")))
  (setq my-org-babel-insert-src-block-noweb-ref-block-header
        (if (string= my-org-babel-insert-src-block-name "") ""
          (concat " :noweb-ref " my-org-babel-insert-src-block-name)))
  (unless (string= my-org-babel-insert-src-block-name "")
    (org-insert-heading)
    (insert my-org-babel-insert-src-block-name "\n\n"))
  (unless (string= my-org-babel-insert-src-block-section-name-header "")
    (insert my-org-babel-insert-src-block-section-name-header "\n"))
  (insert "#+begin_src ")
  (insert
   (completing-read "Language: "
                    (list
                     "C"
                     "D"
                     "F90"
                     "R"
                     "awk"
                     "calc"
                     "clojure"
                     "comint"
                     "cpp"
                     "css"
                     "ditaa"
                     "dot"
                     "elisp"
                     "emacs-lisp"
                     "eshell"
                     "forth"
                     "gnuplot"
                     "groovy"
                     "haskell"
                     "java"
                     "js"
                     "julia"
                     "latex"
                     "lisp"
                     "lua"
                     "ly"
                     "makefile"
                     "matlab"
                     "max"
                     "ocaml"
                     "octave"
                     "org"
                     "perl"
                     "plantuml"
                     "processing"
                     "python"
                     "ruby"
                     "sass"
                     "scheme"
                     "screen"
                     "sed"
                     "shell"
                     "sql"
                     "sqlite")))
  (unless (string= my-org-babel-insert-src-block-noweb-ref-block-header "")
    (insert my-org-babel-insert-src-block-noweb-ref-block-header))
  (insert "\n\n#+end_src\n")
  (previous-line)(previous-line))

(define-key org-mode-map
  (kbd "C-. s")
  'my-org-babel-insert-src-block)
