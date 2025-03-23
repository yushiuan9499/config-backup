!/bin/bash
# This is the script to install zsh, oh-my-zsh, and some other plugins
# Author: yushiuan9499 date: 2025-03-23
sudo apt update
sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Download my config file
cd ~/.config
git clone git@github.com:yushiuan9499/config-backup.git
mv config-backup/* .
mv config-backup/.* .
rmdir config-backup

# Create symbolic link
ln -s -T ~/.config/.zshrc ~/.zshrc
ln -s -T ~/.config/.vimrc ~/.vimrc
