FROM node:alpine

RUN apk add git

WORKDIR /app

RUN git clone https://github.com/Projetos-IPL/RTI-Socket-Server .

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000