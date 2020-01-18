### sudo vi /etc/rc.local
#### sudo chmod +x /ect/rc.local
##!/bin/sh -e
#
#IP=$(ip -4 route get 8.8.8.8 | awk {'print $7'}| tr -d '\n')
#Interface=$(ip -4 route get 8.8.8.8 | awk {'print $5'}| tr -d '\n')
#Gateway=$(ip -4 route get 8.8.8.8 | awk {'print $3'}| tr -d '\n')
#echo "$(tput setaf 3)\
#$(hostnamectl)\n\n\
#----------------------------------------------------\n\
#        IP Address: $IP\n\
#        Gateway IP: $Gateway\n\
#         Interface: $Interface\n\
#          Username: truocphan\n\
#          Password: TruocPhan\n\
#----------------------------------------------------\n\n\
#          Facebook: https://facebook.com/292706121240740\n\
#            E-mail: truocphan112017@gmail.com\n\
#            GitHub: https://github.com/truocphan\n\n\
#$(tput sgr0)" > /etc/issue
#exit 0


### Change Hostname
#sudo hostnamectl set-hostname TruocPhan-Server
#hostnamectl


#!/bin/sh
# Update and upgrade system
sudo apt update && sudo apt upgrade -y


sudo apt install -y openvpn git curl wget


# Install zsh
sudo apt install zsh powerline fonts-powerline -y
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cat > ~/.zshrc << EOL
# If you come from bash you might have to change your $PATH.
# export PATH=\$HOME/bin:/usr/local/bin:\$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/truocphan/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source \$ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:\$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n \$SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
EOL
chsh -s /bin/zsh


# Install nmap, sqlmap, smbmap
sudo apt install nmap, sqlmap, smbmap -y


# Install metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
./msfinstall
rm msfinstall


# Install searchsploit
sudo git clone https://github.com/offensive-security/exploitdb.git /opt/exploit-database
sudo ln -sf /opt/exploit-database/searchsploit /usr/local/bin/searchsploit
cp -n /opt/exploit-database/.searchsploit_rc ~/
export PATH=/usr/local/bin/searchsploit:$PATH


# Install Apache, MySQL, PHP
sudo apt-get install apache2 mysql-server php -y


# Install
git clone https://github.com/nahamsec/bbht.git
cd bbht
chmod +x install.sh
./install.sh
cd ~
export PATH=/usr/local/go/bin:$PATH
export PATH=~/go/bin:$PATH


# Install ffuf
go get github.com/ffuf/ffuf
