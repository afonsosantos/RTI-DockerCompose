FROM node:alpine

RUN apk add git

WORKDIR /dashboard

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico .

WORKDIR /app

COPY /dashboard/package.json ./
COPY /dashboard/package-lock.json ./
COPY /dashboard/ ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000