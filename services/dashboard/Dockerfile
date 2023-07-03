FROM node:alpine

ARG REACT_APP_API_URL
ARG REACT_APP_RPI_URL
ARG REACT_APP_SOCKET_URL

ENV REACT_APP_API_URL $REACT_APP_API_URL
ENV REACT_APP_RPI_URL $REACT_APP_RPI_URL
ENV REACT_APP_SOCKET_URL $REACT_APP_SOCKET_URL

RUN apk add git

WORKDIR /dashboard

RUN git clone https://github.com/Projetos-IPL/RTI-Dashboard .

WORKDIR /app

RUN cp /dashboard/package.json ./
RUN cp /dashboard/package-lock.json ./
RUN cp -R /dashboard/* ./

RUN npm install

CMD ["npm", "run", "start"]

EXPOSE 3000