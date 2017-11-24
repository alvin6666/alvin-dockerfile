FROM m2o/centos
MAINTAINER alvin <zhuyuanwen@hoge.cn>
#Install Packages
COPY Hoge.repo /etc/yum.repos.d/Hoge.repo
RUN yum -y install hoge_ffmpeg hoge_tsmanager hoge_nginx
RUN wget http://yum.hogesoft.com:8100/pyrtmp-0.0.5.tar.gz -O /m2odata/server/pyrtmp-0.0.5.tar.gz \
    && wget http://yum.hogesoft.com:8100/ffmpeg -O /m2odata/server/ffmpeg \
    && chmod +x /m2odata/server/ffmpeg \
    && cd /m2odata/server \
    && tar -xvzf /m2odata/server/pyrtmp-0.0.5.tar.gz \
    && mkdir -p /m2odata/data/pyrtmp \
    && mkdir -p /m2odata/log/pyrtmp \
    && mkdir -p /m2odata/dvr \
    && cd /m2odata/server \
    && ln -sf //m2odata/server/pyrtmp-0.0.5 /m2odata/server/pyrtmp \
    && cd /m2odata/server/pyrtmp && ./manage  db upgrade

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
EXPOSE 80
