FROM nginx:alpine

ARG SERVER_NAME
ENV RAILS_ROOT /var/www/rails

WORKDIR $RAILS_ROOT

# must need to create log directory
RUN mkdir log

COPY public public/

# Copy ssl_certificate for https
COPY certs certs/

COPY ./nginx/nginx.conf /tmp/docker.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /tmp/docker-example.nginx
RUN envsubst '$SERVER_NAME' < /tmp/docker-example.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80 443

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]