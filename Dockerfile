FROM alpine:3.15 AS extractor
ADD https://github.com/syncthing/discosrv/releases/download/v1.18.6/stdiscosrv-linux-amd64-v1.18.6.tar.gz ./
RUN tar -xf stdiscosrv-linux-amd64-v1.18.6.tar.gz

FROM alpine:3.15
COPY --from=extractor /stdiscosrv-linux-amd64-v1.18.6/stdiscosrv /usr/bin/stdiscosrv
VOLUME ["/keys", "/data"]
EXPOSE 8443/tcp 19200/tcp

ENTRYPOINT ["stdiscosrv", "-key=/keys/key.pem", "-cert=/keys/cert.pem", "-db-dir=/data"]