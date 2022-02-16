FROM alpine:3.15.0
#FROM alpine:3.9
RUN apk add bash

COPY test.sh /test.sh
RUN chmod +x /test.sh

ENTRYPOINT [ "/test.sh" ]