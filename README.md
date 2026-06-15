[![CI Builds](https://github.com/dmnq-f/DiD/actions/workflows/build.yaml/badge.svg)](https://github.com/dmnq-f/DiD/actions/workflows/build.yaml)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/dmnq-f/DiD/main.svg)](https://results.pre-commit.ci/latest/github/dmnq-f/DiD/main)

# DiD - Docker in Docker Containers

This repository provides Docker images with Docker CE pre-installed and configured for various Linux distributions that can be used to test docker target systems in CI scenarios.

## Notes

- These containers require `--privileged` mode to run Docker inside Docker properly.
- All images contain systemd as the configured init system
- Published platform builds include *linux/amd64* and *linux/arm64*
- The *latest* and *latest-extra* tags on the GitHub Container Registry (GHCR) will always point to the latest version of that distro within the corresponding repository.

## Available Images

- **[ghcr.io/dmnq-f/did-alma](https://github.com/dmnq-f/DiD/pkgs/container/did-alma)**:
  - AlmaLinux 8
  - AlmaLinux 9
  - AlmaLinux 10

- **[ghcr.io/dmnq-f/did-debian](https://github.com/dmnq-f/DiD/pkgs/container/did-debian)**:
  - Debian 11 (Bullseye)
  - Debian 12 (Bookworm)
  - Debian 13 (Trixie)

- **[ghcr.io/dmnq-f/did-ubuntu](https://github.com/dmnq-f/DiD/pkgs/container/did-ubuntu)**:
  - Ubuntu 22.04 LTS (Jammy Jellyfish)
  - Ubuntu 24.04 LTS (Noble Numbat)
  - Ubuntu 26.04 LTS (Resolute Raccoon)

## Variants

All images have a *base* and an *extra* variant.

**Base** variants only add the Docker CE packages and service to the base layer and are published without any special specifiers, e.g. *did-\<distro\>:\<version\>*, *did-\<distro\>:\<codename\>* and *did-\<distro\>:latest* will point to the corresponding base images.

**Extra** variants include additional packages on top of the Docker CE package layer and are published with an *extra-* prefix in the version tags, e.g. *did-\<distro\>:\<version\>-extra*, *did-\<distro\>:\<codename\>-extra* and *did-\<distro\>:latest-extra* will point to the corresponding base images. All extra packages are installed through distribution package management and sources, thus with the latest available version for that specific distribution version:

- acl, g++, gcc, git, gpg, make
- Python3 including pip, setuptools, wheel

## Usage

In most cases, they'd be used in existing pipelines or tooling as a base image (e.g. for Ansible or as a remote development target)

To manually run a container:

```bash
docker pull ghcr.io/dmnq-f/did-ubuntu:24.04
docker run -d --privileged --name my-did-container ghcr.io/dmnq-f/did-ubuntu:24.04
```
