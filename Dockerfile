# Gebruik de officiële Nginx-image als basis
FROM nginx:alpine

# Verwijder de standaard Nginx HTML-bestanden
RUN rm -rf /usr/share/nginx/html/*

# Kopieer de applicatiebestanden naar de Nginx-webmap
COPY index.html /usr/share/nginx/html/index.html
COPY manifest.json /usr/share/nginx/html/manifest.json
COPY service-worker.js /usr/share/nginx/html/service-worker.js

# Exposeer poort 80 van de container
EXPOSE 80

# Start Nginx en serveer de app
CMD ["nginx", "-g", "daemon off;"]
