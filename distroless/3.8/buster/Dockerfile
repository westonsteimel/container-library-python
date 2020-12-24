FROM python:3.8-slim as builder

ADD prepare-rootfs.sh /

RUN ./prepare-rootfs.sh

FROM scratch

COPY --from=builder /build/rootfs/ /

ENV PATH="/usr/local/bin"
ENV LD_LIBRARY_PATH="/usr/local/lib/"
