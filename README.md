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

`lecture-notes` provides the `[palatino]` option to load the *Palatino* fonts for the body text. This works if you compile with `xelatex` or `pdflatex`, but the `xelatex` version will attempt to load the *Palatino* font from your computer; if you do not have it installed, you must either install it or patch the class load a different font, using the following =,
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
```

### Minimum Working Examples

To get started with the `lecture-notes` class, copy the following.

```tex
\documentclass{notes}

\title{<name-of-the-class>}      % What is the name of the course
\speaker{<name-of-the-speaker>}  % Who is the speaker

\begin{document}

\end{document}
```

Technically, you can get away with not supplying the `\title` and `\speaker` macros with any arguments, but the will just default to `Course Title` and `Lecturer`, respectively. A typical document will probably include a bit more information.

```tex
\documentclass{notes}

\title{<name-of-the-class>}      % What is the name of the course
\speaker{<name-of-the-speaker>}  % Who is the speaker
\place{<place>}                  % Where is the course held (name of university)
\scribe{<name-of-the-scribe>}    % Name of the person transcribing the lectures
\term{<course-term>}             % Spring, Autumn, Michælmas, etc.
\year{<year>}                    % What year is it
\courseid{<course-id>}           % Usual the department code and a course number

\begin{document}

\end{document}
```

The class extends the `article` class, so you can use the same heading levels to break up the document as you would there (`\section`, `\subsection`, etc).

### Class Options

There are several options available to you to customize your lecture notes.

- `code`: Loads the `minted`, `algorithm`, and `algpseudocode` packages to typeset source code and algorithms.
- `diagram`: Loads `tikz`, and `circuitikz` to draw general diagrams.
- `palatino`: Typesets the document in *Palatino* instead of *Computer Modern*.
- `no-toc`: Removes the table of contents at the beginning of the document (useful for shorter notes and handouts).

Aside from this, you can use all document options which are compatible with the `article` class, except for options relating to page layout; if you want to modify the margins, you'll have to set the margins in you document preable (the `geometry` class is already loaded).