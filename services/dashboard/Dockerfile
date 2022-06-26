FROM node:alpine

RUN apk add git

WORKDIR /dashboard

RUN git clone https://github.com/IuriRaimundo/DashboardGenerico .

WORKDIR /app

RUN cp /dashboard/package.json ./
RUN cp /dashboard/package-lock.json ./
RUN cp -r /dashboard ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000