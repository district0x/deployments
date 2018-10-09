FROM district0x/base:latest
MAINTAINER "Filip Bielejec" <filip@district0x.io>

# copy update script
#ADD update.sh /usr/bin/update.sh
#RUN chmod a+x /usr/bin/update.sh

# install nginx
RUN apt-get update -y \
    && apt-get install --no-install-recommends -y \
    -q nginx

# setup error page
RUN wget --no-check-certificate -O X0X.html https://raw.githubusercontent.com/district0x/X0X/master/X0X.html \
  && mv X0X.html /usr/share/nginx/html/X0X.html

# setup server config
ADD memefactory.io /etc/nginx/sites-available/memefactory.io
RUN ln -s -f /etc/nginx/sites-available/memefactory.io /etc/nginx/sites-enabled/memefactory.io

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
