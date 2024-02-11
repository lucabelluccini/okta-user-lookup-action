FROM alpine:3.10

RUN apk update && \
    apk upgrade && \
    apk add --no-cache jq curl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
