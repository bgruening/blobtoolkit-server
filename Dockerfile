FROM nginx:1.23
LABEL license="MIT"
ARG BTK_VERSION
ENV BTK_VERSION=${BTK_VERSION:-4.1.0}
LABEL version=$BTK_VERSION

RUN apt-get update && apt install --no-install-recommends --no-install-suggests -y wget nano \
    && apt-get remove --purge --auto-remove -y

RUN mkdir -p /blobtoolkit/conf \
    && mkdir -p /blobtoolkit/datasets \
    && wget https://github.com/blobtoolkit/blobtoolkit/releases/download/${BTK_VERSION}/blobtoolkit-api-linux \
    && wget https://github.com/blobtoolkit/blobtoolkit/releases/download/${BTK_VERSION}/blobtoolkit-viewer-linux \
    && mv blobtoolkit-api-linux /blobtoolkit/blobtoolkit-api \
    && mv blobtoolkit-viewer-linux /blobtoolkit/blobtoolkit-viewer \
    && rm /etc/nginx/conf.d/default.conf \
    && chmod 755 /blobtoolkit/blobtoolkit-viewer /blobtoolkit/blobtoolkit-api

COPY btk.nginx /etc/nginx/conf.d/btk.conf
COPY startup.sh /blobtoolkit/

WORKDIR /blobtoolkit

ENV PATH /blobtoolkit:$PATH

RUN chmod +x startup.sh

EXPOSE 80

CMD startup.sh
