FROM centos:7

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

RUN yum -y install yum-plugin-fastestmirror
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install ansible
RUN yum -y install vim yum-utils yum-plugin-priorities \
	java-1.8.0-openjdk-devel openssl tree curl wget bzip2 zlib \
	readline python-devel sudo expect psmisc libtirpc-devel redhat-lsb nc \
	openssh-server openssh-clients openssh-askpass net-tools \
    ntp krb5-workstation krb5-lib libadm5 \
    sssd sssd-client sssd-ldap openldap-clients oddjob-mkhomedir sssd-krb5 sssd-tools authconfig \
    pam_ldap nss_ldap \
    cyrus-sasl cyrus-sasl-gssapi cyrus-sasl-ldap cyrus-sasl-md5 cyrus-sasl-plain \
	; yum clean all

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# 리얼 서버의 시간 동기화
# RUN systemctl enable ntp.service

ARG USERNAME=ambari
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
RUN groupadd --gid ${USER_GID} ${USERNAME} \
	&& useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
	&& echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
	&& chmod 0440 /etc/sudoers.d/${USERNAME}

COPY autopass.exp /usr/local/bin/
RUN chmod +x /usr/local/bin/autopass.exp
RUN /usr/local/bin/autopass.exp root root

COPY keymake.exp /usr/local/bin/
RUN chmod +x /usr/local/bin/keymake.exp
COPY keydeploy.exp /usr/local/bin/
RUN chmod +x /usr/local/bin/keydeploy.exp
COPY node-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/node-setup.sh
