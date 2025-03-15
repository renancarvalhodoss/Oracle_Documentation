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