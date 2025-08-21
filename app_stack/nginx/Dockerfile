FROM nginx:latest


RUN rm /etc/nginx/conf.d/default.conf

RUN mkdir /etc/nginx/ssl
COPY sites-available /etc/nginx/sites-available
COPY sites-enabled /etc/nginx/sites-enabled
COPY nginx.conf /etc/nginx/nginx.conf
COPY server.crt /etc/nginx/ssl
COPY server.key /etc/nginx/ssl

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
