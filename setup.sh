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
ln -s ~/opt/dotfiles/git-completion.bash ~/.git-completion.bash
ln -s ~/opt/dotfiles/git-prompt.sh ~/.git-prompt.sh
ln -s ~/opt/dotfiles/alacritty.yml ~/.config/alacritty.yml

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
    libfreetyp6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    make \
    mlocate \
    mono-complete \
    neofetch \
    nmap \
    nodejs \
    npm \
    openssh-server \
    pkg-config \
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


################
# TMUX Plugins #
################
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Other TMUX Plugins in tmux.conf and are loaded when TMUX is ran the
# first time with C-a + I


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

#####################
#		    #
# Alacritty Install #
#		    #
#####################

cd ~/opt/
git clone https://github.com/alacritty/alacritty.git
cd ~/opt/alacritty
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
cd ~

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
echo "[+] Alacritty installed as default terminal!"

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
