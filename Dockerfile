FROM python:3.9-alpine

COPY ./config/requirements.txt /tmp/requirements.txt
RUN apk update && \
    apk add nginx curl && \
    apk add --no-cache --virtual .build-deps gcc libc-dev linux-headers && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    apk del .build-deps

RUN rm -f /etc/nginx/conf.d/*
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/server.conf /etc/nginx/conf.d/server.conf
COPY config/uwsgi.ini /etc/uwsgi/uwsgi.ini
COPY config/supervisord.conf /etc/supervisord.conf
COPY /app /app

WORKDIR /app

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]