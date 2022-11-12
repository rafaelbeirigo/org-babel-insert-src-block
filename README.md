
# Table of Contents

1.  [Insert Source Code Block for Org Babel&#x2014;ask for a name](#org8ec62ad)
    1.  [Introduction](#org3cdcf64)
    2.  [Function to insert an Org Babel code block](#org334ba9c)
    3.  [Ask for a name and update variable](#org968db46)
    4.  [Update other variables dependent on the name](#org2e14785)
    5.  [Update section name header variable](#orgb145eb8)
    6.  [Get the section name header](#org8b518da)
    7.  [Update noweb-ref block header variable](#org28b50d5)
    8.  [Get noweb-ref block header](#org45fec22)
    9.  [Insert the code block](#orgbbca812)
    10. [Insert the language](#org44e2cb8)
    11. [Languages](#org2735894)
    12. [Insert the block name, if non-empty](#org585b400)
    13. [Insert the section name header, if non-empty](#orgb45fb4c)
    14. [Insert the noweb-ref block header, if non-empty](#org656f447)
    15. [Add a keybinding](#orgb80be7a)
2.  [License](#org5b89b36)



<a id="org8ec62ad"></a>

# Insert Source Code Block for Org Babel&#x2014;ask for a name

This project is a function for Org Babel that, before inserting a
source code block, ask the user for a name.  If the user does not
inform a name, nothing changes.  But if the user does inform a name,
the function will automatically

-   decorate the block with a nicelly formatted string,
-   insert a `:noweb-ref` for the block, and
-   create an Org heading for the code block section.

The idea is to make it easier to do [literate programming](https://en.wikipedia.org/wiki/Literate_programming) on [Emacs](https://en.wikipedia.org/wiki/GNU_Emacs).

All the text below *is* literate programming (LP) itself: the ideas
and divagations are mixed with the source code, and the final product
is automatically extracted from this text via *tangling*.

Thus, the whole entire source code for the program is listed below!
For me, this was the first not-so-short project that I used LP, and I
loved it!


<a id="org3cdcf64"></a>

## Introduction

Org Babel has this nice little functionality of

> Insert[ing] a block structure of the type `#+begin_foo/#+end_foo`.

using the function `org-insert-structure-template`.  This is very
practical, because I have to type less.

What I *wish* Org Babel had was a way to insert the *name* of the code
blocks.  This would help a lot in my literate programming activities.

    <<Function to insert an Org Babel code block>>


<a id="org334ba9c"></a>

## Function to insert an Org Babel code block

The code block may or may not have a name, and this will determine
several things about the tangling process.  The general structure of
the function is depicted below.

\noindent&lang; Function to insert an Org Babel code block &rang;&equiv;

    (defun my-org-babel-insert-src-block ()
      (interactive)
      <<Ask for a name and update variable>>
      <<Update other variables dependent on the name>>
      <<Insert the code block>>)


<a id="org968db46"></a>

## Ask for a name and update variable

\noindent&lang; Block name &rang;&equiv;

    my-org-babel-insert-src-block-name

\noindent&lang; Ask for a name and update variable &rang;&equiv;

    (setq <<Block name>>
          (read-string "Name: "))


<a id="org2e14785"></a>

## Update other variables dependent on the name

\noindent&lang; Update other variables dependent on the name &rang;&equiv;

    <<Update section name header variable>>
    <<Update noweb-ref block header variable>>


<a id="orgb145eb8"></a>

## Update section name header variable

\noindent&lang; Section name header &rang;&equiv;

    my-org-babel-insert-src-block-section-name-header

\noindent&lang; Update section name header variable &rang;&equiv;

    (setq <<Section name header>>
          <<Get the section name header>>)


<a id="org8b518da"></a>

## Get the section name header

\noindent&lang; Get the section name header &rang;&equiv;

    (if (string= <<Block name>> "") ""
      (concat "\\noindent\\langle " <<Block name>> " \\rangle\\equiv"))


<a id="org28b50d5"></a>

## Update noweb-ref block header variable

\noindent&lang; noweb-ref block header &rang;&equiv;

    my-org-babel-insert-src-block-noweb-ref-block-header

\noindent&lang; Update noweb-ref block header variable &rang;&equiv;

    (setq <<noweb-ref block header>>
          <<Get noweb-ref block header>>)


<a id="org45fec22"></a>

## Get noweb-ref block header

\noindent&lang; Get noweb-ref block header &rang;&equiv;

    (if (string= <<Block name>> "") ""
      (concat " :noweb-ref " <<Block name>>))


<a id="orgbbca812"></a>

## Insert the code block

\noindent&lang; Insert the code block &rang;&equiv;

    <<Insert the block name, if non-empty>>
    <<Insert the section name header, if non-empty>>
    (insert "#+begin_src ")
    <<Insert the language>>
    <<Insert the noweb-ref block header, if non-empty>>
    (insert "\n\n#+end_src\n")
    (previous-line)(previous-line)


<a id="org44e2cb8"></a>

## Insert the language

Insert the language
\noindent&lang; Insert the language &rang;&equiv;

    (insert
     (completing-read "Language: "
                      <<Languages>>))


<a id="org2735894"></a>

## Languages

These are the [languages supported by Org Babel](https://orgmode.org/worg/org-contrib/babel/languages/index.html), as of November, 2022.

\noindent&lang; Languages &rang;&equiv;

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
     "sqlite")


<a id="org585b400"></a>

## Insert the block name, if non-empty

\noindent&lang; Insert the block name, if non-empty &rang;&equiv;

    (unless (string= <<Block name>> "")
      (org-insert-heading)
      (insert <<Block name>> "\n\n"))


<a id="orgb45fb4c"></a>

## Insert the section name header, if non-empty

\noindent&lang; Insert the section name header, if non-empty &rang;&equiv;

    (unless (string= <<Section name header>> "")
      (insert <<Section name header>> "\n"))


<a id="org656f447"></a>

## Insert the noweb-ref block header, if non-empty

\noindent&lang; Insert the noweb-ref block header, if non-empty &rang;&equiv;

    (unless (string= <<noweb-ref block header>> "")
      (insert <<noweb-ref block header>>))


<a id="orgb80be7a"></a>

## Add a keybinding

Add a keybinding

\noindent&lang; Add a keybinding &rang;&equiv;

    (define-key org-mode-map
      (kbd "C-. s")
      'my-org-babel-insert-src-block)


<a id="org5b89b36"></a>

# License

This work is dedicated to the public domain.  To the extent possible under law, all copyright and related or neighboring rights to this work are waived worldwide.

<p xmlns:dct="http://purl.org/dc/terms/">

<a rel="licensehref="http://creativecommons.org/publicdomain/zero/1.0/">

<img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />

</a>

</p>

