%% notes.cls
%%
%% A (Xe)LaTeX 3 class for lecture notes.

\RequirePackage{expl3, xparse, ifxetex}

\ExplSyntaxOn

%% MARK: Class Metadata
%% Provides information to the LaTeX3 compiler
%% about what our class does.
\tl_const:Nn \c__notes_class_name_tl            {notes}
\tl_const:Nn \c__notes_class_version_tl         {1.0.0}
\tl_const:Nn \c__notes_class_date_tl            {2018/05/12}
\tl_const:Nn \c__notes_class_description_tl     {A~LaTeX3~class~for~lecture~notes.}
\tl_const:Nn \c__notes_class_parent_class_tl    {article}

\ProvidesExplClass{\c__notes_class_name_tl}         % Class
                  {\c__notes_class_date_tl}         % Date
                  {\c__notes_class_version_tl}      % Version
                  {\c__notes_class_description_tl}  % Description

%% MARK: Class Data
%% Data set by the user about the course or lecture.
%% Used to create headers, title page, etc.
\tl_new:N \g_notes_title_tl       % Document Title (Course Name, Lecture Name, etc)
\tl_new:N \g_notes_shorttitle_tl  % Document Short Title (for headers)
\tl_new:N \g_notes_speaker_tl     % Speaker (Professor, Lecturer, etc)
\tl_new:N \g_notes_spkemail_tl    % Speaker Email
\tl_new:N \g_notes_scribe_tl      % Scribe (you, person taking notes)
\tl_new:N \g_notes_scremail_tl    % Scribe Email
\tl_new:N \g_notes_courseid_tl  % Course ID (e.g., MATH 230)
\tl_new:N \g_notes_term_tl        % Course Term (Spring, Michaelmas, etc)
\tl_new:N \g_notes_year_tl        % Year
\tl_new:N \g_notes_place_tl       % Place

% Set default values for data commands
\tl_gset:Nn	\g_notes_title_tl       {Course~Title}
\tl_gset:Nn	\g_notes_shorttitle_tl  {\g_notes_title_tl}
\tl_gset:Nn	\g_notes_speaker_tl     {Lecturer}
\tl_clear_new:N	\g_notes_spkemail_tl
\tl_clear_new:N	\g_notes_scribe_tl
\tl_clear_new:N	\g_notes_scremail_tl
\tl_clear_new:N	\g_notes_courseid_tl
\tl_clear_new:N	\g_notes_term_tl
\tl_clear_new:N	\g_notes_year_tl
\tl_clear_new:N	\g_notes_place_tl

% Provide user-facing interface to document commands
\RenewDocumentCommand\title{ m }{\tl_gset:Nn \g_notes_title_tl {#1}}
\NewDocumentCommand\shorttitle{ m }{\tl_gset:Nn \g_notes_shorttitle_tl {#1}}
\NewDocumentCommand\speaker{ m }{\tl_gset:Nn \g_notes_speaker_tl {#1}}
\NewDocumentCommand\speakeremail{ m }{\tl_gset:Nn \g_notes_spkemail_tl {#1}}
\NewDocumentCommand\scribe{ m }{\tl_gset:Nn \g_notes_scribe_tl {#1}}
\NewDocumentCommand\scribeemail{ m }{\tl_gset:Nn \g_notes_scremail_tl {#1}}
\NewDocumentCommand\courseid{ m }{\tl_gset:Nn \g_notes_courseid_tl {#1}}
\NewDocumentCommand\term{ m }{\tl_gset:Nn \g_notes_term_tl {#1}}
\RenewDocumentCommand\year{ m }{\tl_gset:Nn \g_notes_year_tl {#1}}
\NewDocumentCommand\place{ m }{\tl_gset:Nn \g_notes_place_tl {#1}}

%% MARK: Class Options
% Flags for packages
\bool_new:N	\g_notes_loadchem_bool	% Chemical Diagrams
\bool_new:N	\g_notes_loadcode_bool	% Algorithm/Source code formatting
\bool_new:N	\g_notes_loaddiag_bool	% TikZ, pgfplots, etc

% Set flags to FALSE by default
\bool_gset_false:N	\g_notes_loadchem_bool
\bool_gset_false:N	\g_notes_loadcode_bool
\bool_gset_false:N	\g_notes_loaddiag_bool

% Provide class options to load packages
\DeclareOption{chemistry}{\bool_gset_true:N \g_notes_loadchem_bool}
\DeclareOption{code}{\bool_gset_true:N \g_notes_loadcode_bool}
\DeclareOption{diagram}{\bool_gset_true:N \g_notes_loaddiag_bool}

% Table of Contents
\bool_new:N \g_notes_toc_bool
\bool_gset_true:N \g_notes_toc_bool
\DeclareOption{no-toc}{\bool_gset_false:N \g_notes_toc_bool}

% Font
\str_new:N \g_notes_font_str
\bool_new:N \g_notes_cmufont_bool
\str_gset:Nn \g_notes_font_str {Palatino-Roman}
\bool_gset_false:N \g_notes_cmufont_bool
\DeclareOption{cmu}{
	\bool_gset_true:N \g_notes_cmufont_bool
	\str_gset:Nn \g_notes_font_str {CMUSerif-Roman}
}

% Pass all remaining options to parent class
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{\c__notes_class_parent_class_tl}
}
\ProcessOptions\relax

%% MARK: Load Parent Class
\LoadClass[letterpaper]{\c__notes_class_parent_class_tl}

%% MARK: Load Packages
% Formatting
\RequirePackage[top = 1.45in, bottom = 1.35in, inner = 1.15in, outer = 2in, marginparwidth=1.4in, marginparsep=0.25in]{geometry}
\RequirePackage{framed}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage[overload]{textcase}
\RequirePackage[titles]{tocloft}
\RequirePackage{fancyhdr}
\RequirePackage[side,flushmargin]{footmisc}

% Mathematics
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}
\RequirePackage{bm}

% Physics
\RequirePackage{physics}
\RequirePackage{siunitx}

% Computer Science
\bool_if:NT	\g_notes_loadcode_bool {
	\RequirePackage{minted} \usemintedstyle{tango}
	\RequirePackage{algorithm}
	\RequirePackage{algpseudocode}
}

% Diagrams
\bool_if:NT	\g_notes_loaddiag_bool {
	\RequirePackage{tikz}
	\RequirePackage[american, siunitx]{circuitikz}
}

%% MARK: Fonts
\ifxetex
	% Load xelatex font
	\RequirePackage[no-math]{fontspec}
	\setmainfont{\g_notes_font_str}

	% Wide kerning for title page / sections
	\bool_if:NTF \g_notes_cmufont_bool {
		\NewDocumentCommand\widekern{ } {\addfontfeatures{LetterSpace=8}}
	} {
		\NewDocumentCommand\widekern{ } {\addfontfeatures{LetterSpace=10}}
	}
\else
	% Allow UTF-8 characters
	\RequirePackage[utf8]{inputenc}

	% Adjust kerning
	\RequirePackage[letterspace=140]{microtype}

	% Create empty macro for kerning
	\NewDocumentCommand\widekern{ } {\lsstyle}

	% Load pdflatex Palatino
	\bool_if:NTF \g_notes_cmufont_bool {} {
		\RequirePackage{palatino}
	}
\fi

% Define line spacing
\NewDocumentCommand\normalspacing{ } {\renewcommand{\baselinestretch}{1.2}}
\NewDocumentCommand\tightspacing{ }  {\renewcommand{\baselinestretch}{0.8}}
\normalspacing

%% MARK: Title/Section Formatting
% Header and Footer
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\rightmark}
\fancyfoot[C]{\small \thepage}
\renewcommand{\sectionmark}[1]{\markright{\relax\widekern\thesection{}~\hspace{1.2em}\MakeTextUppercase{#1}}}

% Table of Contents
\renewcommand{\cfttoctitlefont}{\relax\centering\widekern\MakeUppercase}
\renewcommand{\cftsecfont}{}
\renewcommand{\cftsecpagefont}{}
\renewcommand{\cftsubsecfont}{\itshape}

% Format Sections
\titleformat{\section}                          % Level
            {\normalfont\centering\widekern}    % Formatting
            {\thesection}                       % Label
            {1em}                               % Label Spacing
            {\MakeTextUppercase}                % Before Code

\titleformat{\subsection}                       % Level
            {\normalfont\centering\itshape}     % Formatting
            {\thesubsection}                    % Label
            {1em}                               % Label Spacing
            {}                                  % Before Code

% Section spacing
\titlespacing\section{0ex}{4ex plus 0.2ex minus 0.2ex}{1.5ex plus 0.2ex minus 0.2ex}

% Title Page
\RenewDocumentCommand\maketitle{}{
	\newpage
	\thispagestyle{plain}
	\null
	\vskip 4ex
	\begin{center}
		{\widekern
		{\large\MakeUppercase{
			\tl_if_empty:NTF \g_notes_courseid_tl {} {\g_notes_courseid_tl{}~---~}
			\g_notes_title_tl{}
		}}
		\vskip 2ex
		{\MakeUppercase{
			\tl_if_empty:NTF \g_notes_place_tl {} {\g_notes_place_tl{},}
			\tl_if_empty:NTF \g_notes_term_tl  {} {~\g_notes_term_tl{}}
			\tl_if_empty:NTF \g_notes_year_tl  {} {~\g_notes_year_tl{}}
		}}
		\vskip 2ex
		{\small\MakeUppercase{\g_notes_speaker_tl{}}}}
		\tl_if_empty:NTF \g_notes_scribe_tl {} {
			\vskip 3.5ex
			{\small\itshape{Notes~by~\g_notes_scribe_tl{}}}
		}
		\vskip 7ex
		\noindent \rule{2.4cm}{0.4pt}
	\end{center}
	\vskip 7ex
	\bool_if:NT \g_notes_toc_bool {
		{\tightspacing\tableofcontents{}\normalspacing}
		\vskip 7ex
	}
}

%% MARK: Custom Macros
% Margin Notes
\NewDocumentCommand\note{ m } {
	\tightspacing
	\marginpar{\textit{\footnotesize{#1}}}
	\normalspacing
}

% Footnotes
\let\oldfootnote\footnote
\RenewDocumentCommand\footnote{ m } {\oldfootnote{\textit{#1}}}

% Final box
\NewDocumentCommand\final{ m } {\boxed{#1}}

% Custom math commands
\NewDocumentCommand\bbr{} {\mathbb{R}}
\NewDocumentCommand\bbc{} {\mathbb{C}}
\NewDocumentCommand\bbz{} {\mathbb{Z}}
\NewDocumentCommand\bbq{} {\mathbb{Q}}
\NewDocumentCommand\bbn{} {\mathbb{N}}
\NewDocumentCommand\bbf{} {\mathbb{F}}

% Custom units
\DeclareSIUnit{\mile}{mi}
\DeclareSIUnit{\gallon}{gallon}
\DeclareSIUnit{\pound}{lb}
\DeclareSIUnit{\foot}{ft}
\DeclareSIUnit{\atmosphere}{atm}
\DeclareSIUnit{\fahrenheit}{\degree F}
\DeclareSIUnit{\atom}{at}
\DeclareSIUnit{\molecule}{molecule}
\DeclareSIUnit{\calorie}{cal}
\DeclareSIUnit{\Calorie}{Cal}
\DeclareSIUnit{\inch}{in}

% Unit vector formatting
\NewDocumentCommand\unit{ m } {\bm{\hat{\mathbf{#1}}}}

% Formatting Theorems/etc
\RenewDocumentCommand\qedsymbol{}{$\blacksquare$}
\NewDocumentEnvironment{solution}{ o }
                       {\IfNoValueTF{#1}{\begin{proof}[Solution]}{\begin{proof}[#1]}}
                       {\end{proof}}

\theoremstyle{definition}
\newtheorem{definition}{Definition}

%% MARK: Begining of document
\AtBeginDocument{
	\maketitle
}