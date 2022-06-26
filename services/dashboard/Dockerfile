FROM node:alpine

RUN apk add git

WORKDIR /dashboard

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico .

WORKDIR /app

RUN cp /dashboard/package.json ./
RUN cp /dashboard/package-lock.json ./
RUN cp -R /dashboard/* ./

# replace configurations

RUN sed -i "s/localhost:8080/api:8082/" ./src/config.js

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000