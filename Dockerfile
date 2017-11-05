FROM ubuntu
MAINTAINER Dejan Roshkovski (d.roshkovski@gmail.com)
RUN apt-get update
RUN apt-get install -y nginx vim wget curl git
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get update
RUN apt-get install nodejs -y
COPY myscript.sh /var/
COPY nginxconf /var/
RUN mkdir /var/apps/

RUN npm install -g express-generator
RUN npm install pm2 -g
EXPOSE 80 443

CMD /bin/bash /var/myscript.sh && nginx -g 'daemon off;'
