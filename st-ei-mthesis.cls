%%% st-ei-mthesis.cls
%%% Created by gion-xy.

%%% ベースの設定
%% お約束
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{st-ei-mthesis}[2018/1/17 v0.2 yo.]

%% ユーザー指定のオプションを bxjsbook に渡す
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{bxjsreport}}
\ProcessOptions\relax

%% 既定オプションつきで bxjsbook をロード
\LoadClass[a4paper,twoside,openright,nomag,ja=standard]{bxjsreport}

%% 余白の設定
\setpagelayout{
  truedimen,
  ignoreall,
  nohead,
  top=25mm,
  bottom=30mm,
  footskip=15mm,
  inner=35mm,
  outer=20mm,
}

%% パッケージ
\usepackage{xparse}
\usepackage{pgffor}


%%% 日本語表紙・要旨
%% 情報を保存
\foreach \info in {year, title, author, supervisor, examiner, date, keywords} {
  \expandafter\xdef\csname j\info \endcsname##1%
  {\expandafter\gdef\csname mthesis@j\info \endcsname{##1}}
}

\NewDocumentCommand{\jmaketitle}{}{%
  \begingroup
  \mthesis@jmaketitle
  \endgroup
}
\def\mthesis@jmaketitle{%
  \thispagestyle{empty}
  \begin{center}
    {\Large \mthesis@jyear 年度~修士論文}%
    \vfill
    {\huge \textbf{\mthesis@jtitle}}%
    \vfill
    {\Large 群馬大学大学院理工学府~理工学専攻\\電子情報・数理教育プログラム}%
    \vspace{0.5cm}\par
    {\LARGE \mthesis@jauthor}%
    \vspace{2cm}\par
    {\Large 指導教員:~\mthesis@jsupervisor\\主査:~\mthesis@jexaminer}%
    \vspace{0.5cm}\par
    {\Large \mthesis@jdate}%
  \end{center}
  \cleardoublepage
}
%% \maketitle は \jmaketitle にフォールバック
\RenewDocumentCommand{\maketitle}{}{\jmaketitle}

%% 要旨
\NewDocumentEnvironment{jabstract}{O{論文要旨}}{%
  \pagenumbering{roman}
  \begin{center}
    {\Large \mthesis@jyear 年度\ 修士論文}%
    \vspace{0.5cm}\par
    {\huge \textbf{\mthesis@jtitle}}%
  \end{center}
  \section*{#1}
}{
  \ifdefined\mthesis@jkeywords
  \section*{キーワード}\mthesis@jkeywords \par
  \fi
  \vspace{2.5cm}\par
  {群馬大学大学院理工学府~理工学専攻~電子情報・数理教育プログラム}%
  \begin{flushright}
    \mthesis@jauthor
  \end{flushright}

  \cleardoublepage
}


\NewDocumentEnvironment{acknowledgement}{O{謝辞}}{%
  \addcontentsline{toc}{chapter}{#1}
  \chapter*{#1}
}{}
