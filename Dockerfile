FROM node:10.15-alpine

LABEL maintainer="S-Kazuki<contact@revoneo.com>"

ENV APP_ROOT=/node

WORKDIR $APP_ROOT

COPY package*.json ${APP_ROOT}/

RUN npm ci \
&& npm cache clean --force \
\
&& apk update \
&& apk add tzdata \
&& TZ=${TZ:-Asia/Tokyo} \
&& cp /usr/share/zoneinfo/$TZ /etc/localtime \
&& echo $TZ> /etc/timezone \
&& apk del tzdata \
&& rm -rf /var/cache/apk/*

CMD ["npm", "start"]
