FROM node:alpine

WORKDIR /opt/pm

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 5005

CMD ["npm" ,"start"]