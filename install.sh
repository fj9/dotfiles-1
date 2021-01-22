#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Set default MySQL root password and auth type.
#mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
#pecl install memcached imagick

# Install global Composer packages
# /usr/local/bin/composer global require laravel/installer laravel/spark-installer laravel/valet

# Install Laravel Valet
# $HOME/.composer/vendor/bin/valet install

# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Sites

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Removes .vimrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
# Install plugins 
vim +PluginInstall +qall
vim +call mkdp#util#install()


# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
