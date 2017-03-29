FROM debian:8.1
MAINTAINER Luis E Alvarado <admin@avnet.ws>

RUN apt-get update && \
    apt-get install -y \
    make \
    gcc \
    libc-dev \
    libcurl4-openssl-dev \
    libgeoip-dev \
    libssl-dev \
    ruby2.1-dev \
    ruby2.1 && \
    apt-get clean

WORKDIR /opt/iroffer
ADD http://iroffer.dinoex.net/iroffer-dinoex-3.30.tar.gz /opt/iroffer-dinoex-3.30.tar.gz
RUN tar xfz /opt/iroffer-dinoex-3.30.tar.gz -C /opt/iroffer && rm /opt/iroffer-dinoex-3.30.tar.gz

RUN cd iroffer-dinoex-3.30 && \
    ./Configure -curl -geoip -ruby && \
    make && \
    cp -p iroffer .. && \
    cp *.html .. && \
    cp -r htdocs ../ && \
    mkdir ../files && \
    cd .. && \
    rm -r /opt/iroffer/iroffer-dinoex-3.30 && \
    useradd iroffer && chown -R iroffer:iroffer /opt/iroffer && chmod 700 /opt/iroffer

CMD /opt/iroffer/mybot.config && \
    ./iroffer -b -u iroffer /opt/iroffer/mybot.config && \
    tail -F /opt/iroffer/mybot.log

VOLUME /opt/iroffer/
VOLUME /opt/iroffer/files
EXPOSE 50000-50010