export DEBIAN_FRONTEND=noninteractive

sudo grep 'user ALL=NOPASSWD: ALL' /etc/sudoers >/dev/null
if [ $? -ne 0 ]; then
   sudo sed -i -e '$ a user ALL=NOPASSWD: ALL' /etc/sudoers
fi

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

sudo apt install git curl

sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Kernel
sudo tee -a /etc/sysctl.d/99-kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Docker Install
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo usermod -aG docker $USER

# swap
sudo sed -i 's/^\/swapfile/#\/swapfile/g' /etc/fstab


