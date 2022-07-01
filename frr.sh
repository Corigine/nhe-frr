#set Current folder path
CUR_PATH=$(cd `dirname $0`;pwd)

cd $CUR_PATH/

#1.frr init
./frr_init.sh

#2.frr package
./frr_package.sh

