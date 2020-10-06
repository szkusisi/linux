export DEBIAN_FRONTEND=noninteractive

sudo grep 'user ALL=NOPASSWD: ALL' /etc/sudoers >/dev/null
if [ $? -ne 0 ]; then
   sudo sed -i -e '$ a user ALL=NOPASSWD: ALL' /etc/sudoers
fi

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y


# hosts作成


# key作成と転送
ssh-keygen -b 4096
#ssh-copy-id root@localhost
for NODE in lb01 master01 master02 master03 worker01 worker02 worker03; do
  ssh-copy-id root@$NODE
done


# RKE Install
curl -s https://api.github.com/repos/rancher/rke/releases/latest | grep download_url | grep amd64 | cut -d '"' -f 4 | wget -qi -
chmod +x rke_linux-amd64
sudo mv rke_linux-amd64 /usr/local/bin/rke
rke --version
rm -rf rke_darwin-amd64  rke_windows-amd64.exe


# HELM Install
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -rf  get_helm.sh


# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client



