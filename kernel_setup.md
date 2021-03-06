
### 設定内容

```bash
# vim /etc/sysctl.conf
```

```
# 共有メモリの最大サイズ。サーバーの搭載メモリ(1GB)に合わせて変更
#kernel.shmmax      = 1073741824

# システム全体の共有メモリ・ページの最大数
kernel.shmall      = 262144

# システム全体のプロセス数の上限
kernel.threads-max = 1060863

# システム全体のファイルディスクリプタの上限
fs.file-max        = 5242880

# RFC1323のTCPウィンドウ スケーリングを有効にする。
# 64K以上のTCP windowを使えるようになる。
# 巨大なファイルを転送する時に問題になった場合は無効にすると解決されることもある。
net.ipv4.tcp_window_scaling = 1

# 受信用ウィンドウ・サイズの最大値。
net.core.rmem_max = 16777216
# 送信用ウィンドウ・サイズの最大値。
net.core.wmem_max = 16777216
# データ受信バッファ サイズ
net.ipv4.tcp_rmem = 4096 349520 16777216

# データ送信バッファ サイズ
net.ipv4.tcp_wmem = 4096 65536 16777216

# TCPソケットが受け付けた接続要求を格納するキューの最大長
net.core.somaxconn=4096

# カーネルがキューイング可能なパケットの最大個数
net.core.netdev_max_backlog=4096

# ソケット当たりのSYNを受け付けてACKを受け取っていない状態のコネクションの保持可能数
net.ipv4.tcp_max_syn_backlog=4096

# ネットワークのルート・メトリクスの保持を無効化する。
net.ipv4.tcp_no_metrics_save=1

# スプーフィング対策 送信元IPの偽装防止
net.ipv4.conf.all.rp_filter = 1


# RFC1337に準拠させる。
# TIME_WAIT状態のときにRSTを受信した場合、TIME_WAIT期間の終了を待たずにそのソケットをクローズする
net.ipv4.tcp_rfc1337 = 1

# SYN flood攻撃対策。
net.ipv4.tcp_syncookies = 1


# OOM killer 対策
# メモリオーバーコミットを無効
vm.overcommit_memory = 2

# mallocにより確保するメモリ量の上限(%)を指定
vm.overcommit_ratio = 99

# kernel panicで自動再起動
kernel.panic=30

# OOM killer 発動した場合は kernel panicを起こして再起動させる
vm.panic_on_oom=1


# TCP/IPの送信用ポート範囲の変更
net.ipv4.ip_local_port_range = 1024 65535


# TCP: time wait bucket table overflow の解消とTIME_WAITを減らすチューニング
# tcp_tw_recycle
net.ipv4.tcp_tw_recycle = 1

# TIME_OUT 状態のコネクションを再利用
net.ipv4.tcp_tw_reuse = 1

# FIN-WAIT2からTIME_WAITに遷移する時間の設定(秒)
net.ipv4.tcp_fin_timeout = 10

# NAT/Softbank携帯対策。tcp_timestamps を無効にする。
net.ipv4.tcp_timestamps = 0


# CLOSE_WAITを減らす対策
# アイドル接続状態のTCP接続に対し検査する頻度
net.ipv4.tcp_keepalive_time = 10

# TCP/IP が、既存の接続で応答されていないキープアライブ・メッセージを再送する回数
net.ipv4.tcp_keepalive_probes = 2

# 相手側からのキープアライブ応答から受信されない場合に、TCP/IP がキープアライブ送信を繰り返す頻度
net.ipv4.tcp_keepalive_intvl = 3
上記設定を/etc/sysctl.confに保存の上、書きコマンドで設定を反映します。
```

```bash
# sysctl -p
```




```

カーネル(ソート済み)
要調査
fs.file-max        = 5242880
kernel.panic       =30
kernel.shmall      = 262144
kernel.threads-max = 1060863
net.core.netdev_max_backlog=4096
net.core.rmem_max = 16777216
net.core.somaxconn=4096
net.core.wmem_max = 16777216
net.ipv4.conf.all.rp_filter = 1
net.ipv4.ip_local_port_range = 1024 65535
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_keepalive_intvl = 3
net.ipv4.tcp_keepalive_probes = 2
net.ipv4.tcp_keepalive_time = 10
net.ipv4.tcp_max_syn_backlog=4096
net.ipv4.tcp_no_metrics_save=1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_rmem = 4096 349520 16777216
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_wmem = 4096 65536 16777216
vm.overcommit_memory = 2
vm.overcommit_ratio = 99
vm.panic_on_oom=1

```
