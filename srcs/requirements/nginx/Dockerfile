#image OS
FROM debian:buster

#install nginx and openssl
RUN apt update -y && apt install nginx -y && apt install openssl -y

#generate and store ssl certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 \
		-out /etc/nginx/ssl/nginx.crt \
		-keyout /etc/nginx/ssl/nginx.key \
		-subj "/C=ES/ST=Madrid/L=Madrid/O=42 School/OU=42 Madrid/CN=vipalaci"

#nginx config
RUN mkdir -p /var/run/nginx
COPY ./conf/inception.conf /etc/nginx/conf.d

EXPOSE 443

#run nginx on the foreground
CMD ["nginx", "-g", "daemon off;"]