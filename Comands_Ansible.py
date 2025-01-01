# Directorie ansible
cd /etc/ansible
ansible.cfg   host  roles


# Hosts create distros
# ex:
[distros]
192.168.0.110
192.168.0.1120

[distros:vars]
ansible_user=root
ansible_password=root


# edit ansible.cfg
host_key_checking = false   -------discoment



#test conection
ansible distros -m ping


# execution of comands to distros
ansible distros -a "[comand]"

# create playbook.yml ex:
---
- name: install the nginx       //play name
  host: distros                 // group name in hosts
  become: yes                   // privileges sudo
  tasks:                        // modules tasks
  - name: Install web server    // tasks name
    package:
     name: nginx                //package name
     state: present             // stage could be: present, absent, latest


     # create playbook.yml for script ex:
---
- name: execute HealthCheck       //play name
  host: distros                 // group name in hosts
  become: yes                   // privileges sudo
  tasks:                        // modules tasks
  - name: running script    // tasks name
    script: /tmp/HC_FULL/KHC.sh
    register: result
  - debug:
    var: result.stdout_lines


    #   execute playbook
    ansible-playbook playbook.yml
dqm@24vncdqm@24vnc

    SAHSADPORA003
hda0421,sahsadpora003
SAHSADPORA003
[22/09/2023 00:39] Lucas Nunes Queiroz
ssh root@unxorasp100
 ssh oracle@172.16.81.12
10.111.134.101
oracle@unxorasp100
lc5735240@172.16.84.67
g00d2talk4MYSEL#