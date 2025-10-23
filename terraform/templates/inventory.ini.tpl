[cluster]
%{ for address in addresses ~}
${address}
%{ endfor ~}

[cluster:variables]
ansible_user=${user}
ansible_ssh_private_key_file=${ssh_key_path}
