export DEBIAN_FRONTEND=noninteractive

# sudo user
sudo grep 'user ALL=NOPASSWD: ALL' /etc/sudoers >/dev/null
if [ $? -ne 0 ]; then
   sudo sed -i -e '$ a user ALL=NOPASSWD: ALL' /etc/sudoers
fi

# root password
echo "root:user" | sudo chpasswd


# os update
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# pkg install
sudo apt update; sudo apt install -y curl gnupg2 ca-certificates lsb-release
echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -

sudo apt update
sudo apt install nginx -y

# ssh root
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# reboot
sudo reboot
