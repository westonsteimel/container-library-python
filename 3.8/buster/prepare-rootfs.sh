#!/bin/sh

set -e

apt-get update && apt-get install -y --no-install-recommends \
    libmpdec2 \
    tzdata 

mkdir --parents \
    /build/rootfs \
    /build/rootfs/lib \
    /build/rootfs/usr/lib \
    /build/rootfs/usr/bin \
    /build/rootfs/usr/local/lib \
    /build/rootfs/usr/local/bin \
    /build/rootfs/usr/local/include \
    /build/rootfs/usr/share/zoneinfo \
    /build/rootfs/etc/ssl/certs \
    /build/rootfs/var/lib/dpkg/status.d

cp --recursive --archive /lib/x86_64-linux-gnu/* /build/rootfs/lib/
cp --recursive --archive /usr/lib/x86_64-linux-gnu/* /build/rootfs/usr/lib/
cp --recursive --archive /usr/local/lib/* /build/rootfs/usr/local/lib/
cp --recursive --archive /usr/local/bin/* /build/rootfs/usr/local/bin/
cp --recursive --archive /usr/local/include/* /build/rootfs/usr/local/include/
cp --recursive --archive /usr/share/zoneinfo/* /build/rootfs/usr/share/zoneinfo/
cp --archive /usr/lib/os-release /build/rootfs/usr/lib/
cp --archive /etc/debian_version /build/rootfs/etc/
cp --archive /etc/os-release /build/rootfs/etc/
cp --archive /etc/protocols /build/rootfs/etc/
cp --archive /etc/rpc /build/rootfs/etc/
cp --archive /etc/services /build/rootfs/etc/

rm --recursive --force \
    /build/rootfs/lib/libaudit* \
    /build/rootfs/lib/libblkid* \
    /build/rootfs/lib/libcap* \
    /build/rootfs/lib/libe2p* \
    /build/rootfs/lib/libext2fs* \
    /build/rootfs/lib/libaudit* \
    /build/rootfs/lib/libfdisk* \
    /build/rootfs/lib/libgcrypt* \
    /build/rootfs/lib/libgpg* \
    /build/rootfs/lib/libmount* \
    /build/rootfs/lib/libpam* \
    /build/rootfs/lib/libpcre* \
    /build/rootfs/lib/libselinux* \
    /build/rootfs/lib/libsepol* \
    /build/rootfs/lib/libsmartcols* \
    /build/rootfs/lib/libsystemd* \
    /build/rootfs/lib/libudev* \
    /build/rootfs/lib/security

rm --recursive --force \
    /build/rootfs/usr/lib/libacl* \
    /build/rootfs/usr/lib/libapt* \
    /build/rootfs/usr/lib/libattr* \
    /build/rootfs/usr/lib/libdebconf* \
    /build/rootfs/usr/lib/libgdbm* \
    /build/rootfs/usr/lib/libgnutls* \
    /build/rootfs/usr/lib/libhogweed* \
    /build/rootfs/usr/lib/libidn* \
    /build/rootfs/usr/lib/libnettle* \
    /build/rootfs/usr/lib/libp11* \
    /build/rootfs/usr/lib/libpcre* \
    /build/rootfs/usr/lib/libseccomp* \
    /build/rootfs/usr/lib/libsemanage* \
    /build/rootfs/usr/lib/libtasn1* \
    /build/rootfs/usr/lib/libtic* \
    /build/rootfs/usr/lib/perl* 

# We add all of this so that vulnerability scanners such as Trivy will work
dpkg-query --status base-files > /build/rootfs/var/lib/dpkg/status.d/base
dpkg-query --status ca-certificates > /build/rootfs/var/lib/dpkg/status.d/ca-certificates
dpkg-query --status libc6 > /build/rootfs/var/lib/dpkg/status.d/libc
dpkg-query --status libcom-err2 > /build/rootfs/var/lib/dpkg/status.d/libcom-err2
dpkg-query --status libbz2-1.0 > /build/rootfs/var/lib/dpkg/status.d/libbz2
dpkg-query --status libdb5.3 > /build/rootfs/var/lib/dpkg/status.d/libdb5
dpkg-query --status libexpat1 > /build/rootfs/var/lib/dpkg/status.d/libexpat1
dpkg-query --status libffi6 > /build/rootfs/var/lib/dpkg/status.d/libffi6
dpkg-query --status libgcc1 > /build/rootfs/var/lib/dpkg/status.d/libgcc1
dpkg-query --status libgmp10 > /build/rootfs/var/lib/dpkg/status.d/libgmp10
dpkg-query --status liblz4-1 > /build/rootfs/var/lib/dpkg/status.d/liblz4
dpkg-query --status liblzma5 > /build/rootfs/var/lib/dpkg/status.d/liblzma5
dpkg-query --status libmpdec2 > /build/rootfs/var/lib/dpkg/status.d/libmpdec2
dpkg-query --status libncursesw6 > /build/rootfs/var/lib/dpkg/status.d/libncursesw6
dpkg-query --status libreadline7 > /build/rootfs/var/lib/dpkg/status.d/libreadline7
dpkg-query --status libsqlite3-0 > /build/rootfs/var/lib/dpkg/status.d/libsqlite3
dpkg-query --status libss2 > /build/rootfs/var/lib/dpkg/status.d/libss2
dpkg-query --status libssl1.1 > /build/rootfs/var/lib/dpkg/status.d/libssl1
dpkg-query --status libstdc++6 > /build/rootfs/var/lib/dpkg/status.d/libstdc
dpkg-query --status libtinfo6 > /build/rootfs/var/lib/dpkg/status.d/libtinfo6
dpkg-query --status libunistring2 > /build/rootfs/var/lib/dpkg/status.d/libunistring2
dpkg-query --status libuuid1 > /build/rootfs/var/lib/dpkg/status.d/libuuid1
dpkg-query --status libzstd1 > /build/rootfs/var/lib/dpkg/status.d/libzstd1
dpkg-query --status netbase > /build/rootfs/var/lib/dpkg/status.d/netbase
dpkg-query --status tzdata > /build/rootfs/var/lib/dpkg/status.d/tzdata
dpkg-query --status zlib1g > /build/rootfs/var/lib/dpkg/status.d/zlib1g

