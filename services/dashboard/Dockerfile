FROM node:alpine

WORKDIR /app

RUN apk add git

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico dashboard

COPY ./dashboard/package.json ./
COPY ./dashboard/package-lock.json ./
COPY ./dashboard/ ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000