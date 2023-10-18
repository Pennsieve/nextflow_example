FROM --platform=linux/amd64 python:latest

RUN apt update && apt-get install -y nodejs

RUN apt-get install -y npm

RUN npm install --global npm@^7

RUN npm install -g bids-validator

COPY build_virtual_path.py /