# sudo user
# sedで最終行に書き込み
# /etc/sudoers
# <user> ALL=NOPASSWD: ALL

# update and upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# install
sudo apt install -y ssh vim git net-tools 
# vim apt-utils vim git net-tools wget ssh curl
# ethtool(WOL)

# GPU driver
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update -y
sudo apt-get -y install cuda

# git init
# git config --global credential.helper store
# git config --global user.email "szk@usisi.net"
# git config --global user.name "szkusisi"

# tool
# gitauto
# sudo cp bin/gitauto /usr/local/bin/

# デフォルトエディタ変更
sudo update-alternatives --set editor /usr/bin/vim.basic

# Timeshiftインストール
sudo add-apt-repository ppa:teejee2008/ppa
sudo apt update
sudo apt install -y timeshift

