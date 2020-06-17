sudo tlmgr install collection-fontsrecommended footnotebackref adjustbox babel-german background bidi collectbox csquotes \
      everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace \
      pagecolor sourcecodepro sourcesanspro titling ucharcat ulem unicode-math upquote xecjk xurl zref

mkdir ~/.pandoc
mkdir ~/.pandoc/templates

git clone git@github.com:Wandmalfarbe/pandoc-latex-template.git
mv pandoc-latex-template/eisvogel.tex ~/.pandoc/templates/eisvogel.latex

rm -rf pandoc-latex-template
