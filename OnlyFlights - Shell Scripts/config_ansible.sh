#!/bin/bash

echo "Good morning. The system will be prapared for work. Do not turn it of in the next few minutes."

names='1 2 3 4 5 6'

### 1. Updating and installing Ansible 
func_1(){
     if sudo apt update 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_2(){
     if sudo apt install software-properties-common 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_3(){
     if sudo add-apt-repository --yes --update ppa:ansible/ansible 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_4(){
     if sudo apt install ansible
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}



### 2. Configure ansible host file and ansible.cfg file
func_5(){
     if cd /etc/ansible/
          then
               echo -e "[Defaults]\nhost_key_checking = False" >| ansible.cfg
               cd ..
          else
               echo "Failure, exit status: $?"
     fi
}

func_6(){
     if cd /etc/ansible/
          then
               echo "Enter IP address of GitLab Runner:"
               read IP1
               echo "Enter IP address of OpenVPN:"
               read IP2
               echo -e "[Servers]\nGitLab_Runner ansible_host=$IP1" >| hosts
               echo -e "[Servers]\nOpenVPN ansible_host=$IP2"  >| hosts
1               cd ..
          else
               echo "Failure, exit status: $?"
     fi
}


for name in $names
    do
        func_$name
done


echo All done
