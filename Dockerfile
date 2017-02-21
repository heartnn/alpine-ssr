FROM alpine:3.5
RUN apk --no-cache add python libsodium unzip openssl ca-certificates \
    && update-ca-certificates

RUN cd / \
    && wget https://github.com/breakwa11/shadowsocks/archive/manyuser.zip -O /tmp/manyuser.zip \
    && unzip -d /tmp /tmp/manyuser.zip \
    && mv /tmp/shadowsocks-manyuser/shadowsocks /shadowsocks \
    && rm -rf /tmp/*
    
ADD dns.conf /shadowsocks/dns.conf
ADD config.json /shadowsocks/config.json
ADD start.sh /shadowsocks/start.sh

RUN chmod +x /shadowsocks/start.sh

WORKDIR /shadowsocks

CMD /shadowsocks/start.sh

EXPOSE 8388/tcp 8388/udp

ENTRYPOINT ["/shadowsocks/start.sh"]
