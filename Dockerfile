FROM debian
MAINTAINER Ivan Hahanov <hahanov.i@explabs.ru>
ADD debian.list /etc/apt/sources.list.d/
RUN apt-get update && \
    apt-get -y upgrade && \
    apt -y install nginx && \
    apt-get clean && \
    rm -rf /var/www/* && \ 
    mkdir -p /var/www/explabs.com/img && \
    chmod -R 754 /var/www/explabs.com/ && \
    useradd admin && \
    usermod -aG admin admin && \
    chown -R admin:admin /var/www/explabs.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/explabs.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user admin/g' /etc/nginx/nginx.conf
ADD index.html /var/www/explabs.com/
ADD img.jpg /var/www/explabs.com/img/
CMD ["nginx", "-g", "daemon off;"]
