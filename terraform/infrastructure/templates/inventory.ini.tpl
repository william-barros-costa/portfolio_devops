[master]
%{ for vm in vms ~}
%{ if vm.name == "master" ~}
${vm.name} ansible_host=${addresses[vm.name]}
%{endif ~}
%{ endfor ~}

[worker]
%{ for vm in vms ~}
%{ if vm.name != "master" ~}
${vm.name} ansible_host=${addresses[vm.name]}
%{endif ~}
%{ endfor ~}

[cluster:children]
master
worker

[cluster:vars]
ansible_user=${user}
ansible_ssh_private_key_file=${ssh_key_path}
