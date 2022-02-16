FROM nginx:1.21.5-alpine
RUN apk add bash

# FROM nginx:1.21.5

COPY gojq /usr/bin/

COPY test.sh /test.sh
RUN chmod +x /test.sh
COPY foo.txt.md5 /foo.txt.md5
COPY foo-mod.txt.md5 /foo-mod.txt.md5

ENTRYPOINT [ "/test.sh" ]