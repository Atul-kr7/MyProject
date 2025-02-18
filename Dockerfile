# Stage 1: Build the Angular application
FROM node:14 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve the application using NGINX
FROM nginx:alpine

COPY --from=build /app/dist/myproject /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]