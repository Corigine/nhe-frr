#set Current folder path
CUR_PATH=$(cd `dirname $0`;pwd)

#1.apt install Dependent Library
apt update
apt-get install -y git autoconf automake libtool make libreadline-dev texinfo pkg-config libpam0g-dev libjson-c-dev bison flex python3-pytest libc-ares-dev python3-dev libsystemd-dev python-ipaddress python3-sphinx install-info build-essential libsystemd-dev libsnmp-dev perl libcap-dev libelf-dev chrpath debhelper librtr-dev libpcre2-dev cmake protobuf-c-compiler libprotobuf-c-dev libzmq5 libzmq3-dev

cd $CUR_PATH/
#2.set environment variable
export MY_INSTALL_DIR=/usr
mkdir -p $MY_INSTALL_DIR
export PATH="$MY_INSTALL_DIR/bin:$PATH"

#3.update cmake-3.19.6
cd third_party/cmake-3.19.6/
sh cmake-linux.sh -- --skip-license --prefix=$MY_INSTALL_DIR

#6.make grpc v1.46.x
cd /
if [ -d "/grpc" ]; then
    cd grpc/
else
    git clone -b v1.46.x http://10.9.4.88:3001/sdwan/grpc.git
    cd grpc/
fi

tar -zxvf third_party.tar.gz
sleep 10s

mkdir -p cmake/build
pushd cmake/build
make clean
cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR ../..
make -j
make install

cp /usr/lib/x86_64-linux-gnu/libprotobuf.a /usr/lib/
cp /usr/lib/x86_64-linux-gnu/libz.a /usr/lib/
cp /usr/lib/x86_64-linux-gnu/libabsl_bad_optional_access.a /usr/lib/

chmod 777 -R /usr/lib/*

cd $CUR_PATH/
#7.dpkg install linyang2
cd third_party/libyang2_2.0.112.1-1/
dpkg -i libyang2_2.0.112.1-1_amd64.deb
dpkg -i libyang2-dev_2.0.112.1-1_amd64.deb

#8.init frr user group
groupadd -r -g 92 frr
groupadd -r -g 85 frrvty
adduser --system --ingroup frr --home /var/run/frr/ --gecos "FRR suite" --shell /sbin/nologin frr
usermod -a -G frrvty frr

