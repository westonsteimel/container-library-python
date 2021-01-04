#!/bin/sh

set -e

apt-get update && apt-get install -y --no-install-recommends \
    dpkg-dev

GNU_ARCH="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"

apt-get purge -y --auto-remove dpkg-dev

mkdir --parents \
    /build/rootfs \
    /build/rootfs/tmp \
    /build/rootfs/var \
    /build/rootfs/bin \
    /build/rootfs/lib \
    /build/rootfs/usr/lib \
    /build/rootfs/usr/lib/engines-1.1 \
    /build/rootfs/usr/bin \
    /build/rootfs/usr/local/lib \
    /build/rootfs/usr/local/bin \
    /build/rootfs/usr/local/include \
    /build/rootfs/usr/share/zoneinfo \
    /build/rootfs/etc/ssl/certs \
    /build/rootfs/var/lib/dpkg

# We store all of the apt package info at /var/lib/dpkg/status and create a blank file /var/lib/dpkg/available so that 
# vulnerability scanners such as trivy and clair will work

touch /build/rootfs/var/lib/dpkg/status
touch /build/rootfs/var/lib/dpkg/available

cat > /build/rootfs/etc/group << EOF
root:x:0:
adm:x:4:
tty:x:5:
video:x:28:
audio:x:29:
nobody:x:65534:
python:x:65532:
EOF

cat > /build/rootfs/etc/passwd << EOF
root:x:0:0:root:/root:/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/sbin/nologin
python:x:65532:65532:python:/home/python:/bin/sh
EOF

cat > /build/rootfs/etc/localtime << EOF
TZif2UTCTZif2øUTC
UTC0
EOF

# base-files
apt-get install -y --no-install-recommends base-files
cp --archive /usr/lib/os-release /build/rootfs/usr/lib/
cp --archive /etc/debian_version /build/rootfs/etc/
cp --archive /etc/os-release /build/rootfs/etc/
dpkg-query --status base-files >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# ca-certificates
apt-get install -y --no-install-recommends ca-certificates
cp --recursive --archive /etc/ssl/certs/* /build/rootfs/etc/ssl/certs/
dpkg-query --status ca-certificates >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libc6
apt-get install -y --no-install-recommends libc6
cp --archive /lib/${GNU_ARCH}/ld-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libBrokenLocale-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libBrokenLocale.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libSegFault.so /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libanl-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libanl.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libc-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libc.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libcrypt-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libcrypt.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libdl-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libdl.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libm-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libm.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libmemusage.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libmvec-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libmvec.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libnsl-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libnsl.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libnss_* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libpcprofile.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libpthread-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libpthread.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libresolv-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libresolv.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libthread_db-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libthread_db.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libutil-* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libutil.* /build/rootfs/lib/
# not currently including the following:
# /usr/lib/${GNU_ARCH}/audit/
# /usr/lib/${GNU_ARCH}/gconv/
dpkg-query --status libc6 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libcom-err2
apt-get install -y --no-install-recommends libcom-err2
cp --archive /lib/${GNU_ARCH}/libcom_err.so.* /build/rootfs/lib/
dpkg-query --status libcom-err2 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libbz2-1.0
apt-get install -y --no-install-recommends libbz2-1.0
cp --archive /lib/${GNU_ARCH}/libbz2.so.* /build/rootfs/lib/
dpkg-query --status libbz2-1.0 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libdb5.3
apt-get install -y --no-install-recommends libdb5.3
cp --archive /usr/lib/${GNU_ARCH}/libdb-* /build/rootfs/usr/lib/
dpkg-query --status libdb5.3 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libexpat1
apt-get install -y --no-install-recommends libexpat1
cp --archive /lib/${GNU_ARCH}/libexpat.so.* /build/rootfs/lib/
cp --archive /usr/lib/${GNU_ARCH}/libexpatw.so.* /build/rootfs/usr/lib/
dpkg-query --status libexpat1 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libffi6
apt-get install -y --no-install-recommends libffi6
cp --archive /usr/lib/${GNU_ARCH}/libffi.so.* /build/rootfs/usr/lib/
dpkg-query --status libffi6 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libgcc1
apt-get install -y --no-install-recommends libgcc1
cp --archive /lib/${GNU_ARCH}/libgcc_s.so.* /build/rootfs/lib/
dpkg-query --status libgcc1 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libgmp10
apt-get install -y --no-install-recommends libgmp10
cp --archive /usr/lib/${GNU_ARCH}/libgmp.so.* /build/rootfs/usr/lib/
dpkg-query --status libgmp10 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# liblz4
apt-get install -y --no-install-recommends liblz4-1
cp --archive /usr/lib/${GNU_ARCH}/liblz4.so.* /build/rootfs/usr/lib/
dpkg-query --status liblz4-1 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# liblzma5
apt-get install -y --no-install-recommends liblzma5
cp --archive /lib/${GNU_ARCH}/liblzma.so.* /build/rootfs/lib/
dpkg-query --status liblzma5 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libmpdec2
apt-get install -y --no-install-recommends libmpdec2
cp --archive /usr/lib/${GNU_ARCH}/libmpdec.so.* /build/rootfs/usr/lib/
dpkg-query --status libmpdec2 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libncursesw6
apt-get install -y --no-install-recommends libncursesw6
cp --archive /lib/${GNU_ARCH}/libncursesw.so.* /build/rootfs/lib/
cp --archive /usr/lib/${GNU_ARCH}/libformw.so.* /build/rootfs/usr/lib/
cp --archive /usr/lib/${GNU_ARCH}/libmenuw.so.* /build/rootfs/usr/lib/
cp --archive /usr/lib/${GNU_ARCH}/libpanelw.so.* /build/rootfs/usr/lib/ 
dpkg-query --status libncursesw6 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libreadline7
apt-get install -y --no-install-recommends libreadline7
cp --archive /lib/${GNU_ARCH}/libhistory.so.* /build/rootfs/lib/
cp --archive /lib/${GNU_ARCH}/libreadline.so.* /build/rootfs/lib/
dpkg-query --status libreadline7 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libsqlite3-0
apt-get install -y --no-install-recommends libsqlite3-0
cp --archive /usr/lib/${GNU_ARCH}/libsqlite3.so.* /build/rootfs/usr/lib/
dpkg-query --status libsqlite3-0 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libss2
apt-get install -y --no-install-recommends libss2
cp --archive /lib/${GNU_ARCH}/libss.so.* /build/rootfs/lib/
dpkg-query --status libss2 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libssl1.1
apt-get install -y --no-install-recommends libssl1.1
cp --archive /usr/lib/${GNU_ARCH}/libcrypto.so.* /build/rootfs/usr/lib/
cp --archive /usr/lib/${GNU_ARCH}/libssl.so.* /build/rootfs/usr/lib/
cp --recursive --archive /usr/lib/${GNU_ARCH}/engines-1.1/* /build/rootfs/usr/lib/engines-1.1/
dpkg-query --status libssl1.1 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libstdc++6
apt-get install -y --no-install-recommends libstdc++6
cp --archive /usr/lib/${GNU_ARCH}/libstdc++.so.* /build/rootfs/usr/lib/
dpkg-query --status libstdc++6 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libtinfo6
apt-get install -y --no-install-recommends libtinfo6
cp --archive /lib/${GNU_ARCH}/libtinfo.so.* /build/rootfs/lib/
cp --archive /usr/lib/${GNU_ARCH}/libtic.so.* /build/rootfs/usr/lib/
dpkg-query --status libtinfo6 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libunistring2
apt-get install -y --no-install-recommends libunistring2
cp --archive /usr/lib/${GNU_ARCH}/libunistring.so.* /build/rootfs/usr/lib/
dpkg-query --status libunistring2 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libuuid1
apt-get install -y --no-install-recommends libuuid1
cp --archive /lib/${GNU_ARCH}/libuuid.so.* /build/rootfs/lib/
dpkg-query --status libuuid1 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# libzstd1
apt-get install -y --no-install-recommends libzstd1
cp --archive /usr/lib/${GNU_ARCH}/libzstd.so.* /build/rootfs/usr/lib/
dpkg-query --status libzstd1 >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# netbase
apt-get install -y --no-install-recommends netbase
cp --archive /etc/protocols /build/rootfs/etc/
cp --archive /etc/rpc /build/rootfs/etc/
cp --archive /etc/services /build/rootfs/etc/
dpkg-query --status netbase >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# tzdata
apt-get install -y --no-install-recommends tzdata
cp --recursive --archive /usr/share/zoneinfo/* /build/rootfs/usr/share/zoneinfo/
dpkg-query --status tzdata >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# zlib1g
apt-get install -y --no-install-recommends zlib1g
cp --archive /lib/${GNU_ARCH}/libz.so.* /build/rootfs/lib/
dpkg-query --status zlib1g >> /build/rootfs/var/lib/dpkg/status
printf '\n' >> /build/rootfs/var/lib/dpkg/status

# should just be python stuff att /usr/local paths so copy it all and then remove the stuff we don't want to carry over 
cp --recursive --archive /usr/local/lib/* /build/rootfs/usr/local/lib/
cp --recursive --archive /usr/local/bin/* /build/rootfs/usr/local/bin/
cp --recursive --archive /usr/local/include/* /build/rootfs/usr/local/include/

# remove pip, idle, 2to3, etc
python_sitepackages=$(python -c 'import site; print(site.getsitepackages()[0])')
rm --recursive --force \
    /build/rootfs${python_sitepackages}/* \
    /build/rootfs/usr/local/lib/ensurepip \
    /build/rootfs/usr/local/bin/2to3* \
    /build/rootfs/usr/local/bin/easy_install* \
    /build/rootfs/usr/local/bin/idle* \
    /build/rootfs/usr/local/bin/pip* \
    /build/rootfs/usr/local/bin/pydoc* \
    /build/rootfs/usr/local/bin/wheel*

ln --symbolic --no-target-directory /lib /build/rootfs/lib64

