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

# nginx
sudo apt install nginx -y

sudo tee /etc/nginx/nginx.conf  > /dev/null << 'EOF'
worker_processes 4;
worker_rlimit_nofile 40000;

events {
    worker_connections 8192;
}

stream {
    upstream rancher_servers_http {
        least_conn;
        server master01:80 max_fails=3 fail_timeout=5s;
        server master02:80 max_fails=3 fail_timeout=5s;
        server master03:80 max_fails=3 fail_timeout=5s;
    }
    server {
        listen     80;
        proxy_pass rancher_servers_http;
    }

    upstream rancher_servers_https {
        least_conn;
        server master01:443 max_fails=3 fail_timeout=5s;
        server master02:443 max_fails=3 fail_timeout=5s;
        server master03:443 max_fails=3 fail_timeout=5s;
    }
    server {
        listen     443;
        proxy_pass rancher_servers_https;
    }
}
EOF

# dns
sudo apt install bind9 -y

sudo tee -a/etc/bind/named.conf.options > /dev/null << 'EOF'
options {
	directory "/var/cache/bind";
	forwarders {
	 	8.8.8.8;
	};
        recursion yes;
};
EOF

sudo tee -a /etc/bind/named.conf.local > /dev/null << 'EOF'
zone "sample.com" {
        type master;
        file "/etc/bind/sample.com.zone";
};
EOF

sudo tee /etc/bind/sample.com.zone > /dev/null << 'EOF'
$TTL 86400
@ IN SOA lb.sample.com root.sample.com (
  2020100600
  3600
  900
  604800
  86400
)
          IN NS lb.sample.com.
lb        IN A  10.0.1.240
*         IN A  10.0.1.240
master01  IN A  10.0.1.211
master02  IN A  10.0.1.212
master03  IN A  10.0.1.213
worker01  IN A  10.0.1.221
worker02  IN A  10.0.1.222
worker03  IN A  10.0.1.223
EOF

# ssh root
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# sudo systemctl restart sshd

# reboot
sudo reboot
