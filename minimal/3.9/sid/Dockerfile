#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM docker.io/westonsteimel/python:3.9-slim-sid as builder

ENV PYTHON_VERSION="3.9.1" 
ENV PYTHON_PIP_VERSION="20.3.3"

ADD prepare-rootfs.sh /
RUN ./prepare-rootfs.sh

FROM scratch

COPY --from=builder /build/rootfs/ /

USER python
WORKDIR /home/python

ENV PATH="/usr/local/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}" \
    LANG="C.UTF-8"

CMD ["/usr/local/bin/python3"]
