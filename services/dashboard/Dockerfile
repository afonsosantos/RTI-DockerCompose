# BUILD phase
FROM node:alpine AS builder

ARG REACT_APP_API_URL
ARG REACT_APP_RPI_URL
ARG REACT_APP_SOCKET_URL

ENV REACT_APP_API_URL $REACT_APP_API_URL
ENV REACT_APP_RPI_URL $REACT_APP_RPI_URL
ENV REACT_APP_SOCKET_URL $REACT_APP_SOCKET_URL

WORKDIR /dashboard

RUN apk add git
RUN git clone https://github.com/Projetos-IPL/RTI-Dashboard .

WORKDIR /app

RUN cp /dashboard/package.json ./
RUN cp /dashboard/package-lock.json ./
RUN cp -R /dashboard/* ./

RUN npm install
RUN npm run build

# NGINX phase

FROM nginx:latest

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html

RUN touch /var/run/nginx.pid

RUN chown -R nginx:nginx /var/run/nginx.pid /usr/share/nginx/html /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
