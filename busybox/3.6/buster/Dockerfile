#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM docker.io/westonsteimel/python:3.6-minimal-buster as builder

FROM docker.io/library/busybox:glibc

COPY --from=builder / /

USER python
WORKDIR /home/python

ARG PYTHON_VERSION="3.6.12"
ENV PATH="/usr/local/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}" \
    LANG="C.UTF-8" \
    PYTHON_VERSION="${PYTHON_VERSION}"

CMD ["/usr/local/bin/python3"]
