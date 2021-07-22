#!/bin/bash

set_config_files (){
	#Create symbolic link for .zsh
	if [ -f  ~/.zshrc ]
		then
			read -p "O arquivo .zshrc já existe. Deseja sobrescreve-lo [s/N]: " overwrite_bash
			if [ "$overwrite_bash" == "s" ]
				then
		rm -rf ~/.zshrc
		ln -r -s ./bash/zshrc ~/.zshrc
			fi
	else
		 rm -rf ~/.zshrc
		 ln -r -s ./bash/zshrc ~/.zshrc
	fi

	# Create symbolic link for init.vim

	if [ -f  ~/.config/nvim/init.vim ]
		then
			read -p "O arquivo init.vim já existe. Deseja sobrescreve-lo [s/N]: " overwrite_nvim
			if [ "$overwrite_nvim" == "s" ]
				then
		rm -rf ~/.config/nvim/init.vim
		ln -r -s ./vim/init.vim ~/.config/nvim/init.vim
			fi
	else
		rm -rf ~/.config/nvim/
		mkdir -p ~/.config/nvim/
		ln -r -s ./vim/init.vim ~/.config/nvim/init.vim
	fi

	if [ -f  ~/.vimrc ]
		then
			read -p "O arquivo .vimrc já existe. Deseja sobrescreve-lo [s/N]: " overwrite_vim
			if [ "$overwrite_vim" == "s" ]
				then
		rm -rf ~/.vimrc
		ln -r -s ./vim/init.vim ~/.vimrc
			fi
	else
		rm -rf ~/.vimrc
		ln -r -s ./vim/init.vim ~/.vimrc
	fi
}


install_packages () {
  PACKAGES="git tree neovim curl papirus-icon-theme php apache2 mysql-server python3-pip python3-venv terminator redeclipse vlc redshift-gtk zsh"
  if which dnf 2>/dev/null
    then
      sudo dnf update -y && sudo dnf install $PACKAGES -y
  elif which apt 2>/dev/null
    then
      sudo apt update -y && sudo apt upgrade -y && sudo apt install $PACKAGES -y
  fi

	# Install Node
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs

	# Install Composer
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	sudo mv composer.phar /usr/local/bin/composer

	#install phpmyadmin
	wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip
	unzip phpMyAdmin-5.1.1-all-languages.zip
	rm phpMyAdmin-5.1.1-all-languages.zip
	mv phpMyAdmin-5.1.1-all-languages/ phpmyadmin
	sudo mv phpmyadmin /var/www/html/
}


set_theme () {
	# Set themes
	sudo cp -r ./theme/Sweet-Dark /usr/share/themes/
	# Set icons
	sudo cp -r ./theme/FossaCursors /usr/share/icons/
	
	# Set fonts
	sudo cp -r ./theme/hack-font/ /usr/share/fonts/
	sudo cp -r ./theme/operator-font/ /usr/share/fonts/
	# Create Terminator Folder and set theme
	mkdir ~/.config/terminator
	git clone https://github.com/dracula/terminator.git
	./terminator/install.sh
	rm -rf terminator/

	# Install papirus-folders
	wget -qO- https://git.io/papirus-folders-install | sh
	papirus-folders --color teal

	# Install Oh-my-zsh 
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	
	# Install Oh-my-zsh aditional plugins
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

ARGS="$*"
PKGS="--packages" 
THEMES="--themes"
ALL="--all"
CONFIG_TXT="Serão inseridos arquivos de configuração para: 
  > NeoVim  ==>  init.vim
  > ZSH    ==>  .zshrc
"
PKGS_TXT="Seu Sistema será atualizado e em seguida serão instalados: 
	> Git
	> Tree
	> NeoVim
	> Curl
	> Papirus Icon Theme
	> PHP
	> Apache
	> MySQL
	> PIP
	> Virtual Envs for Python
	> Terminator
	> Redeclipse
	> VLC
	> RedShift
	> ZSH
"

THEMES_TXT="Os seguintes temas serão instalados:
  > Sweet Dark
	> Fossa Cursors
  > Hack Font
	> Operator Font
"

cat ".banners/init"
if [[ "$ARGS" == *"$PKGS"*  ]]
	then
		echo "$CONFIG_TXT"
		echo "$PKGS_TXT"
		set_config_files
		install_packages
	
elif [[ "$ARGS" == *"$THEMES"*  ]]
	then
		echo "$CONFIG_TXT"
		echo "$THEMES_TXT"
		set_config_files
		set_theme

elif [[ "$ARGS" == *"$ALL"*  ]]
	then
		echo "$CONFIG_TXT"
		echo "$THEMES_TXT"
		echo "$PKGS_TXT"
		set_config_files
		install_packages
		set_theme
else
	echo "$CONFIG_TXT"
	set_config_files
fi

cat ".banners/done"
