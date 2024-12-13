# From https://www.krakend.io/docs/deploying/docker/

FROM devopsfaith/krakend:2.7 AS builder

COPY krakend.go.tmpl .
COPY config .

## Save temporary file to /tmp to avoid permission errors
RUN FC_ENABLE=1 \
    FC_OUT=/tmp/krakend-prod.json \
    FC_PARTIALS="/etc/krakend/partials" \
    FC_SETTINGS="/etc/krakend/settings/prod" \
    FC_TEMPLATES="/etc/krakend/templates" \
    krakend check -d -t -c krakend.go.tmpl --lint && \
    FC_ENABLE=1 \
    FC_OUT=/tmp/krakend-dev.json \
    FC_PARTIALS="/etc/krakend/partials" \
    FC_SETTINGS="/etc/krakend/settings/dev" \
    FC_TEMPLATES="/etc/krakend/templates" \
    krakend check -d -t -c krakend.go.tmpl --lint

FROM devopsfaith/krakend:2.7
# Keep operating system updated with security fixes between releases
RUN apk upgrade --no-cache --no-interactive

COPY --from=builder --chown=krakend:nogroup /tmp/krakend-*.json .
# Uncomment with Enterprise image:
# COPY LICENSE /etc/krakend/LICENSE

COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
ENTRYPOINT ["/usr/local/bin/init.sh"]