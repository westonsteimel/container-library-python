#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM ghcr.io/westonsteimel/python:3.8-minimal-bullseye as builder

FROM docker.io/library/busybox:glibc

COPY --from=builder / /

USER python
WORKDIR /home/python

ARG PYTHON_VERSION="3.8.14"
ENV PATH="/usr/local/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}" \
    LANG="C.UTF-8" \
    PYTHON_VERSION="${PYTHON_VERSION}"

CMD ["/usr/local/bin/python3"]
