FROM m2o/nginx
MAINTAINER alvin <zhuyuanwen@hoge.cn>
#Install Packages
RUN  yum -y install libtidy-devel freetype-devel libpng.x86_64 libjpeg-devel
RUN  wget http://218.2.102.114:57624/src/php5.3.29_p1-bin.tar.gz -O /usr/local/src/php5.3.29_p1-bin.tar.gz \
     && tar zxf /usr/local/src/php5.3.29_p1-bin.tar.gz -C /usr/local/src \
     && cd /usr/local/src/php5.3.29-bin \
     && cp -r php-5.3.29 /m2odata/server/ \
     && ln -s /m2odata/server/php-5.3.29 /m2odata/server/php \
     && \cp -f php-fpm /etc/init.d/ \
     && chown root:root /etc/rc.d/init.d/php-fpm \
     && chmod 755 /etc/rc.d/init.d/php-fpm \
     && chkconfig --add php-fpm \
     && chkconfig --level 3 php-fpm on \
     && chkconfig --level 5 php-fpm on \
     && mkdir -p /usr/local/mysqllib_php/lib/ \
     && \cp -f libmysqlclient.so.18.0.0 /usr/local/mysqllib_php/lib/ \
     && ln -s /usr/local/mysqllib_php/lib/libmysqlclient.so.18.0.0 /usr/lib64/libmysqlclient.so.18 \
     && chmod 755 /usr/local/mysqllib_php/lib/libmysqlclient.so.18.0.0 \
     && mkdir -p /usr/local/lib/ \
     && \cp -f libmcrypt.so.4.4.8 /usr/local/lib/ \
     && ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib64/libmcrypt.so.4 \
     && chmod 755 /usr/local/lib/libmcrypt.so.4.4.8 \
     && \cp -f libiconv.so.2.5.1 /usr/local/lib/ \
     && ln -s /usr/local/lib/libiconv.so.2.5.1 /usr/lib64/libiconv.so.2 \
     && chmod 755 /usr/local/lib/libiconv.so.2.5.1  \
     && rm -rf /usr/local/src/* \
     && echo -e "/etc/init.d/php-fpm start >> /etc/rc.local"
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]

