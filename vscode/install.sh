#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
  rm /Users/sergio/Library/Application\ Support/Code/User/settings.json
  ln -s /Users/sergio/.dotfiles/vscode/settings.json /Users/sergio/Library/Application\ Support/Code/User/settings.json

  code --install-extension 74th.monokai-charcoal-high-contrast
  code --install-extension 74th.Theme-NaturalContrast-With-HC
  code --install-extension CraigMaslowski.erb
  code --install-extension AndrsDC.base16-themes
  code --install-extension arcticicestudio.nord-visual-studio-code
  code --install-extension be5invis.vscode-icontheme-nomo-dark
  code --install-extension bmaupin.theme-solarized-dark-high-contrast
  code --install-extension bung87.rails
  code --install-extension bung87.vscode-gemfile
  code --install-extension castwide.solargraph
  code --install-extension christian-kohler.path-intellisense
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension dracula-theme.theme-dracula
  code --install-extension HookyQR.beautify
  code --install-extension ionutvmi.spacegray-vscode
  code --install-extension jolaleye.horizon-theme-vscode
  code --install-extension juliettepretot.lucy-vscode
  code --install-extension leizongmin.node-module-intellisense
  code --install-extension mikemcbride.electron-highlighter
  code --install-extension mikestead.dotenv
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension MS-CEINTL.vscode-language-pack-pt-BR
  code --install-extension ms-vscode.sublime-keybindings
  code --install-extension PKief.material-icon-theme
  code --install-extension qinjia.seti-icons
  code --install-extension rebornix.ruby
  code --install-extension robinbentley.sass-indented
  code --install-extension rprouse.theme-obsidian
  code --install-extension sianglim.slim
  code --install-extension sugarpirate.theme-tinacious-contrast
  code --install-extension teabyii.ayu
  code --install-extension vayan.haml
  code --install-extension waderyan.gitblame
  code --install-extension whizkydee.material-palenight-theme
  code --install-extension zhuangtongfa.Material-theme
  code --install-extension Zignd.html-css-class-completion
fi
