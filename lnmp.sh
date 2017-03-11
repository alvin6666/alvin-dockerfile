#!/bin/bash
#auto make install LNMP
#by alvin 2016年6月25日

#nginx define path variable

N_FILES=nginx-1.8.1.tar.gz
N_FILES_DIR=nginx-1.8.1
N_URL=http://nginx.org/download
DW_DIR=/usr/local/src
N_PREFIX=/lnmp/server

if [ -z "$1" ]
then
	echo -e "\033[36mPlease select Install Menu follow:\033[0m"
        echo -e "\033[32m1)编译安装nginx服务器\033[1m"
        echo -e "\033[36m2)编译安装php服务器\033[0m"
        echo -e "\033[36m3)编译安装mysql服务器\033[0m"
	echo -e "\033[31musage: { /bin/sh $0 1|2|3|help}\033[0m"
exit
fi

if [ "$1" -eq 1 ]
then
	cd $DW_DIR
	wget -c $N_URL/$N_FILES && tar zxf $N_FILES  && cd $DW_DIR/$N_FILES_DIR ;
	./configure --user=www --group=www --prefix=$N_PREFIX/$N_FILES_DIR --with-http_stub_status_module --with-http_sub_module --with-http_mp4_module

	if [ $? -eq 0 ]
	then
		make && make install
		echo -e "\033[32mThe nginx install successfully!\033[0m"
	else
		echo -e "\033[32mFailed!!!\033[0m"
		exit
	fi
fi

#auto install mysql

M_FILES=mysql-5.5.43.tar.gz
M_FILES_DIR=mysql-5.5.43
M_URL=http://downloads.mysql.com/archives/get/file
DW_DIR=/usr/local/src
M_PREFIX=/lnmp/server

if [ "$1" -eq 2 ]
then
        cd $DW_DIR
        wget -c $M_URL/$M_FILES && tar zxf $M_FILES  && mv $M_FILES_DIR $M_PREFIX &&  cd $M_PREFIX/$M_FILES_DIR && yum install cmake -y;
	cmake . -DCMAKE_INSTALL_PREFIX=$M_PREFIX/$M_FILES_DIR 
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DMYSQL_DATADIR=/lnmp/data \
-DSYSCONFDIR=/etc \
-DMYSQL_USER=mysql \
-DMYSQL_TCP_PORT=3306 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DEXTRA_CHARSETS=gbk,gb2312,utf8,ascii \
-DENABLED_LOCAL_INFILE=ON \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
-DWITHOUT_PARTITION_STORAGE_ENGINE=1 \
-DWITH_FAST_MUTEXES=1 \
-DWITH_ZLIB=bundled \
-DENABLED_LOCAL_INFILE=1 \
-DWITH_READLINE=1 \
-DWITH_EMBEDDED_SERVER=1 \
-DWITH_DEBUG=0
make && make install

        if [ $? -eq 0 ]
        then
                make && make install
                echo -e "\033[32mThe MYSQL install successfully!\033[0m"
        else
                echo -e "\033[32mFailed!!!\033[0m"
                exit
        fi
ln -s $M_PREFIX/$M_FILES_DIR $M_PREFIX/mysql

cp -f ./support-files/mysql.server /etc/rc.d/init.d/mysqld
chown root:root /etc/rc.d/init.d/mysqld
chmod 755 /etc/rc.d/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on
service mysqld start

fi
#auto install php
#php define path variable

P_FILES=php-5.3.29.tar.gz
P_FILES_DIR=php-5.3.29
P_URL=http://cn2.php.net/get/php-5.3.29.tar.gz/from/this/mirror
DW_DIR=/usr/local/src
P_PREFIX=/lnmp/server

if [ "$1" -eq 3 ]
then
        cd $DW_DIR
        wget -c $P_URL -O php-5.3.29.tar.gz && tar zxf $P_FILES  && cd $DW_DIR/$P_FILES_DIR ;
        ./configure --prefix=$P_PREFIX/$P_FILES_DIR --with-config-file-path=/lnmp/server/php/etc --enable-fpm --with-fpm-user=nobody --with-fpm-group=nobody --with-pcre-regex --with-zlib --with-bz2 --enable-calendar --with-curl --enable-dba --with-libxml-dir --enable-ftp --with-gd --with-jpeg-dir --with-png-dir --with-zlib-dir --with-freetype-dir --enable-gd-native-ttf --with-mhash --enable-mbstring --enable-shmop --enable-sockets --enable-zip --with-openssl --with-mcrypt --enable-soap --enable-sysvsem --enable-sysvshm --with-iconv-dir=/usr/local --disable-rpath --enable-bcmath --enable-exif --disable-ipv6 --with-tidy

        if [ $? -eq 0 ]
        then
                make && make install
                echo -e "\033[32mThe php install successfully!\033[0m"
        else
                echo -e "\033[32mFailed!!!\033[0m"
                exit
        fi
fi


