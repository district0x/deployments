FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# get source code
# RUN wget --no-check-certificate -O master.zip https://github.com/district0x/memefactory/archive/master.zip \
#    && unzip master.zip \
#    && mv memefactory-master memefactory

# WORKDIR memefactory

# build ui
# RUN lein deps
# RUN lein cljsbuild once "dev-ui"

# TODO : ipfs publish

# TODO : nginx

# install nginx
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q nginx

# error page
RUN wget --no-check-certificate -O X0X.html https://raw.githubusercontent.com/district0x/X0X/master/X0X.html \
  && cp X0X.html /usr/share/nginx/html/X0X.html

# server config
ADD memefactory.io /etc/nginx/sites-available/memefactory.io
RUN ln -s -f /etc/nginx/sites-available/memefactory.io /etc/nginx/sites-enabled/memefactory.io

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
