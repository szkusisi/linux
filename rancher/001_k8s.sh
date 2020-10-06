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
sudo apt install git curl

# ssh root
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Kernel
sudo tee -a /etc/sysctl.d/99-kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# swap
sudo sed -i 's/^\/swap/#\/swap/g' /etc/fstab

# Docker Install
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo usermod -aG docker $USER

# reboot
sudo reboot
