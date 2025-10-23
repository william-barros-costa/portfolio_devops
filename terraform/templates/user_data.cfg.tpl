#cloud-config
ssh_pwauth: true
chpasswd:
  list: |
     ${user}:${password}
  expire: false
users:
  - name: ${user}
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: sudo
    lock_passwd: false
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_authorized_key}
