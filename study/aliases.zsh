# Limarka
alias limarka_build='docker build -t limarka:customizada $@ - < Dockerfile'
alias limarka='docker run --mount src="$(pwd)",target=/trabalho,type=bind limarka:customizada $@'
alias limarka_guard='docker run -it --entrypoint guard --mount src=`pwd`,target=/trabalho,type=bind limarka:customizada --no-bundler-warning $@'
# alias limarka_exec='limarka exec -y -o ./output && open ./output/xxx-Monografia-projeto.pdf'
# alias limarka_exec='limarka exec --configuracao_yaml && open ./xxx-Monografia-projeto.pdf'
alias limarka_exec='rm ./output/xxx-Monografia-projeto.pdf; limarka exec -y -o ./output && open ./output/xxx-Monografia-projeto.pdf'

# Pandoc
pandoc_pdf() {
  pandoc --template eisvogel --listings $1 -o $2
  open $2
}

pandoc_toc_pdf() {
  pandoc --toc --template eisvogel --listings $1 -o $2
  open $2
}

pandoc_touch() {
  touch $1
  cat ~/.dotfiles/study/template.md > $1
}
