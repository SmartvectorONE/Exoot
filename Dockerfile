# Multi-stage Dockerfile om de geheime sleutel te injecteren.

# Fase 1: Build-fase om het geheime sleutel in het HTML-bestand te injecteren.
FROM alpine:latest AS build

# Installeer 'gettext' voor omgevingsvariabele substitutie
RUN apk --no-cache add gettext

# Stel het werkende directory in
WORKDIR /app

# Kopieer de HTML-sjabloon naar de build-container
COPY index.html index.html.in

# Voer omgevingsvariabele substitutie uit en sla op in het uiteindelijke HTML-bestand
CMD envsubst '$WEBHOOK_SECRET' < index.html.in > /usr/share/nginx/html/index.html

# Fase 2: Run-fase om de Nginx-webserver te draaien.
FROM FROM ghcr.io/nginxinc/nginx-unprivileged:alpine3.21-perl

# Verwijder de standaard Nginx HTML-bestanden
#RUN rm -rf /usr/share/nginx/html/*

# Kopieer de gemanifesteerde bestanden
COPY --from=build /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html
COPY ./manifest.json /usr/share/nginx/html/manifest.json
COPY ./service-worker.js /usr/share/nginx/html/service-worker.js

# De container luistert standaard op poort 80
EXPOSE 80
