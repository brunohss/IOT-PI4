FROM arm32v7/node:lts-slim

WORKDIR /frontend-bh/

COPY ./frontend-bh/package.json .

RUN npm install

COPY ./frontend-bh .

EXPOSE 5173

CMD [ "npm", "run", "dev" ]