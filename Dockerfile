# Gebruik de officiële Nginx-image als basis
FROM ghcr.io/nginxinc/nginx-unprivileged:alpine3.21-perl

# Verwijder de standaard Nginx HTML-bestanden
#RUN rm -rf /usr/share/nginx/html/*

# Kopieer de bestanden van je applicatie naar de Nginx-webserver
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./manifest.json /usr/share/nginx/html/manifest.json
COPY ./service-worker.js /usr/share/nginx/html/service-worker.js

# De container luistert standaard op poort 80
EXPOSE 80
