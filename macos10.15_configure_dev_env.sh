#!/bin/bash

### Prerequisites

# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || exit 1

brew --version || exit 1

### Git

# Install
brew install git || exit 1

# Reload $PATH
export PATH="/usr/local/bin:$PATH" || exit 1

# Configure Git
git config --global user.name "$(read -r -p 'Enter your Git name: ' gitname && echo "${gitname}")"
git config --global user.email "$(read -r -p 'Enter your Git email: ' gitemail && echo "${gitemail}")"

git --version || exit 1
git config --list || exit 1

### Symfony CLI

# Download executable in local user folder
curl -sS https://get.symfony.com/cli/installer | bash || exit 1

# Move the executable in global bin directory in order to use it globally
sudo mv ~/.symfony/bin/symfony /usr/local/bin/symfony || exit 1

symfony -V || exit 1

### PHP 7.3

# Install
brew install php@7.3 || exit 1

# Replace default macOS PHP installation in $PATH
brew link php@7.3 --force || exit 1

# Reload $PATH
export PATH="/usr/local/opt/php@7.3/bin:$PATH" || exit 1

# Install extensions
pecl install xdebug || exit 1

# Make a backup of the config file
phpinipath=$(php -r "echo php_ini_loaded_file();") || exit 1
sudo cp "${phpinipath}" "$(dirname "${phpinipath}")/.php.ini.backup" || exit 1

# Update some configuration in php.ini
sudo sed -i'.tmp' -e 's/post_max_size = 8M/post_max_size = 64M/g' "${phpinipath}" || exit 1
sudo sed -i'.tmp' -e 's/upload_max_filesize = 8M/upload_max_filesize = 64M/g' "${phpinipath}" || exit 1
sudo sed -i'.tmp' -e 's/memory_limit = 128M/memory_limit = -1/g' "${phpinipath}" || exit 1
sudo sed -i'.tmp' -e 's/display_errors = Off/display_errors = On/g' "${phpinipath}" || exit 1
sudo sed -i'.tmp' -e 's/display_startup_errors = Off/display_startup_errors = On/g' "${phpinipath}" || exit 1
sudo sed -i'.tmp' -e 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' "${phpinipath}" || exit 1

# Remove temporary file
sudo rm "${phpinipath}.tmp" || exit 1

php -v || exit 1
php -m || exit 1

### Composer 1.9

# Download installer
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" || exit 1

# Install
sudo php composer-setup.php --version=1.9.1 --install-dir=/usr/local/bin/ || exit 1

# Remove installer
sudo php -r "unlink('composer-setup.php');" || exit 1

# Make it executable globally
sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer || exit 1

composer -V || exit 1

### MariaDB 10.4

# Install
brew install mariadb@10.4 || exit 1

# Start MariaDB
sudo brew services start mariadb || exit 1

sudo mysql -e "SELECT VERSION();" || exit 1

### NodeJS 12

# Install
brew install node@12 || exit 1

# Add node to $PATH
sudo brew link node@12 --force || exit 1

node -v || exit 1
npm -v || exit 1

### Yarn 1.21

# Install
curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.21.1 || exit 1

# Reload $PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" || exit 1

yarn -v || exit 1
