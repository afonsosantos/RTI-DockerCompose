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
RUN sed -i "s/localhost:8080/20.101.135.82:8082/" ./src/config.js
RUN sed -i "s/127.0.0.1:3001/20.101.135.82:8084/" ./src/config.js

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000