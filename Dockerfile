FROM debian 

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && curl -Ls https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz -o cloudflared.tgz  \
 && tar xzvf cloudflared.tgz \
 && rm cloudflared.tgz \
 && chmod +x cloudflared

# https://git.io/JfLKZ
RUN ldd cloudflared | tr -s '[:blank:]' '\n' | grep '^/' | \
    xargs -I % sh -c 'mkdir -p $(dirname deps%); cp % deps%;'
    
RUN ldd /bin/sh | tr -s '[:blank:]' '\n' | grep '^/' | \
    xargs -I % sh -c 'mkdir -p $(dirname deps%); cp % deps%;'

FROM scratch
WORKDIR /
COPY --from=0 /deps /
COPY --from=0 /bin/sh /bin/sh
COPY --from=0 /cloudflared /
COPY --from=0 /etc/ssl/certs /etc/ssl/certs

ENTRYPOINT ./cloudflared tunnel --url $ADDR
