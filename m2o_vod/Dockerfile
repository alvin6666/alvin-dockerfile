FROM m2o/centos
MAINTAINER alvin <zhuyuanwen@hoge.cn>
#Install Packages
COPY Hoge.repo /etc/yum.repos.d/Hoge.repo
RUN mkdir -p /m2odata/www/video.app.m2o \
    && mkdir -p /m2odata/www/video.app.m2o/mp4 \
    && mkdir -p /m2odata/www/video.app.m2o/uploads \
    && chmod -Rf 777 /m2odata/www/video.app.m2o \
    && chown -Rf nobody.nobody /m2odata/www/video.app.m2o
RUN yum -y install m2o_vod_nginx \
    && mkdir /usr/local/m2o_vod_nginx/conf/conf.d
COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /usr/local/m2o_vod_nginx/conf/nginx.conf
COPY fastcgi_params /usr/local/m2o_vod_nginx/conf/fastcgi_params
COPY fastcgi_params /usr/local/m2o_vod_nginx/conf/fcgi.conf
COPY vod.conf /usr/local/m2o_vod_nginx/conf/conf.d/vod.conf
CMD ["/usr/bin/supervisord"]
EXPOSE 80
