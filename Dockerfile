# Etapa 1: Construir y empaquetar el proyecto Angular
FROM node:latest AS node-builder
WORKDIR /app
COPY ./ /.

RUN npm cache clean --force
COPY . .

RUN npm install --force
RUN npm run build --prod

# Etapa 3: Configurar Nginx para servir el frontend Angular y el backend de WildFly
FROM nginx:latest
COPY --from=node-builder ./dist/ventadas /usr/share/nginx/html
COPY /nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 4200

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]