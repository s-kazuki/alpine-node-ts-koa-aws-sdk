FROM node:8.11-alpine

LABEL maintainer="S-Kazuki<contact@revoneo.com>"

ENV APP_ROOT=/node

WORKDIR $APP_ROOT

COPY package.json $APP_ROOT

RUN npm install \
&& npm cache clean --force \
\
&& apk update \
&& apk add tzdata \
&& TZ=${TZ:-Asia/Tokyo} \
&& cp /usr/share/zoneinfo/$TZ /etc/localtime \
&& echo $TZ> /etc/timezone \
&& rm -rf /var/cache/apk/*

CMD ["npm", "start"]
