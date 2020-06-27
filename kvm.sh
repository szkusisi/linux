sudo apt install -y qemu-kvm libvirt0 libvirt-bin \
  virt-manager libguestfs-tools

INTERFACE=enp4s0
sudo apt install -y bridge-utils
 sudo tee /etc/network/interfaces <<EOF >/dev/null
auto lo
iface lo inet loopback
auto br0
iface br0 inet dhcp
      bridge_ports ${INTERFACE}
      bridge_stp off
      bridge_maxwait 0
EOF
