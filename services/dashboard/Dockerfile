FROM node:alpine

WORKDIR /app

RUN apk add git

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico dashboard

WORKDIR /app/dashboard

COPY package.json ../
COPY package-lock.json ../
COPY ./ ../

WORKDIR /app

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000