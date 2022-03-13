FROM python:3.9-alpine

MAINTAINER Diky


ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt 
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
# delete temporary install
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user