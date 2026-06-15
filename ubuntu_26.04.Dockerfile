FROM ubuntu:26.04
LABEL org.opencontainers.image.authors="Dominique Fuchs"

ARG EXTRA_PACKAGES=false

ENV LC_ALL=C
ENV DEBIAN_FRONTEND=noninteractive

# Configure systemd as the init system on top of the official, multi-arch
# ubuntu image.
RUN apt-get -y update && \
    apt-get -y install systemd systemd-sysv && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd /lib/systemd/system/sysinit.target.wants/ && rm $(ls | grep -v systemd-tmpfiles-setup) && \
    rm -f /lib/systemd/system/multi-user.target.wants/* \
        /etc/systemd/system/*.wants/* \
        /lib/systemd/system/local-fs.target.wants/* \
        /lib/systemd/system/sockets.target.wants/*udev* \
        /lib/systemd/system/sockets.target.wants/*initctl* \
        /lib/systemd/system/basic.target.wants/* \
        /lib/systemd/system/anaconda.target.wants/* \
        /lib/systemd/system/plymouth* \
        /lib/systemd/system/systemd-update-utmp*
VOLUME [ "/sys/fs/cgroup" ]

RUN apt-get -y update && apt-get -y install ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get -y update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    apt-get -y clean && \
    systemctl enable docker

RUN if [ "$EXTRA_PACKAGES" = true ]; then \
        apt-get -y update && \
        apt-get -y install \
            acl g++ gcc git gpg make \
            python3 python3-pip python3-setuptools python3-wheel && \
        apt-get -y clean; \
    fi

CMD [ "/lib/systemd/systemd" ]
