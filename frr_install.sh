#set Current folder path
CUR_PATH=$(cd `dirname $0`;pwd)

cd $CUR_PATH/
cd dependent-library/
#1.apt install Dependent Library
sudo dpkg -i libpcre2-posix2_10.34-7_amd64.deb
sudo dpkg -i libpcre2-32-0_10.34-7_amd64.deb
sudo dpkg -i libpcre2-16-0_10.34-7_amd64.deb
sudo dpkg -i libcrypt-dev_4.4.10-10ubuntu4_amd64.deb
sudo dpkg -i linux-libc-dev_5.4.0-121.137_amd64.deb
sudo dpkg -i libc-dev-bin_2.31-0ubuntu9.7_amd64.deb
sudo dpkg -i libc6-dev_2.31-0ubuntu9.7_amd64.deb
sudo dpkg -i libpcre2-dev_10.34-7_amd64.deb
sudo dpkg -i libyang2_2.0.112.1-1_amd64.deb
sudo dpkg -i libyang2-dev_2.0.112.1-1_amd64.deb
sudo dpkg -i libprotobuf-c1_1.3.3-1_amd64.deb
sudo dpkg -i libc-ares2_1.15.0-1ubuntu0.1_amd64.deb
sudo dpkg -i libjs-underscore_1.9.1~dfsg-1ubuntu0.20.04.1_all.deb
sudo dpkg -i libjs-jquery_3.3.1~dfsg-3_all.deb
sudo dpkg -i libsnmp-base_5.8+dfsg-2ubuntu2.3_all.deb
sudo dpkg -i libsensors-config_3.6.0-2ubuntu1.1_all.deb
sudo dpkg -i libsensors5_3.6.0-2ubuntu1.1_amd64.deb
sudo dpkg -i mysql-common_5.8+1.0.5ubuntu2_all.deb
sudo dpkg -i libmysqlclient21_8.0.29-0ubuntu0.20.04.3_amd64.deb
sudo dpkg -i libsnmp35_5.8+dfsg-2ubuntu2.3_amd64.deb
sudo dpkg -i libdw1_0.176-1.1build1_amd64.deb
sudo dpkg -i libbabeltrace1_1.5.8-1build1_amd64.deb
sudo dpkg -i gdb_9.2-0ubuntu1_20.04.1_amd64.deb

cd ..
#3.dpkg -i frr*.deb
sudo dpkg -i *.deb
