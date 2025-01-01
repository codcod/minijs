FROM node:alpine AS base

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci && npm cache clean --force

COPY ./src .

EXPOSE 3000

CMD ["node", "./app.js"]
