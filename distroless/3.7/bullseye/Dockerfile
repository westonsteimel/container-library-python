#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM docker.io/westonsteimel/python:3.7-bullseye-slim

ADD prepare-rootfs.sh /
RUN ./prepare-rootfs.sh

FROM scratch

COPY --from=builder /build/rootfs/ /

ENV PATH="/usr/local/bin"
ENV LD_LIBRARY_PATH="/usr/local/lib/"

CMD ["/usr/local/bin/python3"]
