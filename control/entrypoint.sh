#!/bin/bash
set -e

NODES=("192.168.10.11" "192.168.10.12" "192.168.10.13" "192.168.10.14")
ANSIBLE_USER="ansible"
ANSIBLE_PASS="ansible"
PUB_KEY=$(cat /root/.ssh/ansible_id.pub)

for node in "${NODES[@]}"; do
  until ssh -o StrictHostKeyChecking=no -o ConnectTimeout=2 \
        -i /root/.ssh/ansible_id \
        ${ANSIBLE_USER}@${node} true 2>/dev/null; do
    sshpass -p "${ANSIBLE_PASS}" ssh \
      -o StrictHostKeyChecking=no -o ConnectTimeout=2 \
      ${ANSIBLE_USER}@${node} \
      "mkdir -p ~/.ssh && echo '${PUB_KEY}' >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys" \
      2>/dev/null && break || sleep 2
  done
  echo "    node ${node} ready"
done