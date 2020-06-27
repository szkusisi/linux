# update and upgrade
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# install
sudo apt install -y ssh vim git net-tools curl wget tree 
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



# Docker(Rancherのもの)ランタイムインストール
curl https://releases.rancher.com/install-docker/19.03.sh | sh
sudo usermod -aG docker $USER

# DockerのGPUランタイムインストール
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo apt-get install -y nvidia-container-runtime


# docker-compose
compose_version=$(curl https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
output='/usr/local/bin/docker-compose'
sudo curl -L https://github.com/docker/compose/releases/download/$compose_version/docker-compose-$(uname -s)-$(uname -m) -o $output
sudo chmod +x $output
echo $(docker-compose --version)

sudo tee /etc/docker/daemon.json <<EOF >/dev/null
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
sudo systemctl restart docker.service

# Docker動作確認
docker run --gpus all --rm nvidia/cuda nvidia-smi
docker-compose up -d
