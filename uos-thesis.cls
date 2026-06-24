%% uos-thesis.cls
%% LaTeX class for University of Seoul (서울시립대학교) Graduate School Thesis
%% Based on 대학원 시행세칙 별첨 - 학위논문 체제 및 양식
%%
%% Compile with: pdflatex (Korean font support via the kotex package)
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uos-thesis}[2026/04/13 University of Seoul Thesis Class]

%% ============================================================
%% Options
%% ============================================================
\newif\if@master    \@mastertrue
\newif\if@doctor    \@doctorfalse
\newif\if@korean    \@koreanfalse
\newif\if@hassubtitle \@hassubtitlefalse

\DeclareOption{master}{\@mastertrue\@doctorfalse}
\DeclareOption{doctor}{\@doctortrue\@masterfalse}
\DeclareOption{korean}{\@koreantrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[11pt]{report}

%% ============================================================
%% Required Packages
%% ============================================================

% Page geometry: 4·6배판 (18.2cm x 25.7cm), updated 2024.5.31
\RequirePackage[
  paperwidth=18.2cm,
  paperheight=25.7cm,
  top=3.0cm,
  bottom=3.0cm,
  left=2.5cm,
  right=2.5cm,
  headheight=14pt,
]{geometry}

% Font setup (pdfLaTeX)
\RequirePackage[T1]{fontenc}
\RequirePackage{kotex}          % Korean language support
\RequirePackage{mathptmx}       % Times New Roman equivalent

% Line spacing: 200% = double spacing
\RequirePackage{setspace}
\doublespacing

% Graphics
\RequirePackage{graphicx}
\graphicspath{{figures/}}

% Math
\RequirePackage{amsmath,amssymb,amsfonts}

% Colors (for hyperref)
\RequirePackage{xcolor}

% Hyperlinks
\RequirePackage[
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=blue,
  bookmarks=true,
  bookmarksnumbered=true,
]{hyperref}

% Bibliography
\RequirePackage[
  backend=biber,
  style=numeric,
  sorting=nyt,
  maxbibnames=99,
]{biblatex}

% Center the bibliography heading
\defbibheading{bibintoc}[\bibname]{%
  \chapter*{\hfill #1 \hfill}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}%
}

% Table of contents formatting
\RequirePackage{tocloft}
\RequirePackage{titletoc}

% Section title formatting
\RequirePackage{titlesec}

% Header/footer
\RequirePackage{fancyhdr}

% Caption formatting
\RequirePackage{caption}
\RequirePackage{subcaption}

% Tables
\RequirePackage{booktabs}
\RequirePackage{multirow}

% Algorithms (common in AI theses)
\RequirePackage{algorithm}
% \RequirePackage{algorithmic}

% Misc
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{xparse}

%% ============================================================
%% Font Size Commands (matching UOS specifications)
%% ============================================================
%  Cover title:     22pt
%  Cover subtitle:  16pt
%  Body/Abstract:   11pt (base)
%  Chapter title:   16pt
%  Section title:   14pt
%  Footnote:        9pt

% Chapter title: 16pt bold, left-aligned (matching reference theses)
\titleformat{\chapter}[display]
  {\normalfont\fontsize{16}{20}\bfseries}
  {\chaptername\ \thechapter}{0.5em}{}
\titlespacing*{\chapter}{0pt}{-20pt}{20pt}

% Section title: 14pt bold
\titleformat{\section}
  {\normalfont\fontsize{14}{18}\bfseries}
  {\thesection}{1em}{}
\titlespacing*{\section}{0pt}{12pt}{6pt}

% Subsection title: 12pt bold
\titleformat{\subsection}
  {\normalfont\fontsize{12}{16}\bfseries}
  {\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{10pt}{4pt}

% Subsubsection
\titleformat{\subsubsection}
  {\normalfont\fontsize{11}{15}\bfseries}
  {\thesubsubsection}{1em}{}
\titlespacing*{\subsubsection}{0pt}{8pt}{4pt}

% Footnote size: 9pt
\renewcommand{\footnotesize}{\fontsize{9}{11}\selectfont}

%% ============================================================
%% Page Styles
%% ============================================================
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\fancypagestyle{empty}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\pagestyle{plain}

%% ============================================================
%% Table of Contents Formatting
%% ============================================================
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{\bfseries}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{6pt}

% Make List of Tables / List of Figures entries flush-left so the left and
% right margins are equal (table/figure numbers are not indented from the
% text margin, matching the flush-right page numbers).
\setlength{\cfttabindent}{0pt}
\setlength{\cftfigindent}{0pt}

% TOC/LOT/LOF title names
\renewcommand{\contentsname}{Contents}
\renewcommand{\listtablename}{List of Tables}
\renewcommand{\listfigurename}{List of Figures}

% Center the TOC/LOT/LOF chapter titles
\renewcommand{\cfttoctitlefont}{\hfill\fontsize{16}{20}\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\fontsize{16}{20}\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\fontsize{16}{20}\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}

% Add TOC, LOT, LOF themselves as entries in the TOC
\RequirePackage{tocbibind}

%% ============================================================
%% Metadata Commands
%% ============================================================
\newcommand{\@titleEn}{}
\newcommand{\@titleKo}{}
\newcommand{\@subtitleEn}{}
\newcommand{\@authorEn}{}
\newcommand{\@authorKo}{}
\newcommand{\@departmentEn}{}
\newcommand{\@departmentKo}{}
\newcommand{\@advisorEn}{}
\newcommand{\@advisorKo}{}
\newcommand{\@degreeEn}{}
\newcommand{\@degreeKo}{}
\newcommand{\@degreeFieldEn}{}
\newcommand{\@degreeFieldKo}{}
\newcommand{\@submissionDate}{}
\newcommand{\@approvalDate}{}
\newcommand{\@coverDate}{}
\newcommand{\@committeeChair}{}
\newcommand{\@committeeMemberA}{}
\newcommand{\@committeeMemberB}{}

\newcommand{\titleEn}[1]{\renewcommand{\@titleEn}{#1}}
\newcommand{\titleKo}[1]{\renewcommand{\@titleKo}{#1}}
\newcommand{\subtitleEn}[1]{\renewcommand{\@subtitleEn}{#1}\@hassubtitletrue}
\newcommand{\authorEn}[1]{\renewcommand{\@authorEn}{#1}}
\newcommand{\authorKo}[1]{\renewcommand{\@authorKo}{#1}}
\newcommand{\departmentEn}[1]{\renewcommand{\@departmentEn}{#1}}
\newcommand{\departmentKo}[1]{\renewcommand{\@departmentKo}{#1}}
\newcommand{\advisorEn}[1]{\renewcommand{\@advisorEn}{#1}}
\newcommand{\advisorKo}[1]{\renewcommand{\@advisorKo}{#1}}
\newcommand{\degreeEn}[1]{\renewcommand{\@degreeEn}{#1}}
\newcommand{\degreeKo}[1]{\renewcommand{\@degreeKo}{#1}}
\newcommand{\degreeFieldEn}[1]{\renewcommand{\@degreeFieldEn}{#1}}
\newcommand{\degreeFieldKo}[1]{\renewcommand{\@degreeFieldKo}{#1}}
\newcommand{\submissionDate}[1]{\renewcommand{\@submissionDate}{#1}}
\newcommand{\approvalDate}[1]{\renewcommand{\@approvalDate}{#1}}
\newcommand{\coverDate}[1]{\renewcommand{\@coverDate}{#1}}
\newcommand{\committeeChair}[1]{\renewcommand{\@committeeChair}{#1}}
\newcommand{\committeeMemberA}[1]{\renewcommand{\@committeeMemberA}{#1}}
\newcommand{\committeeMemberB}[1]{\renewcommand{\@committeeMemberB}{#1}}

%% ============================================================
%% Cover Page (표지) [별지 제3호서식 영문] - no page number
%% ============================================================
\newcommand{\makecover}{%
  \newgeometry{top=3cm, bottom=3cm, left=2cm, right=2cm}
  \begin{titlepage}
    \begin{center}
      \vspace{1.0cm}
      {\fontsize{14}{18}\selectfont Master Thesis}
      \vspace{1.5cm}

      {\fontsize{22}{28}\selectfont\bfseries \@titleEn \par}
      \if@hassubtitle
        \vspace{0.5cm}
        {\fontsize{16}{22}\selectfont : \@subtitleEn \par}
      \fi

      \vfill

      {\fontsize{14}{18}\selectfont by}\\[0.8cm]
      {\fontsize{16}{22}\selectfont \@authorEn}

      \vfill

      {\fontsize{14}{18}\selectfont
        Department of \@departmentEn\\[0.3cm]
        The Graduate School of the University of Seoul
      }

      \vspace{1.5cm}
      {\fontsize{14}{18}\selectfont \@coverDate}
    \end{center}
  \end{titlepage}
  \restoregeometry
}

%% ============================================================
%% Submission Page (제출문) [별지 제4호서식 영문] - no page number
%% ============================================================
\newcommand{\makesubmission}{%
  \newgeometry{top=3cm, bottom=3cm, left=3cm, right=3cm}
  \thispagestyle{empty}
  \begin{spacing}{1.3}
  \begin{center}
    \vspace*{1.5cm}

    {\fontsize{16}{22}\selectfont \@titleEn \par}
    \if@hassubtitle
      \vspace{0.3cm}
      {\fontsize{13}{18}\selectfont : \@subtitleEn \par}
    \fi

    \vspace{1.4cm}
    {\fontsize{12}{16}\selectfont by}\\[0.4cm]
    {\fontsize{14}{18}\selectfont \@authorEn}

    \vfill

    {\fontsize{13}{20}\selectfont
      A Master Thesis submitted to the\\
      Department of \@departmentEn\\
      at the Graduate School of the University of Seoul\\
      in partial fulfillment of the requirements for the\\
      degree of \@degreeEn
    }

    \vfill

    {\fontsize{14}{20}\selectfont \@submissionDate}

    \vspace{1.4cm}
    {\fontsize{14}{20}\selectfont
      Approved by\\[0.4cm]
      \@advisorEn\\[0.2cm]
      Advisor
    }

    \vspace*{0.1cm}
  \end{center}
  \end{spacing}
  \clearpage
  \restoregeometry
}

%% ============================================================
%% Approval Page (인준서) [별지 제5호서식 석사 영문] - no page number
%% ============================================================
\newcommand{\makeapproval}{%
  \newgeometry{top=3cm, bottom=3cm, left=3cm, right=3cm}
  \thispagestyle{empty}
  \begin{spacing}{1.0}
  \begin{center}
    \vspace{2.5cm}

    {\fontsize{14}{18}\selectfont
      This certifies that the master thesis of\\[0.5cm]
      \@authorEn~is approved.
    }

    \vspace{2.5cm}

    % Committee Chair
    \rule{7cm}{0.4pt}\\[0.2cm]
    {\fontsize{12}{16}\selectfont Thesis Committee Chair: \@committeeChair}

    \vspace{1.5cm}

    % Committee Member 1
    \rule{7cm}{0.4pt}\\[0.2cm]
    {\fontsize{12}{16}\selectfont Thesis Committee Member: \@committeeMemberA}

    \vspace{1.5cm}

    % Committee Member 2
    \rule{7cm}{0.4pt}\\[0.2cm]
    {\fontsize{12}{16}\selectfont Thesis Committee Member: \@committeeMemberB}

    \vfill

    {\fontsize{12}{16}\selectfont
      The Graduate School of the University of Seoul\\[0.3cm]
      \@approvalDate
    }
  \end{center}
  \end{spacing}
  \clearpage
  \restoregeometry
}

%% ============================================================
%% Abstract Environment (영문초록 - front matter) - no page number
%% ============================================================
\renewenvironment{abstract}{%
  \clearpage
  \thispagestyle{empty}
  \begin{center}
    \vspace{0.5cm}
    {\fontsize{16}{20}\selectfont\bfseries Abstract}\\[0.8cm]
  \end{center}
  \begin{spacing}{1.3}
  \fontsize{11}{14}\selectfont
  \noindent
}{%
  \end{spacing}
  \clearpage
}

%% ============================================================
%% Keywords Command
%% ============================================================
\newcommand{\keywords}[1]{%
  \vspace{1cm}
  \noindent\textbf{Keywords}: #1
}

%% ============================================================
%% Inner Cover Page (속표지 - same as cover) - no page number
%% ============================================================
\newcommand{\makeinnercover}{%
  \makecover
}

%% ============================================================
%% Korean Abstract (국문초록 - back matter)
%% ============================================================
\newenvironment{abstractko}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{초록}
  \thispagestyle{plain}
  \begin{center}
    \vspace{0.5cm}
    {\fontsize{16}{20}\selectfont\bfseries 초\quad 록}\\[0.8cm]
  \end{center}
  \begin{spacing}{1.3}
  \fontsize{11}{14}\selectfont
  \noindent
}{%
  \end{spacing}
  \clearpage
}

\newcommand{\keywordsko}[1]{%
  \vspace{1cm}
  \noindent\textbf{주요어}: #1
}

%% ============================================================
%% Acknowledgments
%% ============================================================
\newenvironment{acknowledgments}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{Acknowledgments}
  \begin{center}
    {\fontsize{16}{20}\selectfont\bfseries Acknowledgments}\\[1cm]
  \end{center}
  \begin{spacing}{1.6}
  \fontsize{11}{14}\selectfont
}{%
  \end{spacing}
  \clearpage
}

%% ============================================================
%% Front Matter / Main Matter / Back Matter
%% ============================================================
\newcommand{\frontmatter}{%
  \cleardoublepage
  \pagenumbering{roman}
}

\newcommand{\mainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}
  \setcounter{page}{1}
}

\newcommand{\backmatter}{%
  \cleardoublepage
}

%% ============================================================
%% Chapter format for unnumbered special chapters
%% ============================================================
\newcommand{\specialchapter}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}
  \begin{center}
    {\fontsize{16}{20}\selectfont\bfseries #1}\\[1cm]
  \end{center}
}

\endinput
====================================================
\newcommand{\specialchapter}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}
  \begin{center}
    {\fontsize{16}{20}\selectfont\bfseries #1}\\[1cm]
  \end{center}
}

\endinput
