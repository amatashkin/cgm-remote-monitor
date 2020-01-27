FROM node:10-alpine

MAINTAINER Nightscout Contributors


RUN mkdir -p /opt/app
ADD . /opt/app
WORKDIR /opt/app
RUN chown -R node:node /opt/app

RUN apk add --no-cache --virtual .gyp \
        python \
        make \
        g++ \
    && npm install \
        npm install && \
        npm run postinstall && \
        npm run env && \
        npm audit fix \
    && apk del .gyp

USER node

EXPOSE 1337

CMD ["node", "server.js"]
