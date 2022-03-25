echo "Installing zsh dependencies..."

rm -rf  "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" || true
rm /Users/sergio/.oh-my-zsh/custom/themes/spaceship.zsh-theme || true

git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

exit 0
