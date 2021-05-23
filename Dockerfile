# Multi-step build
# Block 0
FROM node:alpine 

USER node

RUN mkdir '/home/node/app'

WORKDIR '/home/node/app'

COPY --chown=node:node ./package.json .

RUN npm install

COPY --chown=node:node .  .

RUN npm run build

# Block 1 
# New From = New stage 
FROM nginx

COPY --from=0 /home/node/app/build /usr/share/nginx/html