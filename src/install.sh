#!/bin/bash

# install ohmyzsh
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# POS-INSTALAÇÃO DO ZSH
#
#
# SpaceShip Theme
#	git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
#	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# 
# ZSH_Suggestions
#	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# 
# ZSH_syntaxhighlight
#	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


#Create symbolic link for .zsh
if [ -f  ~/.zshrc ]
	then
		read -p "O arquivo .zshrc já existe. Deseja sobrescreve-lo [s/N]: " overwrite_bash
		if [ "$overwrite_bash" == "s" ]
			then
	rm -rf ~/.zshrc
	ln -r -s ./zsh/zshrc ~/.zshrc
		fi
else
	 rm -rf ~/.zshrc
	 ln -r -s ./zsh/zshrc ~/.zshrc
fi

# Create symbolic link for init.vim

if [ -f  ~/.config/nvim/init.lua ]
	then
		read -p "O arquivo init.lua já existe. Deseja sobrescreve-lo [s/N]: " overwrite_nvim
		if [ "$overwrite_nvim" == "s" ]
			then
	rm -rf ~/.config/nvim/init.lua
	cp ./vim/init.lua ~/.config/nvim/init.lua
		fi
else
	rm -rf ~/.config/nvim/
	mkdir -p ~/.config/nvim/
	cp ./vim/init.lua ~/.config/nvim/init.lua
fi
