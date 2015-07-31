FROM alpine:3.2

EXPOSE 80 443

RUN apk add --update wget bash nginx-lua inotify-tools && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /tmp/nginx/client-body

RUN rm -rf /etc/nginx/*.d \
 && mkdir -p /etc/nginx/addon.d /etc/nginx/conf.d /etc/nginx/host.d /etc/nginx/nginx.d

ADD build/etc /etc
ADD data /data

CMD ["nginx", "-g", "daemon off;"]

# REMOVE it!

RUN apk add --update mc
ENV TERM xterm