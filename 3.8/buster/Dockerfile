FROM python:3.8-slim as builder

ADD prepare-rootfs.sh /

RUN ./prepare-rootfs.sh

FROM busybox:glibc

COPY --from=builder /build/rootfs/ /

ENV LD_LIBRARY_PATH="/usr/local/lib/"
