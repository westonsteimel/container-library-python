#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM docker.io/westonsteimel/python:3.8-slim-buster as builder

ENV PYTHON_VERSION="3.8.7" 
ENV PYTHON_PIP_VERSION="20.3.3"

ADD prepare-rootfs.sh /
RUN ./prepare-rootfs.sh

RUN python_sitepackages=$(python -c 'import site; print(site.getsitepackages()[0])') \
    && rm --recursive --force "/build/rootfs${python_sitepackages}/*" \
        /build/rootfs/usr/local/bin/2to3* \
        /build/rootfs/usr/local/bin/easy_install* \
        /build/rootfs/usr/local/bin/idle* \
        /build/rootfs/usr/local/bin/pip* \
        /build/rootfs/usr/local/bin/pydoc* \
        /build/rootfs/usr/local/bin/wheel*

FROM scratch

COPY --from=builder /build/rootfs/ /

ENV PATH="/usr/local/bin:${PATH}" \
    LD_LIBRARY_PATH="/usr/local/lib/:${LD_LIBRARY_PATH}"

CMD ["/usr/local/bin/python3"]
