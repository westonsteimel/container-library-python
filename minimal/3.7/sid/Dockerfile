#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM docker.io/westonsteimel/python:3.7-slim-sid as builder

ADD prepare-rootfs.sh /
RUN ./prepare-rootfs.sh

FROM scratch

COPY --from=builder /build/rootfs/ /

USER python
WORKDIR /home/python

ARG PYTHON_VERSION="3.7.11"
ENV PATH="/usr/local/bin:${PATH}" \
    LANG="C.UTF-8" \
    PYTHON_VERSION="${PYTHON_VERSION}"

CMD ["/usr/local/bin/python3"]
