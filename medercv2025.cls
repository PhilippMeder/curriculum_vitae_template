%-----------------------------------------------------------
% LaTeX class for curriculum vitae
% Author: Philipp Meder (2025)
%-----------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{medercv2025}[2025/04/14 Curriculum Vitae Template]

%-----------------------------------------------------------
% Basic setup
%-----------------------------------------------------------

% Build around KOMA
\LoadClass{scrartcl}

% Pass options to base class (move down if you provide options yourself)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

% For better tabular
\RequirePackage{tabularx}
\renewcommand{\arraystretch}{1.3}

% For graphics
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}
% \usetikzlibrary{backgrounds}
\RequirePackage{float}

% Allow language detection
\RequirePackage{translations}

% For links
\RequirePackage[hidelinks]{hyperref}

%-----------------------------------------------------------
% Colors & columns
%-----------------------------------------------------------

% Colors
\RequirePackage[table]{xcolor}

\definecolor{normal}{HTML}{000000}
\definecolor{title}{HTML}{3b3b3b}
\definecolor{section}{HTML}{3b3b3b}
%\definecolor{infolabel}{HTML}{5e5e5e}
\definecolor{infolabel}{HTML}{4d4d4d}
\definecolor{label}{HTML}{4d4d4d}
\definecolor{frame}{HTML}{9b3b3b}
%\definecolor{header}{HTML}{ececec}
%\definecolor{header}{HTML}{3b3b6b}
%\definecolor{header}{HTML}{25292e}
\definecolor{header}{HTML}{3b3b3b}
\definecolor{headernormal}{HTML}{ffffff}
\definecolor{headertitle}{HTML}{ffffff}
\definecolor{rule}{HTML}{9b3b3b}
\definecolor{skillbackground}{HTML}{3b3b3b}
\definecolor{skillforeground}{HTML}{f9f9f9}
\definecolor{goodskill}{HTML}{33ff33}
\definecolor{mediumskill}{HTML}{ff7777}
%\definecolor{basicskill}{HTML}{999999}
\definecolor{basicskill}{HTML}{7777ff}

\newcommand*{\colorrule}[2]{\textcolor{rule}{\rule{#1}{#2}}}

% For two columns
\RequirePackage{paracol}
\setlength{\columnsep}{1.5cm}
\columnratio{0.23}[0.75]
\backgroundcolor{c[0](16pt,0pt)(0.5\columnsep,0pt)}[HTML]{e6e6e6}

%-----------------------------------------------------------
% Fonts & layout
%-----------------------------------------------------------

% Fonts
\RequirePackage{ifluatex}
\ifluatex
    \RequirePackage{unicode-math}
    \setmainfont{Libertinus Serif}
    % \setmainfont{Linux Libertine G}
    % \setmainfont{Linux Libertine O}
    % \setmainfont{texgyrepagella}
    % \setmathfont{texgyrepagella-math}
\else
    % \RequirePackage{newpxtext,newpxmath} % has to be after amssymb
    \RequirePackage{libertine}
\fi

\renewcommand*{\familydefault}{\sfdefault}
\newkomafont{titletype}{\bfseries\color{headertitle}}
\setkomafont{titlehead}{\usekomafont{titletype}\Large\MakeUppercase}
\setkomafont{title}{\usekomafont{titletype}\huge\MakeUppercase}
\setkomafont{section}{\large\bfseries\color{section}}
\newkomafont{infolabel}{\color{infolabel}}
\newkomafont{label}{\color{label}}
\newkomafont{skilllabel}{\bfseries\color{skillforeground}}

% Section lines
\renewcommand*\sectionlinesformat[4]{%
  \Ifstr{#1}{section}{%
		\parbox[t]{\linewidth}{%
			\raggedsection\@hangfrom{\hskip #2#3}{#4}\par%
			\vspace*{-1\ht\strutbox}\colorrule{\linewidth}{1pt}%
		}%
	}{%
		\@hangfrom{\hskip #2#3}{#4}}% 
}

% No page number
\renewcommand*{\pagemark}{}

%-----------------------------------------------------------
% Define necessary variables and language dependent names
%-----------------------------------------------------------

\newcommand*{\thetitle}{%
    \ifcurrentbaselanguage{English}%
    {Curriculum Vitae}%
    {Lebenslauf}%
}
\renewcommand*{\title}[1]{\renewcommand*{\thetitle}{#1}}

\newcommand*{\theauthor}{}
\renewcommand*{\author}[1]{\renewcommand*{\theauthor}{#1}}

\newcommand*{\theauthorimage}{author}
\newcommand*{\authorimage}[1]{\renewcommand*{\theauthorimage}{#1}}

\newcommand*{\theaddressname}{%
    \ifcurrentbaselanguage{English}%
    {Address}%
    {Adresse}%
}
\newcommand*{\theaddress}{}
\newcommand*{\address}[1]{\renewcommand*{\theaddress}{#1}}

\newcommand*{\thebirthdayname}{%
    \ifcurrentbaselanguage{English}%
    {Birthday}%
    {Geburtstag}%
}
\newcommand*{\thebirthday}{}
\newcommand*{\birthday}[1]{\renewcommand*{\thebirthday}{#1}}

\newcommand*{\thephonename}{%
    \ifcurrentbaselanguage{English}%
    {Phone}%
    {Telefon}%
}
\newcommand*{\thephone}{}
\newcommand*{\phone}[1]{\renewcommand*{\thephone}{#1}}

\newcommand*{\themailname}{%
    \ifcurrentbaselanguage{English}%
    {E-Mail}%
    {E-Mail}%
}
\newcommand*{\themail}{}
\newcommand*{\mail}[1]{\renewcommand*{\themail}{#1}}

\newcommand*{\thegithubname}{%
	\ifcurrentbaselanguage{English}%
	{Github}%
	{Github}%
}
\newcommand*{\thegithub}{}
\newcommand*{\github}[1]{\renewcommand*{\thegithub}{#1}}

\newcommand*{\thegradename}{%
	\ifcurrentbaselanguage{English}%
	{Grade}%
	{Note}%
}
\newcommand*{\grade}[1]{\thegradename:~#1}

\newcommand*{\theaboutmename}{%
	\ifcurrentbaselanguage{English}%
	{About Me}%
	{Über mich}%
}

\newcommand*{\theexperiencename}{%
	\ifcurrentbaselanguage{English}%
	{Professional Experience}%
	{Berufliche Erfahrung}%
}

\newcommand*{\theeducationname}{%
	\ifcurrentbaselanguage{English}%
	{Education}%
	{Bildungsweg}%
}

\newcommand*{\thecontactname}{%
	\ifcurrentbaselanguage{English}%
	{Contact}%
	{Kontakt}%
}

%-----------------------------------------------------------
% Setup authorinfo commands
%-----------------------------------------------------------

\newcommand*{\infoelement}[2]{\ifx #2\empty\else {\usekomafont{infolabel}#1} & #2 \\ \fi}

\newcommand*{\authorinfo}{
    \begin{tabular}{ll}
        & \\
        \infoelement{\thebirthdayname}{\thebirthday}
        \infoelement{\theaddressname}{\theaddress}        
        \infoelement{\themailname}{\themail}
        \infoelement{\thephonename}{\thephone}
        \infoelement{\thegithubname}{\href{https://github.com/\thegithub}{\thegithub}}
    \end{tabular}
}

\newcommand*{\twocolumncontactinfo}{
	\begin{tabularx}{\textwidth}{llXll}
		{\usekomafont{infolabel}\themailname} & \themail & &
		{\usekomafont{infolabel}\theaddressname} & \theaddress \\
		{\usekomafont{infolabel}\thegithubname} & \href{https://github.com/\thegithub}{\thegithub} & &
		{\usekomafont{infolabel}\thephonename} & \thephone 
	\end{tabularx}
}

\newcommand*{\contactinfo}{
	\begin{tabular}{l}
		{\usekomafont{infolabel}\theaddressname} \\ \theaddress \\
		{\usekomafont{infolabel}\themailname} \\
		\themail \\	
		{\usekomafont{infolabel}\thephonename} \\
		\thephone \\
		{\usekomafont{infolabel}\thegithubname} \\ \href{https://github.com/\thegithub}{\thegithub} \\ 
	\end{tabular}
}

\newcommand*{\authorpicture}{
    \begin{tikzpicture}
        \node[inner sep=0] (img) at (0,0) {\includegraphics[height=3cm]{\theauthorimage}};
        \draw[frame, ultra thick] (img.south west) rectangle (img.north east);
    \end{tikzpicture}
}

%-----------------------------------------------------------
% Update the 'maketitle' command to make the header
%-----------------------------------------------------------

\renewcommand*{\@maketitle}
{
\tikz[remember picture,overlay] {%
	\node[rectangle, fill=header, anchor=north, minimum width=\paperwidth, minimum height=3.5cm](header) at (current page.north){};%
	\draw[frame, ultra thick] (header.south west) rectangle (header.south east);
	\node[draw=none, anchor=west](picture) at (current page text area.north west) {\authorpicture};%  
%	\node[draw=none, anchor=west, shift=({0.23\textwidth+1.5cm,0})](name) at (current page text area.north west) {\usekomafont{title} \theauthor};% 
%	}
	\node[draw=none, shift=({1cm,0})](name) at (current page text area.north) {\usekomafont{title} \theauthor};% 
}
	\vspace{2cm}
}

%-----------------------------------------------------------
% Define environments and commands for events and skills
%-----------------------------------------------------------

% Define events
\newenvironment{events}[1][0.82]{\begin{tabular}{rp{#1\linewidth}}}{\end{tabular}}

% Define event command, use as: \event{timespan}{title}{description}
\newcommand*{\event}[3]{{\usekomafont{label} #1} & \textbf{#2}\newline #3 \\}

% Define skills
\newenvironment{skills}{\begin{tabular}{ll}}{\end{tabular}}

% Define command for a described skill, use as: \skilldescribed{skillname}{description}
\newcommand*{\skilldescribed}[2]{\textbf{#1} & #2 \\}

% Define colorbar needed for the next command (\skillrated)
\newlength{\skillrulewidth}
\setlength{\skillrulewidth}{0.5em}
\newcommand*{\skillrule}[2]{
{\color{#2}\rule[\baselineskip]{#1\linewidth}{\skillrulewidth}}
}

% Define command for a skill with a visual rating of the skill level, use as: \skillrated{skillname}{rating}{color}
\newcommand*{\skillrated}[3]{\cellcolor{skillbackground}\usekomafont{skilllabel}#1 & \skillrule{#2}{#3} \\}

%-----------------------------------------------------------
% Outdated but maybe inspiring when changing the layout
%-----------------------------------------------------------

% \newenvironment{events}{\begin{tabularx}{\linewidth}{rX}}{\end{tabularx}}
%\newenvironment{languages}{\begin{tabular}{lll}}{\end{tabular}}
%\newcommand*{\skillrule}[2]{
%{\color{#2}\rule[\baselineskip]{#1\linewidth}{\skillrulewidth}}
%}

%\newcommand*{\skill}[3]{\cellcolor{skillbackground}\usekomafont{skilllabel}#1 & \skillrule{#2}{#3} \\}
%\newcommand*{\skill}[3]{\colorbox{skillbackground}{\usekomafont{skilllabel}#1} & \skillrule{#2}{#3} \\}
%\newcommand*{\skill}[3]{\usekomafont{skilllabel}#1 & \skillrule{#2}{#3} \\}
%\newcommand*{\languageskill}[4]{\cellcolor{skillbackground}\usekomafont{skilllabel}#1 & #2 & \skillrule{#3}{#4} \\}    

%-----------------------------------------------------------
% Command to set PDF metadata
%-----------------------------------------------------------

\newcommand*{\setmetadata}{
	\hypersetup{
		pdftitle={\thetitle:~\theauthor},
		pdfsubject={\thetitle},
		pdfauthor={\theauthor},
		pdfkeywords={\thetitle, \theauthor}
	}
}