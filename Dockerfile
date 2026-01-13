FROM nginx:1.29-alpine

LABEL maintainer="TP DevOps"
LABEL description="Application DevOps containerisée avec Nginx"

# Installer wget pour le HEALTHCHECK (sans cache)
RUN apk add --no-cache wget

# Copier la config Nginx et le contenu web
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY src/ /usr/share/nginx/html/

# Permissions minimales + exécution en non-root
RUN chown -R nginx:nginx /usr/share/nginx/html /etc/nginx/conf.d \
  && chmod -R 755 /usr/share/nginx/html

USER nginx

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
