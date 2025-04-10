#image OS
FROM debian:buster

#update packages and install nginx
RUN apt update -y && apt install -y nginx && apt install -y openssl

#auto-generate and store ssl certificate
RUN openssl req -x509 -nodes -days 365 \
	-subj "/C=ES/ST=Madrid/O=42Madrid, Inc./CN=vipalaci.42.fr" \
	-addext "subjectAltName=DNS:vipalaci.42.fr" \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/vipalaci.key \
	-out /etc/ssl/certs/vipalaci.crt

RUN rm -rf /etc/nginx/sites-enabled/*

#copy our custom nginx config file in the nginx container config
COPY conf/default.conf /etc/nginx/conf.d/

#start the container running nginx daemon in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
