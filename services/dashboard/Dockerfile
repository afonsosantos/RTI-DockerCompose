FROM node:alpine

WORKDIR /app

RUN apk add git

WORKDIR /app/dashboard

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico .

WORKDIR /app

COPY ./dashboard/package.json ./
COPY ./dashboard/package-lock.json ./
COPY ./ ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000