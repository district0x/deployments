FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# install nginx
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q nginx

# replace nginx config
ADD nginx.conf /etc/nginx/nginx.conf

# setup error page
RUN wget --no-check-certificate -O X0X.html https://raw.githubusercontent.com/district0x/X0X/master/X0X.html \
  && mv X0X.html /usr/share/nginx/html/X0X.html

# replace default server
ADD default /etc/nginx/sites-available/default

# setup server config
ADD ipfs.api /etc/nginx/sites-available/ipfs.api
RUN ln -s -f /etc/nginx/sites-available/ipfs.api /etc/nginx/sites-enabled/ipfs.api

EXPOSE 5001
CMD ["nginx", "-g", "daemon off;"]
