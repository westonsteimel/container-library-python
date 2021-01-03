#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM docker.io/westonsteimel/python:3.7-slim-bullseye as builder

ADD prepare-rootfs.sh /
RUN ./prepare-rootfs.sh

FROM scratch

COPY --from=builder /build/rootfs/ /

USER python
WORKDIR /home/python

ARG PYTHON_VERSION="3.7.9"
ENV PATH="/usr/local/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}" \
    LANG="C.UTF-8" \
    PYTHON_VERSION="${PYTHON_VERSION}"

CMD ["/usr/local/bin/python3"]
