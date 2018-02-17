FROM consul:1.0.6
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

RUN apk add --no-cache --update bash

ENV GOMAXPROCS 10
ENV DOCKER_VERSION 17.09.1-ce

RUN curl -L --retry 5 --retry-delay 1 -o /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
    tar -xz -C /tmp -f /tmp/docker.tgz && \
    mv /tmp/docker/docker /bin/docker && \
    chmod +x /bin/docker && \
    rm -rf /tmp/docker && rm -rf /tmp/docker.tgz

COPY ./etcd-bootstrap /bin/etcd-bootstrap
COPY config/* /consul/config/

ENTRYPOINT ["/bin/etcd-bootstrap"]
CMD [""]
