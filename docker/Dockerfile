FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo
RUN apt-get update && apt-get install wget tzdata apache2 php php-cli php-common php-zip php-mysql php-gd php-curl php-imap php-mbstring php-xml php-json libapache2-mod-php unzip libpcre3 -y && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 6M/g" /etc/php/7.4/apache2/php.ini && wget https://suitecrm.com/files/147/SuiteCRM-8.1/627/SuiteCRM-8.1.2.zip && mv SuiteCRM-8.1.2.zip /var/www/html/
WORKDIR /var/www/html
ADD suitecrm.conf /etc/apache2/sites-available/
ADD entrypoint.sh /
RUN unzip SuiteCRM-8.1.2.zip && find . -type d -not -perm 2755 -exec chmod 2755 {} \; && find . -type f -not -perm 0644 -exec chmod 0644 {} \; && find . ! -user www-data -exec chown www-data:www-data {} \; && chmod +x bin/console && rm SuiteCRM-8.1.2.zip && rm /etc/apache2/sites-available/000* && chmod 775 /entrypoint.sh && a2ensite suitecrm.conf && a2enmod rewrite
EXPOSE 80
CMD ["/entrypoint.sh"]
