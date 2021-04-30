#!/usr/bin/env bash
#
# Setup Script for workstation/development
#
# Author: @linkavych
# Date: 2021-04
# Modified: N/A

set -e

#################
# System Update #
#################

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y 


#########################
# $HOME Directory Setup #
#########################
# Clear out folders I dont use
rmdir ~/Templates \
      ~/Pictures \
      ~/Videos \
      ~/Music \
      ~/Public

# Create new directories
mkdir -p ~/dev/scapy \
         ~/dev/nornir \
         ~/bin \
         ~/opt \
         ~/.ssh


############
# Dotfiles #
############
git clone https://github.com/Linkavych/dotfiles.git ~/opt/dotfiles

# Backup original bashrc
mv .bashrc .bashrc.bak

# Symlink the relevant dot files
ln -s ~/opt/dotfiles/bashrc ~/.bashrc
ln -s ~/opt/dotfiles/vimrc ~/.vimrc
ln -s ~/opt/dotfiles/gitconfig ~/.gitconfig
ln -s ~/opt/dotfiles/tmux.conf  ~/.tmux.conf
ln -s ~/opt/dotfiles/aliases ~/.aliases
ln -s ~/opt/dotfiles/gitmessage ~/.gitmessage

# Making things non-interactive now
export DEBIAN_FRONTEND=noninteractive


##################################
# Main Utilities and Other Items #
##################################
sudo apt-get install -y \
    bash-completion \
    build-essential \
    cmake \
    cpufrequtils \
    default-jdk \
    flameshot \
    fonts-powerline \
    gnome-tweak-tool \
    golang \
    graphviz \
    htop \
    imagemagick \
    make \
    mlocate \
    mono-complete \
    neofetch \
    nmap \
    nodejs \
    npm \
    openssh-server \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-venv \
    socat \
    tcpdump \
    tlp \
    tlp-rdw \
    tmux \
    tree \
    vim \
    vlc \
    xclip \
    xsel 


#############
# Wireshark #
#############
sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update -y
sudo apt install wireshark tshark -y


########
# RUST #
########
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y


#########
# Fonts #
#########
# Hack Font
mkdir ~/fonts
cd ~/fonts
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip Hack-v3.003-ttf.zip
sudo mv ttf/ /usr/share/fonts/truetype/hack

# Fantasque Mono font
wget https://github.com/belluzj/fantasque-sans/releases/download/v1.8.0/FantasqueSansMono-Normal.zip
unzip FantasqueSansMono-Normal.zip
sudo mv OTF/ /usr/share/fonts/opentype/FantasqueSansMono
sudo mv TTF/ /usr/share/fonts/truetype/FantasqueSansMono
cd ~

# Remove the font folder
rm -rf ~/fonts

# Update Font Cache
sudo fc-cache -f -v


###############
# Vim Plugins #
###############
# Get Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Other Plugins
git clone https://github.com/sainnhe/gruvbox-material.git ~/.vim/bundle/gruvbox-material
git clone https://github.com/scrooloose/nerdtree ~/.vim/bundle/nerdtree
git clone https://github.com/scrooloose/syntastic ~/.vim/bundle/syntastic
git clone https://github.com/valloric/youcompleteme ~/.vim/bundle/youcompleteme


# Build YouCompleteMe
cd ~/.vim/bundle/youcompleteme
git submodule update --init --recursive
python3 ~/.vim/bundle/youcompleteme/install.py --all
cd ~


#############
# Powerline #
#############
sudo python3 -m pip install powerline-status
sudo python3 -m pip install powerline-gitstatus

mkdir -p ~/.config/powerline/themes/shell
mkdir -p ~/.config/powerline/colorschemes

ln -s ~/opt/dotfiles/powerline_color_default.json ~/.config/powerline/colorschemes/default.json
ln -s ~/opt/dotfiles/powerline_themes_shell_default.json ~/.config/powerline/themes/shell/default.json

sudo cp ~/opt/dotfiles/powerline_color_default.json /usr/local/lib/python3.8/dist-packages/powerline/config_files/colorschemes/default.json --force
sudo cp ~/opt/dotfiles/powerline_themes_shell_default.json /usr/local/lib/python3.8/dist-packages/powerline/config_files/themes/shell/default.json --force


#########
# Scapy #
#########
# Create a virtual environment then install
python3 -m venv ~/dev/scapy/
cd ~/dev/scapy
source bin/activate
git clone https://github.com/secdev/scapy.git
cd scapy
python3 setup.py install
python3 -m pip install matplotlib cryptography 
deactivate
cd ~


##########
# Nornir #
##########
# Create a virtual environment then install
python3 -m venv ~/dev/nornir
cd ~/dev/nornir
source bin/activate
python3 -m pip install nornir
deactivate
cd ~


###################
# UFW Basic Setup #
###################
sudo ufw enable
sudo ufw allow ssh


############
# Finished #
############
echo "[+] Script is complete!"
echo "[+] Enjoy!"
echo
