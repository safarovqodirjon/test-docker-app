FROM python:3.11-slim

LABEL maintainer = "github/safarovq"

RUN mkdir app/

COPY ./docker-project/ app/
WORKDIR app/

EXPOSE 8000


RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
        build-essential \
        postgresql-client \
        libpq-dev && \

    apt-get purge -y --auto-remove build-essential libpq-dev &&\
    adduser --disabled-password --no-create-home django-user

RUN python3 -m venv /.venv/ &&\
    /.venv/bin/pip install --upgrade pip &&\

    /.venv/bin/pip install -r requirements.txt && \


USER django-user

ENV PATH="/.venv/bin:$PATH"
