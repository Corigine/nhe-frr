#set Current folder path
CUR_PATH=$(cd `dirname $0`;pwd)

cd $CUR_PATH/
cd ..
#1.frr code update
git submodule update --remote

cd $CUR_PATH/
#2.frr make
make clean
./bootstrap.sh
./configure \
    --prefix=/usr \
    --includedir=\${prefix}/include \
    --enable-exampledir=\${prefix}/share/doc/frr/examples \
    --bindir=\${prefix}/bin \
    --sbindir=\${prefix}/lib/frr \
    --libdir=\${prefix}/lib/frr \
    --libexecdir=\${prefix}/lib/frr \
    --localstatedir=/var/run/frr \
    --sysconfdir=/etc/frr \
    --with-moduledir=\${prefix}/lib/frr/modules \
    --with-libyang-pluginsdir=\${prefix}/lib/frr/libyang_plugins \
    --enable-configfile-mask=0640 \
    --enable-logfile-mask=0640 \
    --enable-snmp=agentx \
    --enable-multipath=64 \
    --enable-user=frr \
    --enable-group=frr \
    --enable-vty-group=frrvty \
    --with-pkg-git-version \
    --enable-systemd=yes \
    --enable-doc-html --enable-ripd --enable-ripngd --enable-ldpd --enable-bgpd --enable-eigrpd --enable-gcc-rdynamic --enable-watchfrr  --enable-vtysh --enable-backtrace --enable-ospfapi --enable-ospfclient --enable-isisd --enable-snmp --enable-multipath=6 --enable-shell-access --disable-sysrepo --enable-fpm --enable-protobuf --enable-grpc

make
make install

#3.install frr config files
install -m 775 -o frr -g frr -d /var/log/frr
install -m 775 -o frr -g frrvty -d /etc/frr
install -m 640 -o frr -g frr /dev/null /etc/frr/zebra.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/bgpd.conf
install -m 640 -o frr -g frrvty /dev/null /etc/frr/vtysh.conf
install -m 755 tools/frr /etc/init.d/frr
install -m 640 -o frr -g frrvty tools/etc/frr/vtysh.conf /etc/frr/vtysh.conf
install -m 640 -o frr -g frr tools/etc/frr/frr.conf /etc/frr/frr.conf
install -m 640 -o frr -g frr tools/etc/frr/daemons.conf /etc/frr/daemons.conf
install -m 640 -o frr -g frr tools/etc/frr/daemons /etc/frr/daemons
install -m 640 -o frr -g frr /dev/null /etc/frr/ospfd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ospf6d.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/isisd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ripd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ripngd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/pimd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/ldpd.conf
install -m 640 -o frr -g frr /dev/null /etc/frr/nhrpd.conf

install -m 644 tools/frr.service /etc/systemd/system/frr.service
systemctl enable frr
service frr start

#4.packet frr debian
dpkg-buildpackage -rfakeroot -b -us -uc -Ppkg.frr.nortrlib

#5.tar packet
cd ..

pkt_name="nhe_c_frr_8.2"
mkdir $pkt_name
chmod 777 $pkt_name
cd $pkt_name/
mkdir dependent-library
chmod 777 dependent-library
cd ..

mv frr_* frr-* $pkt_name/
cp frr/frr_install.sh $pkt_name/
cp frr/third_party/libyang2_2.0.112.1-1/libyang2_2.0.112.1-1_amd64.deb $pkt_name/dependent-library/
cp frr/third_party/libyang2_2.0.112.1-1/libyang2-dev_2.0.112.1-1_amd64.deb $pkt_name/dependent-library/

cp frr/dependent-library/gdb_9.2-0ubuntu1_20.04.1_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libbabeltrace1_1.5.8-1build1_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libc6-dev_2.31-0ubuntu9.7_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libc-ares2_1.15.0-1ubuntu0.1_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libc-dev-bin_2.31-0ubuntu9.7_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libcrypt-dev_4.4.10-10ubuntu4_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libdw1_0.176-1.1build1_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libjs-jquery_3.3.1~dfsg-3_all.deb $pkt_name/dependent-library/
cp frr/dependent-library/libjs-underscore_1.9.1~dfsg-1ubuntu0.20.04.1_all.deb $pkt_name/dependent-library/
cp frr/dependent-library/libmysqlclient21_8.0.29-0ubuntu0.20.04.3_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libpcre2-16-0_10.34-7_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libpcre2-32-0_10.34-7_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libpcre2-dev_10.34-7_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libpcre2-posix2_10.34-7_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libprotobuf-c1_1.3.3-1_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libsensors5_3.6.0-2ubuntu1.1_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libsensors-config_3.6.0-2ubuntu1.1_all.deb $pkt_name/dependent-library/
cp frr/dependent-library/libsnmp35_5.8+dfsg-2ubuntu2.3_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/libsnmp-base_5.8+dfsg-2ubuntu2.3_all.deb $pkt_name/dependent-library/
cp frr/dependent-library/linux-libc-dev_5.4.0-121.137_amd64.deb $pkt_name/dependent-library/
cp frr/dependent-library/mysql-common_5.8+1.0.5ubuntu2_all.deb $pkt_name/dependent-library/

chmod 777 $pkt_name/*

tar -zcvf $pkt_name.tar.gz ./$pkt_name/
chmod 777 $pkt_name.tar.gz

rm -rf $pkt_name/
