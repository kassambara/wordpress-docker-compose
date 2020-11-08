FROM wordpress:cli

# Install make tool
USER root
RUN apk add --no-cache make

# Make docker-compose wait for container dependencies be ready
# Add the wait script to the image
ENV WAIT_VERSION 2.7.2
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

# Add Makefile to scripts dir
ADD Makefile entrypoint.sh /scripts/
RUN chmod +x /scripts/entrypoint.sh

ENTRYPOINT [ "/scripts/entrypoint.sh" ]
USER 33:33
CMD ["wp", "shell"]

FROM php:7.0-apache
COPY . /var/www/html/
EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]