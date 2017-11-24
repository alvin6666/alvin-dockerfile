FROM m2o/nginx_php
MAINTAINER alvin <zhuyuanwen@hoge.cn>
#Install Packages
RUN  yum -y install libtidy-devel freetype-devel libpng.x86_64 libjpeg-devel
RUN  wget http://218.2.102.114:57624/src/mysql-5.5.43-linux2.6-x86_64.tar.gz -O /usr/local/src/mysql-5.5.43-linux2.6-x86_64.tar.gz \
     && wget http://218.2.102.114:57624/configfiles/my.cnf -O /etc/my.cnf \
     && tar zxf /usr/local/src/mysql-5.5.43-linux2.6-x86_64.tar.gz -C /usr/local/src \
     && mv -f /usr/local/src/mysql-5.5.43-linux2.6-x86_64 /m2odata/server/ \
     && ln -sf /m2odata/server/mysql-5.5.43-linux2.6-x86_64 /m2odata/server/mysql \
     && useradd -M -s /sbin/nologin mysql \
     && chown -R mysql:mysql /m2odata/server/mysql/ \
     && mkdir -p /m2odata/data/mysql \
     && cp -rf /m2odata/server/mysql/data/* /m2odata/data/mysql/ \
     && chown -R mysql:mysql /m2odata/data/mysql

#install necessary packages
RUN yum -y install compat-libstdc++-33.x86_64 libaio.x86_64 \
#start mysql
    && cd /m2odata/server/mysql \
    && ./scripts/mysql_install_db --user=mysql \
    && cp -f /m2odata/server/mysql/support-files/mysql.server /etc/rc.d/init.d/mysqld \
    && chown root:root /etc/rc.d/init.d/mysqld \
    && chmod 755 /etc/rc.d/init.d/mysqld \
    && chkconfig --add mysqld \
    && chkconfig mysqld on \
    && service mysqld start
#&& /m2odata/server/mysql/bin/mysql_secure_installation
EXPOSE 3306
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
