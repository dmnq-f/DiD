FROM almalinux/9-init:9.8
LABEL org.opencontainers.image.authors="Dominique Fuchs"

ARG EXTRA_PACKAGES=false

RUN dnf -y update && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf -y config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    dnf -y clean all && \
    rm -rf /var/cache/dnf && \
    systemctl enable docker

RUN if [ "$EXTRA_PACKAGES" = true ]; then \
        dnf -y install \
            acl g++ gcc git gpg make \
            python3 python3-pip python3-pip-wheel python3-setuptools python3-setuptools-wheel && \
        dnf -y clean all && \
        rm -rf /var/cache/dnf; \
    fi
