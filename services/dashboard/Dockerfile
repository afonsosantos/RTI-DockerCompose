FROM node:alpine

RUN apk add git

WORKDIR /dashboard

RUN result="$(git clone https://github.com/IuriRaimundo/DashboardGenerico .)" && echo $result

WORKDIR /app

RUN cp /dashboard/package.json ./
RUN cp /dashboard/package-lock.json ./
RUN cp /dashboard/* ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000