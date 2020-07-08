# sudo user
sudo cat /etc/sudoers | grep "$USER ALL=NOPASSWD: ALL"
if [ 0 != $? ] ; then
   sudo sed -i -e '$a '$USER' ALL=NOPASSWD: ALL' /etc/sudoers
fi


# update and upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# install
sudo apt install -y ssh vim git net-tools curl wget tree jq ethtool
# ethtool(WOL)
sudo /sbin/ethtool -s enp4s0 wol g


# デフォルトエディタ変更
sudo update-alternatives --set editor /usr/bin/vim.basic

# Timeshiftインストール
sudo add-apt-repository ppa:teejee2008/ppa
sudo apt update
sudo apt install -y timeshift



