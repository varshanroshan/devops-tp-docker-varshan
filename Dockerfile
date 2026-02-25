# Utiliser une version spécifique (pas latest)
FROM nginx:1.25.3-alpine

# Métadonnées
LABEL maintainer="TP DevOps"
LABEL description="Application DevOps sécurisée"
LABEL org.opencontainers.image.source="https://github.com/varshanroshan/devops-tp-docker-varshan"
# Config globale Nginx (pid dans /tmp pour user non-root)
COPY nginx/nginx-global.conf /etc/nginx/nginx.conf
# Ajouter un utilisateur non-root
RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

# Installer seulement les dépendances nécessaires
RUN apk add --no-cache ca-certificates

# Copier la config Nginx
COPY --chown=appuser:appgroup nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copier le site
COPY --chown=appuser:appgroup src/ /usr/share/nginx/html/

# Permissions
RUN chown -R appuser:appgroup /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

# Ajuster les permissions pour nginx
RUN mkdir -p /var/cache/nginx /var/run && \
    chown -R appuser:appgroup /var/cache/nginx /var/run

# Utilisateur non-root
USER appuser

# Exposer port 8080
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
