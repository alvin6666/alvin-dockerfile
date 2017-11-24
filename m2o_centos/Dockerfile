FROM centos:6.9
MAINTAINER alvin <zhuyuanwen@hoge.cn>
#Install Packages
#Modify limit
RUN yum -y install epel-release
RUN yum -y install tar wget supervisor openssh-server \
    && sed -i /soft/s/*/#*/   /etc/security/limits.d/90-nproc.conf  \
    && echo -e "* soft nofile 65536\n* hard nofile 65536\n* soft nproc 65536\n* hard nproc 65536" >>/etc/security/limits.conf \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#Create file
RUN mkdir /m2odata  \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /m2odata/server   \
    && mkdir -p /m2odata/log/html \
    && mkdir -p /m2odata/tmp      \
    && mkdir -p /m2odata/www      \
    && mkdir -p /m2odata/sh       \
    && chmod 777 /m2odata/log     \
    && chmod 777 /m2odata/tmp     \
    && chmod 777 /m2odata/www     \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && echo "root:hogesoft" | chpasswd \
    && useradd -M -s /sbin/nologin www \
    && chown -R www:www /m2odata/log \
    && chown -R www:www /m2odata/www
COPY supervisord.conf /etc/supervisord.conf
EXPOSE 22
CMD ["/usr/bin/supervisord"]
