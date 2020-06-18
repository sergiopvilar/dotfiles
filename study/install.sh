#!/usr/bin/env bash

if [ "$(uname)" == "Linux" ]; then
  sudo apt-get install pandoc -y
  wget -qO- "https://yihui.org/gh/tinytex/tools/install-unx.sh" | sh
fi

tlmgr install footnotebackref adjustbox babel-german background bidi collectbox csquotes everypage filehook \
      footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor sourcecodepro \
      sourcesanspro titling ucharcat ulem unicode-math upquote xecjk xurl zref babel-portuges setspace koma-script \
      colortbl listings caption fancyhdr bookmark

mkdir ~/.pandoc
mkdir ~/.pandoc/templates

if [ -d "$HOME/.pandoc/templates" ]; then
  echo "Pandoc already installed"
else
  git clone git@github.com:Wandmalfarbe/pandoc-latex-template.git
  mv pandoc-latex-template/eisvogel.tex ~/.pandoc/templates/eisvogel.latex

  rm -rf pandoc-latex-template
fi

