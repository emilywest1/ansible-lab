FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# install some utilty programs
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    sudo \
    vim \
    curl \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Create ansible user
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    usermod -aG sudo ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# configure ssh for Ansible use
RUN mkdir -p /var/run/sshd && \
    mkdir -p /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh && \
    chown ansible:ansible /home/ansible/.ssh

# Allow password auth so the control node can push its SSH key
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# allow SSH protocol entry
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
