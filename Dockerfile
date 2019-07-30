FROM ubuntu:18.04

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装 nginx 和 php
RUN apt update && apt install -y nginx \
php php-bcmath php-bz2 php-curl php-dom php-gd php-mbstring php-mysqli php-xml php-zip php-fpm \
composer \
supervisord

COPY nginx.conf /etc/nginx/sites-avalible/default
COPY supervisord /etc/supervisord.conf

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]