FROM debian:latest

RUN apt-get update
RUN apt-get install -y wget 

WORKDIR /home/debian

RUN apt-get install -y racket

RUN mkdir app/

COPY *.rkt app/
COPY *.html app/
COPY static/ app/static

WORKDIR app

CMD ["racket", "app.rkt"]
