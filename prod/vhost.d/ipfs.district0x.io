client_max_body_size 2M;

error_log /var/log/nginx/error.log notice;
rewrite_log on;

# meme with reg-entry/address 0xc135d151b3bbdcc143a372f7040da3129a2756a9 has broken image hash baked into it, this is a hotfix rule:
rewrite ^(/gateway/ipfs/QmUuoXADyRvdNj8nFk3bqeVshDZ1wpyctjBaTwnhbCtww1/Penot.gif)$ https://ipfs.district0x.io/gateway/ipfs/QmUuoXADyRvdNj8nFk3bqeVshDZ1wpyctjBaTwnhbCtww1/ permanent;