# The PHP/Symfony dev instructions kit for macOS

**This repository is part of the [symfony-dev-deploy](https://github.com/RomainFallet/symfony-dev-deploy) repository.**

![Test dev env install script](https://github.com/RomainFallet/symfony-dev-macos/workflows/Test%20dev%20env%20install%20script/badge.svg)

The purpose of this repository is to provide instructions to configure a PHP/Symfony development environment on **macOS 10.15**.

The goal is to provide an opinionated, fully tested environment, that just work.

These instructions are also available for [Windows](https://github.com/RomainFallet/symfony-dev-windows) and [Ubuntu](https://github.com/RomainFallet/symfony-dev-ubuntu).

## Table of contents

* [Important notice](#important-notice)
* [Quickstart](#quickstart)
* [Manual configuration](#manual-configuration)
    1. [Prerequisites](#prerequisites)
    2. [Git](#git)
    3. [Symfony CLI](#symfony-cli)
    4. [PHP 7.3](#php-73)
    5. [Composer 1.9](#composer-19)
    6. [MariaDB 10.4](#mariadb-104)
    7. [NodeJS 12](#nodejs-12)
    8. [Yarn 1.21](#yarn-121)

## Important notice

Configuration script for dev environment is meant to be executed after a fresh installation of the OS.

Its purpose in not to be bullet-proof neither to handle all cases. It's  just here to get started quickly as it just executes the exact same commands listed in "manual configuration" section.

**So, if you have any trouble a non fresh-installed machine, please use "manual configuration" sections to complete your installation environment process.**

## Quickstart

[Back to top ↑](#table-of-contents)

```bash
# Get and execute script directly
bash -c "$(curl -L -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/RomainFallet/symfony-dev-macos/master/macos10.15_configure_dev_env.sh)"
```

*See [manual instructions](#manual-configuration) for details.*

## Manual configuration

### Prerequisites

[Back to top ↑](#table-of-contents)

![homebrew](https://user-images.githubusercontent.com/6952638/70372309-a0a18380-18dd-11ea-8280-e86e84f51043.png)

On MacOS, there is no package manager by default. We need to install the Homebrew package manager in order to install our packages.

Open the Terminal app and type:

```bash
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Git

[Back to top ↑](#table-of-contents)

![git](https://user-images.githubusercontent.com/6952638/71176962-3a1c4e00-226b-11ea-83a1-5a66bd37a68b.png)

```bash
# Install
brew install git

# Reload $PATH
export PATH="/usr/local/bin:$PATH"
```

### Symfony CLI

[Back to top ↑](#table-of-contents)

![symfony](https://user-images.githubusercontent.com/6952638/71176964-3ab4e480-226b-11ea-8522-081106cbff50.png)

```bash
# Download executable in local user folder
curl -sS https://get.symfony.com/cli/installer | bash

# Move the executable in global bin directory in order to use it globally
sudo mv ~/.symfony/bin/symfony /usr/local/bin/symfony
```

### PHP 7.3

[Back to top ↑](#table-of-contents)

![php](https://user-images.githubusercontent.com/6952638/70372327-bca52500-18dd-11ea-8638-7cdab7c5d6e0.png)

```bash
# Install
brew install php@7.3

# Replace default macOS PHP installation in $PATH
brew link php@7.3 --force

# Reload $PATH
export PATH="/usr/local/opt/php@7.3/bin:$PATH"

# Install extensions
pecl install xdebug

# Make a backup of the config file
phpinipath=$(php -r "echo php_ini_loaded_file();")
sudo cp "${phpinipath}" "$(dirname "${phpinipath}")/.php.ini.backup"

# Update some configuration in php.ini
sudo sed -i'.tmp' -e 's/post_max_size = 8M/post_max_size = 64M/g' "${phpinipath}"
sudo sed -i'.tmp' -e 's/upload_max_filesize = 8M/upload_max_filesize = 64M/g' "${phpinipath}"
sudo sed -i'.tmp' -e 's/memory_limit = 128M/memory_limit = -1/g' "${phpinipath}"
sudo sed -i'.tmp' -e 's/display_errors = Off/display_errors = On/g' "${phpinipath}"
sudo sed -i'.tmp' -e 's/display_startup_errors = Off/display_startup_errors = On/g' "${phpinipath}"
sudo sed -i'.tmp' -e 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' "${phpinipath}"

# Remove temporary file
sudo rm "${phpinipath}.tmp"

**Installed PHP Modules:** bcmath, bz2, calendar, Core, ctype, curl, date, dba, dom, exif, fileinfo, filter, ftp, gd, gettext, gmp, hash, iconv, intl, json, ldap, libxml, mbstring, mysqli, mysqlnd, odbc, openssl, pcntl, pcre, PDO, pdo_dblib, pdo_mysql, PDO_ODBC, pdo_pgsql, pdo_sqlite, pgsql, Phar, phpdbg_webhelper, posix, pspell, readline, Reflection, session, shmop, SimpleXML, soap, sockets, sodium, SPL, sqlite3, standard, sysvmsg, sysvsem, sysvshm, tidy, tokenizer, wddx, xdebug, xml, xmlreader, xmlrpc, xmlwriter, xsl, Zend OPcache, zip, zlib

**Installed Zend Modules:** Xdebug, Zend OPcache

### Composer 1.9

[Back to top ↑](#table-of-contents)

![composer](https://user-images.githubusercontent.com/6952638/70372308-a008ed00-18dd-11ea-9ee0-61d017dfa488.png)

```bash
# Download installer
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

# Install
sudo php composer-setup.php --version=1.9.1 --install-dir=/usr/local/bin/

# Remove installer
sudo php -r "unlink('composer-setup.php');"

# Make it executable globally
sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer
```

### MariaDB 10.4

[Back to top ↑](#table-of-contents)

![mariadb](https://user-images.githubusercontent.com/6952638/71176963-3a1c4e00-226b-11ea-9627-e64caabef009.png)

```bash
# Install
brew install mariadb@10.4

# Start MariaDB
brew services start mariadb
```

### NodeJS 12

[Back to top ↑](#table-of-contents)

![node](https://user-images.githubusercontent.com/6952638/71177167-a4cd8980-226b-11ea-9095-c96d5b96faa7.png)

```bash
# Install
brew install node@12

# Add node to $PATH
brew link node@12 --force
```

### Yarn 1.21

[Back to top ↑](#table-of-contents)

![yarn](https://user-images.githubusercontent.com/6952638/70372314-a13a1a00-18dd-11ea-9cdb-7b976c2beab8.png)

```bash
# Install
curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.21.1

# Reload $PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
```
