FROM m2o/centos
MAINTAINER alvin <zhuyuanwen@hoge.cn>
#Install Nginx
RUN yum -y install pcre-devel zlib-devel gcc gcc-c++ gcc-gfortran flex bison autoconf automake make 
RUN ln -sf /usr/share/zoneinfo/PRC /etc/localtime \
    && wget http://218.2.102.114:57624/src/nginx-1.8.0.tar.gz -O /usr/local/src/nginx-1.8.0.tar.gz \
    && tar zxf /usr/local/src/nginx-1.8.0.tar.gz  -C /usr/local/src \
    && cd /usr/local/src/nginx-1.8.0 \
    && sed -i /CFLAGS/s/*/#*/ /usr/local/src/nginx-1.8.0/auto/cc/gcc \
    && ./configure --user=www --group=www --prefix=/m2odata/server/nginx-1.8.0 --with-http_stub_status_module --with-http_sub_module \
    && make -j4 && make install \
    && rm -rf /usr/local/src/nginx-1.8.0* \
    && ln -s /m2odata/server/nginx-1.8.0 /m2odata/server/nginx \
    && echo -e "ulimit -SHn 65535 " >>/etc/rc.local 
#   && echo -e "/m2odata/server/nginx/sbin/nginx -c /m2odata/server/nginx/conf/nginx.conf " >>/etc/rc.local
EXPOSE 80 
COPY nginx.conf /m2odata/server/nginx/conf/nginx.conf
COPY fastcgi_params /m2odata/server/nginx/conf/fastcgi_params
COPY fastcgi_params /m2odata/server/nginx/conf/fcgi.conf
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
