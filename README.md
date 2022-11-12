
# Table of Contents

1.  [Insert Code Block&#x2014;Ask for a Name](#orgc58f016)
    1.  [Introduction](#orge0686f2)
    2.  [Function to insert an Org Babel code block](#org09374ed)
    3.  [Ask for a name and update variable](#org525c01a)
    4.  [Update other variables dependent on the name](#org85eac37)
    5.  [Update section name header variable](#org739b92a)
    6.  [Get the section name header](#org95cc4ad)
    7.  [Update noweb-ref block header variable](#orgf9cf159)
    8.  [Get noweb-ref block header](#org973d614)
    9.  [Insert the code block](#org694e897)
    10. [Insert the language](#org3ea2cb3)
    11. [Languages](#org0c3d2a3)
    12. [Insert the block name, if non-empty](#org3f67d02)
    13. [Insert the section name header, if non-empty](#orgf21d529)
    14. [Insert the noweb-ref block header, if non-empty](#orgbde14e9)
    15. [Add a keybinding](#orgde9728f)
2.  [License](#org355ed0d)



<a id="orgc58f016"></a>

# Insert Code Block&#x2014;Ask for a Name

This project is a function for Org Babel that, before inserting a
source code block, asks the user for a name.  If the user does not
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


<a id="orge0686f2"></a>

## Introduction

Org Babel has this nice little functionality of

> Insert[ing] a block structure of the type `#+begin_foo/#+end_foo`.

using the function `org-insert-structure-template`.  This is very
practical, because I have to type less.

What I *wish* Org Babel had was a way to insert the *name* of the code
blocks.  This would help a lot in my literate programming activities.

    <<Function to insert an Org Babel code block>>


<a id="org09374ed"></a>

## Function to insert an Org Babel code block

The code block may or may not have a name, and this will determine
several things about the tangling process.  The general structure of
the function is depicted below.

 &lang; Function to insert an Org Babel code block &rang;&equiv;

    (defun my-org-babel-insert-src-block ()
      (interactive)
      <<Ask for a name and update variable>>
      <<Update other variables dependent on the name>>
      <<Insert the code block>>)


<a id="org525c01a"></a>

## Ask for a name and update variable

 &lang; Block name &rang;&equiv;

    my-org-babel-insert-src-block-name

 &lang; Ask for a name and update variable &rang;&equiv;

    (setq <<Block name>>
          (read-string "Name: "))


<a id="org85eac37"></a>

## Update other variables dependent on the name

 &lang; Update other variables dependent on the name &rang;&equiv;

    <<Update section name header variable>>
    <<Update noweb-ref block header variable>>


<a id="org739b92a"></a>

## Update section name header variable

 &lang; Section name header &rang;&equiv;

    my-org-babel-insert-src-block-section-name-header

 &lang; Update section name header variable &rang;&equiv;

    (setq <<Section name header>>
          <<Get the section name header>>)


<a id="org95cc4ad"></a>

## Get the section name header

 &lang; Get the section name header &rang;&equiv;

    (if (string= <<Block name>> "") ""
      (concat "@@latex: \\noindent@@ \\langle " <<Block name>> " \\rangle\\equiv"))


<a id="orgf9cf159"></a>

## Update noweb-ref block header variable

 &lang; noweb-ref block header &rang;&equiv;

    my-org-babel-insert-src-block-noweb-ref-block-header

 &lang; Update noweb-ref block header variable &rang;&equiv;

    (setq <<noweb-ref block header>>
          <<Get noweb-ref block header>>)


<a id="org973d614"></a>

## Get noweb-ref block header

 &lang; Get noweb-ref block header &rang;&equiv;

    (if (string= <<Block name>> "") ""
      (concat " :noweb-ref " <<Block name>>))


<a id="org694e897"></a>

## Insert the code block

 &lang; Insert the code block &rang;&equiv;

    <<Insert the block name, if non-empty>>
    <<Insert the section name header, if non-empty>>
    (insert "#+begin_src ")
    <<Insert the language>>
    <<Insert the noweb-ref block header, if non-empty>>
    (insert "\n\n#+end_src\n")
    (previous-line)(previous-line)


<a id="org3ea2cb3"></a>

## Insert the language

Insert the language
 &lang; Insert the language &rang;&equiv;

    (insert
     (completing-read "Language: "
                      <<Languages>>))


<a id="org0c3d2a3"></a>

## Languages

These are the [languages supported by Org Babel](https://orgmode.org/worg/org-contrib/babel/languages/index.html), as of November, 2022.

 &lang; Languages &rang;&equiv;

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


<a id="org3f67d02"></a>

## Insert the block name, if non-empty

 &lang; Insert the block name, if non-empty &rang;&equiv;

    (unless (string= <<Block name>> "")
      (org-insert-heading)
      (insert <<Block name>> "\n\n"))


<a id="orgf21d529"></a>

## Insert the section name header, if non-empty

 &lang; Insert the section name header, if non-empty &rang;&equiv;

    (unless (string= <<Section name header>> "")
      (insert <<Section name header>> "\n"))


<a id="orgbde14e9"></a>

## Insert the noweb-ref block header, if non-empty

 &lang; Insert the noweb-ref block header, if non-empty &rang;&equiv;

    (unless (string= <<noweb-ref block header>> "")
      (insert <<noweb-ref block header>>))


<a id="orgde9728f"></a>

## Add a keybinding

Add a keybinding

 &lang; Add a keybinding &rang;&equiv;

    (define-key org-mode-map
      (kbd "C-. s")
      'my-org-babel-insert-src-block)


<a id="org355ed0d"></a>

# License

This work is dedicated to the public domain.  To the extent possible under law, all copyright and related or neighboring rights to this work are waived worldwide.

<p xmlns:dct="http://purl.org/dc/terms/">

<a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/">

<img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />

</a>

</p>

