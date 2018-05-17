# Lecture Notes
`lecture-notes` is a LaTeX class for typesetting lecture notes for students, professors, and speakers. It is fully unicode compatible, loads select packages by default so you don't have to worry about package management, and defines several useful macros to make common commands a bit shorter. The commands defined here closely mimic those in the [`homework`](https://github.com/jopetty/Homework) class.

## Documentation

### Goals
This class is designed to meet the following criteria:
- **LaTeX3 Compatibility**: This class is written using (mostly) LaTeX3 code with `expl3`. This is both as an exercise for myself in learning `expl3` programming, as well as future compatability and contributing to the adoption of LaTeX3.
- **Unicode Compatibility**: Unicode support in LaTeX is, in general, a mess. While there exist a variety of work arounds to support accented Latin characters (`\"{}`, `\'{}`, `\^{}`, etc.), this is an inelegant solution for a couple of reasons: first, it hampers the readability of the document (it's much easier to read/copy/paste `Paul Erdős` than it is `Paul Erd\H{o}s`). Second, it completely ignores the problem of writing in languages which do not use the Latin script, like Greek or Russian. This necessitates the loading of other packages (`babel`, `polyglossia`), each of which come with their own complexity and have the propensity to break the document if package conflict arrises. Instead, `lecture-notes` opts for a much nicer solution: to use `xelatex` to allow for fully Unicode-Compatible source documents. If you don't need this feature, you can always use `pdflatex` instead and save a few seconds on your compiles.
- **Aesthetically Pleasing**: I prefer lecture notes (and documents in general) to use font weights, sizes, and text placement to create a more aesthetically pleasing document. I think this improves readability and clarity. This is, of course, a rather subjective thing, so your personal preferences may not line up with my own. 
- **Ease of use**: This class is designed so that you can plug in the information and start writing, without having to worry about loading some commonly used packages. It also defines many helper macros and environments for common scenarious, most of which are identical to those defined in my [`homework`](https://github.com/jopetty/Homework) class.

### Font Requirements
By default, `lecture-notes` will attempt to load the *Palatino* fonts if you compile with `xelatex`. I think this is a bit softer than the Latin Modern/Computer Modern fonts which are typical to LaTeX documents. If you don't want to typeset your documents with Palatino, you can either 1) compile with `pdflatex`, which uses the default Computer Modern fonts, or 2) add the following line to your document preamble and compile with `xelatex`:
```tex
\setmainfont{<your-font-here>} % Replace <your-font-here> with the desired font
```
Note that all math is still typeset using the Computer Modern (Unicode) font. I do this because I prefer to have a bit of clarity between variables and italics, which can look sneakily similar when text is typeset using Computer Modern fonts as well. You can, of course, override this behaviour if you so wish.

### Compilation

To compile `homework` documents, run the following commands in your shell:

`pdflatex ROOT` or `xelatex ROOT`, where `ROOT` is the main `*.tex` file, with or without the extension.

If your LaTeX file contains source code to be displayed, you will need to add the `-shell-escape` flag. If you are compiling with xelatex, you will need the additional flag `-8bit` when compiling documents with formatted source code to correct a bug in xelatex which causes tab literals to be encoded correctly.

```bash
# compiling with pdflatex
pdflatex main.tex

# compiling with pdflatex, using pygments to format source code
pdflatex -shell-escape main.tex

# compiling with xelatex
xelatex main.tex

# compiling with xelatex, using pygments to format source code
xelatex -shell-escape -8bit main.tex
 