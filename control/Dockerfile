FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ansible \
    openssh-client \
    sshpass \
    iputils-ping \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN ssh-keygen -t ed25519 -f /root/.ssh/ansible_id -N "" && \
    chmod 700 /root/.ssh

RUN printf 'Host 192.168.10.*\n  IdentityFile /root/.ssh/ansible_id\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n' \
    > /root/.ssh/config && chmod 600 /root/.ssh/config

COPY inventory /ansible/inventory
COPY ansible.cfg /ansible/ansible.cfg

RUN mkdir -p /ansible/vault
COPY vault /ansible/vault

RUN mkdir -p /ansible/playbooks
COPY playbooks /ansible/playbooks

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /ansible
CMD ["/entrypoint.sh"]
