FROM node:alpine

RUN apk add git

WORKDIR /dashboard

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico .

WORKDIR /app

RUN cp /dashboard/package.json ./
RUN cp /dashboard/package-lock.json ./
RUN cp -R /dashboard/* ./

#
# !! IMPORTANT: change the IP address to the public IP of the Docker host
#
RUN sed -i "s/localhost:8080/65.52.158.78:8082/" ./src/config.js

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000