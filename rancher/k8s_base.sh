export DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

sudo apt install git curl

sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y

sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

ssh-keygen -b 4096
ssh-copy-id root@localhost


# Docker Install
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo usermod -aG docker $USER


