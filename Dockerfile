FROM alpine:3.5
RUN apk --no-cache add python libsodium unzip

RUN mkdir /ssr
    cd /ssr \
    && wget --no-check-certificate https://github.com/breakwa11/shadowsocks/archive/manyuser.zip -O /tmp/manyuser.zip \
    && unzip -d /tmp /tmp/manyuser.zip \
    && mv /tmp/shadowsocks-manyuser/shadowsocks /ssr \
    && rm -rf /tmp/*
    
ADD dns.conf /ssr/shadowsocks/dns.conf
ADD config.json /ssr/shadowsocks/config.json
ADD start.sh /ssr/shadowsocks/start.sh

RUN chmod +x /ssr/shadowsocks/start.sh

WORKDIR /ssr/shadowsocks

CMD /ssr/shadowsocks/start.sh

EXPOSE 8388/tcp 8388/udp

ENTRYPOINT ["/ssr/shadowsocks/start.sh"]
