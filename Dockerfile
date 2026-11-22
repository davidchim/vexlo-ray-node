FROM alpine:3.20
RUN apk add --no-cache ca-certificates curl unzip \
 && curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v26.10.21/Xray-linux-64.zip \
 && unzip /tmp/xray.zip -d /tmp/xray \
 && mv /tmp/xray/xray /usr/local/bin/xray \
 && chmod +x /usr/local/bin/xray \
 && rm -rf /tmp/xray.zip /tmp/xray
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh
EXPOSE 8080
CMD ["/bin/sh", "/entry.sh"]
