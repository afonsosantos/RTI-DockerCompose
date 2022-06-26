FROM node:alpine

RUN apk add git

WORKDIR /dashboard

RUN result="$(git clone https://github.com/IuriRaimundo/DashboardGenerico .)" && echo $result

WORKDIR /app

COPY /dashboard/package.json ./
COPY /dashboard/package-lock.json ./
COPY /dashboard/ ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000