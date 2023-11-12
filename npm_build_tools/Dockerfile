FROM node:21-alpine

USER root

RUN apk add --no-cache bash
RUN apk add --update \
        nodejs-current \
        npm \
        zlib \
        zlib-dev \
        libc6-compat \
        g++ \
        make \ 
        libpng-dev

CMD ["bash"]