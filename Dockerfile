FROM nginx:1.29-alpine

LABEL maintainer="TP DevOps"
LABEL description="Application DevOps containerisée avec Nginx"

RUN apk add --no-cache wget

# Config nginx (global + vhost)
COPY nginx/nginx-global.conf /etc/nginx/nginx.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Site
COPY src/ /usr/share/nginx/html/

# Préparer dossiers nécessaires pour nginx non-root
RUN mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
  && chown -R nginx:nginx /tmp /usr/share/nginx/html /etc/nginx/conf.d /var/cache/nginx /var/run /var/log/nginx \
  && chmod -R 755 /usr/share/nginx/html

USER nginx

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
