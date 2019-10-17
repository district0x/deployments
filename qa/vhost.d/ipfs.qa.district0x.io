client_max_body_size 2M;

error_log /var/log/nginx/error.log notice;
rewrite_log on;

# meme with reg-entry/address 0xc135d151b3bbdcc143a372f7040da3129a2756a9 has broken image hash baked into it, this is a hotfix rule:
rewrite ^(/gateway/ipfs/QmcTSZSK8q6aaN86sQGsv57PLGvriypQEoQmt8dWw1iwoz/examplememe0.png)$ https://ipfs.qa.district0x.io/gateway/ipfs/QmcTSZSK8q6aaN86sQGsv57PLGvriypQEoQmt8dWw1iwoz/ permanent;

location ^~ /.well-known/acme-challenge/ {
    auth_basic off;
    auth_request off;
    allow all;
    root /usr/share/nginx/html;
    try_files $uri =404;
    break;
}
