# BUİLD

FROM node:20-alpine AS build

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# PROD

FROM node:20-alpine

WORKDIR /app

ARG NODE_ENV=production

COPY --from=build  /app/dist ./dist

COPY package.json ./
COPY package-lock.json ./

RUN npm install --only=production

EXPOSE 3000

CMD ["node", "dist/main"]