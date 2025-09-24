# Gebruik een officiële Nginx-image als basis
FROM nginx:alpine

# Kopieer de HTML-bestanden naar de Nginx-webservermap
COPY . /usr/share/nginx/html
