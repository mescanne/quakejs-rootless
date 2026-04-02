#Builder
FROM debian:trixie-slim AS builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confnew" && \
    apt-get install -y --no-install-recommends \
        curl \
        netcat-openbsd \
        ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get install -y --no-install-recommends nginx-light && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./quakejs /quakejs
WORKDIR /quakejs
RUN npm install --only=production

# #Hardened image
# # Must be logged in to dhi.io (Docker Hardened Images)
# FROM dhi.io/debian-base@sha256:9525de383d949d1833d7353a5f3fcfdaaff3f2170dc6ed2170c6b7bddac5c109
# 
# ARG DEBIAN_FRONTEND=noninteractive
# ENV TZ=UTC
# 
# COPY --from=builder /usr/bin/node /usr/bin/node
# COPY --from=builder /usr/lib/node_modules /usr/lib/node_modules
# COPY --from=builder /usr/bin/npm /usr/bin/npm
# COPY --from=builder /usr/bin/sed /usr/bin/sed
# COPY --from=builder /usr/bin/curl /usr/bin/curl
# COPY --from=builder /usr/bin/nc /usr/bin/nc
# 
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libgcc_s.so.1 /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libcurl.so.4 /usr/lib/x86_64-linux-gnu/libcurl.so.4
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libnghttp2.so.14 /usr/lib/x86_64-linux-gnu/libnghttp2.so.14
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libnghttp3.so.9 /usr/lib/x86_64-linux-gnu/libnghttp3.so.9
# COPY --from=builder /usr/lib/x86_64-linux-gnu/librtmp.so.1 /usr/lib/x86_64-linux-gnu/librtmp.so.1
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libssh2.so.1 /usr/lib/x86_64-linux-gnu/libssh2.so.1
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libpsl.so.5 /usr/lib/x86_64-linux-gnu/libpsl.so.5
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libgnutls.so.30 /usr/lib/x86_64-linux-gnu/libgnutls.so.30
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libldap.so.2 /usr/lib/x86_64-linux-gnu/libldap.so.2
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libbrotlidec.so.1 /usr/lib/x86_64-linux-gnu/libbrotlidec.so.1
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libbrotlicommon.so.1 /usr/lib/x86_64-linux-gnu/libbrotlicommon.so.1
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libkrb5.so.3 /usr/lib/x86_64-linux-gnu/libkrb5.so.3
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 /usr/lib/x86_64-linux-gnu/libk5crypto.so.3
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 /usr/lib/x86_64-linux-gnu/libkrb5support.so.0
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libsasl2.so.2 /usr/lib/x86_64-linux-gnu/libsasl2.so.2
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libidn2.so.0 /usr/lib/x86_64-linux-gnu/libidn2.so.0
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libunistring.so.5 /usr/lib/x86_64-linux-gnu/libunistring.so.5
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 /usr/lib/x86_64-linux-gnu/libp11-kit.so.0
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libtasn1.so.6 /usr/lib/x86_64-linux-gnu/libtasn1.so.6
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libnettle.so.8 /usr/lib/x86_64-linux-gnu/libnettle.so.8
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libhogweed.so.6 /usr/lib/x86_64-linux-gnu/libhogweed.so.6
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libgmp.so.10 /usr/lib/x86_64-linux-gnu/libgmp.so.10
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libffi.so.8 /usr/lib/x86_64-linux-gnu/libffi.so.8
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libcom_err.so.2 /usr/lib/x86_64-linux-gnu/libcom_err.so.2
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libkeyutils.so.1 /usr/lib/x86_64-linux-gnu/libkeyutils.so.1
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0 /usr/lib/x86_64-linux-gnu/libpcre2-8.so.0
# COPY --from=builder /usr/lib/x86_64-linux-gnu/libcrypt.so.1 /usr/lib/x86_64-linux-gnu/libcrypt.so.1
# 
# COPY --from=builder /usr/sbin/nginx /usr/sbin/nginx
# COPY --from=builder /etc/nginx /etc/nginx
# COPY --from=builder /usr/lib/nginx /usr/lib/nginx
# COPY --from=builder /var/lib/nginx /var/lib/nginx
# COPY --from=builder /usr/share/nginx /usr/share/nginx
# 
# COPY --from=builder --chown=65532:65532 /quakejs /quakejs

RUN mkdir -p /home/nonroot/www && \
    chown -R 65532:65532 /home/nonroot/www /quakejs

COPY --chown=65532:65532 server.cfg /quakejs/base/baseq3/server.cfg
COPY --chown=65532:65532 server.cfg /quakejs/base/cpma/server.cfg
COPY --chown=65532:65532 ./include/ioq3ded/ioq3ded.fixed.js /quakejs/build/ioq3ded.js

RUN cp /quakejs/html/* /home/nonroot/www/ && \
    chown -R 65532:65532 /home/nonroot/www

COPY --chown=65532:65532 ./include/assets/ /home/nonroot/www/assets
COPY --chown=65532:65532 nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p \
        /tmp/client_temp \
        /tmp/proxy_temp_path \
        /tmp/fastcgi_temp \
        /tmp/uwsgi_temp \
        /tmp/scgi_temp && \
    chown -R 65532:65532 \
        /tmp/client_temp \
        /tmp/proxy_temp_path \
        /tmp/fastcgi_temp \
        /tmp/uwsgi_temp \
        /tmp/scgi_temp

COPY --chown=65532:65532 --chmod=755 entrypoint.sh /entrypoint.sh

EXPOSE 8080

USER nonroot

ENTRYPOINT ["/entrypoint.sh"]
