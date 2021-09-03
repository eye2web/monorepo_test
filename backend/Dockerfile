FROM nginx:stable

# Default environment files that can be overridden
# Rewrites nginx.conf by using a template as base
# leave as is
ENV NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx

ARG version=latest 
ENV VERSION=$version

COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template

EXPOSE 80