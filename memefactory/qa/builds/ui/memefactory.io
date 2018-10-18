server {
  listen 80 default_server;
  server_name localhost ec2-35-160-97-136.us-west-2.compute.amazonaws.com www.ec2-35-160-97-136.us-west-2.compute.amazonaws.com;

  set $peer_id QmRawkiqLRLG1yzcSK3dcZ3uaAwM2nSLuMjiiNRK3i9HEj;
             # QmaGffUknWjnKKar9WjSNZHroxXwtZTUB3ARBh8jUZNaos;

  location ~ /(contracts|images|js|css|fonts|assets)(.*)$ {
    rewrite /(contracts|images|js|css|fonts|assets)(.*) /ipns/$peer_id/$1$2 break;
    try_files $uri @ipfs;
  }

  location / {
    rewrite /(.*) /ipns/$peer_id/ break;
    try_files $uri @ipfs;
  }

  location = /X0X.html {
    root /usr/share/nginx/html/;
    internal;
  }

  location @ipfs {
    proxy_intercept_errors on;
#    proxy_pass http://ipfs.io;
   proxy_pass http://qa_ipfs:8080;

    # DEBUG header
#   add_header X-Ipfs-Url $ipfs_url;

  }

   # redirect server error pages to the static error page
  error_page 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 420 422 423 424 426 428 429 431 444 449 450 451 500 501 502 503 504 505 506 507 508 509 510 511 /X0X.html;

}