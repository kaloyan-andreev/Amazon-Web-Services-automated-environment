#!/bin/bash

echo "Good morning. The system will be prapared for work. Do not turn it of in the next few minutes."

names='1 2 3 4 5 6 7 8 9 10 11 12'


### 1. Updating and installing Ansible 
func_1(){
     if sudo apt-get update 
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
               echo "Enter IP address of the server you want to modify:"
               read IP
               echo -e "[Servers]\nWebServer ansible_host=$IP http_host=mydomain.local http_conf=mydomain.local.conf http_port=80" >| hosts
               cd ..
          else
               echo "Failure, exit status: $?"
     fi
}



### 3. Create ansible playbook to install Apache2 on Web Server instance
func_7(){
     if sudo mkdir /etc/ansible/playbook
          then 
               cd /etc/ansible/playbook
               
               echo "Enter IP address of the server you want to setup flask on:"
               read IP
               
               echo "---" >| config_apache.yml
               echo "- name: Ansible Playbook to Install and Setup Apache on Ubuntu" >> config_apache.yml
               echo "  hosts: Servers" >> config_apache.yml
               echo "  become: yes" >> config_apache.yml
               echo "  tasks": >> config_apache.yml
               echo "    - name: Install latest version of Apache" >> config_apache.yml
               echo "      apt: name=apache2 update_cache=yes state=latest" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: Create document root for domain configured in host variable" >> config_apache.yml
               echo "      file:" >> config_apache.yml
               echo "         path: '/var/www/{{ http_host }}'" >> config_apache.yml
               echo "         state: directory" >> config_apache.yml
               echo "         owner: www-data" >> config_apache.yml
               echo "         group: www-data" >> config_apache.yml
               echo "         mode: '0755'" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: Copy your index file" >> config_apache.yml
               echo "      template:" >> config_apache.yml
               echo "         src: '/etc/ansible/files/index-template.html'" >> config_apache.yml
               echo "         dest: '/var/www/{{ http_host }}/index.html'" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: Set up virtuahHost" >> config_apache.yml
               echo "      template:" >> config_apache.yml
               echo "         src: '/etc/ansible/files/apache-template.conf'" >> config_apache.yml
               echo "         dest: '/etc/apache2/sites-available/{{ http_conf }}'" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: Enable site" >> config_apache.yml
               echo "      command: a2ensite {{ http_conf }}" >> config_apache.yml
               echo "      notify: restart-apache" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: 'UFW firewall allow HTTP on port {{ http_port }}'" >> config_apache.yml
               echo "      ufw:" >> config_apache.yml
               echo "         rule: allow" >> config_apache.yml
               echo "         port: '{{ http_port }}'" >> config_apache.yml
               echo "         proto: tcp" >> config_apache.yml
               echo >> config_apache.yml
               echo "  handlers:" >> config_apache.yml
               echo "    - name: restart-apache" >> config_apache.yml
               echo "      service:" >> config_apache.yml
               echo "         name: apache2" >> config_apache.yml
               echo "         state: restarted" >> config_apache.yml
               echo >> config_apache.yml
               echo "- name: Install Flask module" >> config_apache.yml
               echo "  hosts: Servers" >> config_apache.yml
               echo "  become: yes" >> config_apache.yml
               echo "  tasks": >> config_apache.yml
               echo "    - name: install pip3" >> config_apache.yml
               echo "      apt:" >> config_apache.yml
               echo "         name: python3-pip" >> config_apache.yml
               echo "         update_cache: yes" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: install flask" >> config_apache.yml
               echo "      pip:" >> config_apache.yml
               echo "         executable: pip3" >> config_apache.yml
               echo "         name: flask" >> config_apache.yml
               echo "         state: latest" >> config_apache.yml
               echo >> config_apache.yml
               echo "- name: Install apache mode_wsgi module" >> config_apache.yml
               echo "  hosts: Servers" >> config_apache.yml
               echo "  become: yes" >> config_apache.yml
               echo "  tasks": >> config_apache.yml
               echo "    - name: install mod-wgs" >> config_apache.yml
               echo "      apt:" >> config_apache.yml
               echo "         name: libapache2-mod-wsgi-py3" >> config_apache.yml
               echo "         update_cache: yes" >> config_apache.yml
               echo "         state: latest" >> config_apache.yml
               echo >> config_apache.yml
               echo "- name: Generate and upload 'my_flask_app.wsgi' file" >> config_apache.yml
               echo "  hosts: Servers" >> config_apache.yml
               echo "  become: yes" >> config_apache.yml
               echo "  tasks": >> config_apache.yml
               echo "    - name: create 'my_flask_app.wsgi' file" >> config_apache.yml
               echo "      file:" >> config_apache.yml
               echo "         path: '/var/www/my_flask_app/my_flask_app.wsgi'" >> config_apache.yml
               echo "         state: touch" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: Add content to the file" >> config_apache.yml
               echo "      copy:" >> config_apache.yml
               echo "         content: |" >> config_apache.yml
               echo "              #! /usr/bin/python3.6" >> config_apache.yml
               echo >> config_apache.yml    
               echo "              import logging" >> config_apache.yml
               echo "              import sys" >>  config_apache.yml
               echo "              logging.basicConfig(stream=sys.stderr)" >> config_apache.yml
               echo "              sys.path.insert(0, '/var/www/my_flask_app/')" >> config_apache.yml
               echo "              from my_flask_app import app as application" >> config_apache.yml
               echo "              application.secret_key = 'anything you wish'" >> config_apache.yml
               echo "         dest: '/var/www/my_flask_app/my_flask_app.wsgi'" >> config_apache.yml
               echo >> config_apache.yml
               echo "- name: Generate and upload 'ExampleFlask.conf' file" >> config_apache.yml
               echo "  hosts: Servers" >> config_apache.yml
               echo "  become: yes" >> config_apache.yml
               echo "  tasks": >> config_apache.yml
               echo "    - name: create 'ExampleFlask.conf' file" >> config_apache.yml
               echo "      file:" >> config_apache.yml
               echo "         path: '/etc/apache2/sites-available/ExampleFlask.conf'" >> config_apache.yml
               echo "         state: touch" >> config_apache.yml
               echo >> config_apache.yml
               echo "    - name: Add content to the file" >> config_apache.yml
               echo "      copy:" >> config_apache.yml
               echo "         content: |" >> config_apache.yml
               echo "              <VirtualHost *:80>" >> config_apache.yml          
               echo "                   ServerName $IP" >> config_apache.yml
               echo "                   WSGIScriptAlias /testFlask /var/www/my_flask_app/my_flask_app.wsgi" >> config_apache.yml
               echo "                   <Directory /var/www/my_flask_app/>" >> config_apache.yml
               echo "                        Options FollowSymLinks" >> config_apache.yml
               echo "                        AllowOverride None" >> config_apache.yml
               echo "                        Require all granted" >> config_apache.yml
               echo "                   </Directory>" >> config_apache.yml
               echo "                   ErrorLog ${APACHE_LOG_DIR}/error.log" >> config_apache.yml
               echo "                   LogLevel warn" >> config_apache.yml
               echo "                   CustomLog ${APACHE_LOG_DIR}/access.log combined" >> config_apache.yml 
               echo "              </VirtualHost>" >> config_apache.yml
               echo "         dest: '/etc/apache2/sites-available/ExampleFlask.conf'" >> config_apache.yml

               cd ..
          else
               echo "Failure, exit status: $?"
     fi
}

func_8(){
     if sudo mkdir /etc/ansible/files
          then
               cd /etc/ansible/files
               echo "<html>" >| index-template.html
               echo "     <head>" >> index-template.html
               echo "          <title>{{ http_host }}</title>" >> index-template.html
               echo "     <head>" >> index-template.html
               echo "     <body>" >> index-template.html
               echo "          <h1>Welcome to {{ http_host }}</h1>" >> index-template.html
               echo "     </body>" >> index-template.html
               echo "</html>" >> index-template.html

               cd ..
          else
               echo "Failure, exit status: $?"
     fi
}

func_9(){
     if cd /etc/ansible/files
          then
               echo "<VirtualHost *:{{ http_port }}>" >| apache-template.conf 
               echo "    ServerAdmin webmaster@localhost" >> apache-template.conf 
               echo "    ServerName {{ http_host }}" >> apache-template.conf 
               echo "    ServerAlias www.{{ http_host }}" >> apache-template.conf 
               echo "    DocumentRoot /var/www/{{ http_host }}" >> apache-template.conf 
               echo "    ErrorLog ${APACHE_LOG_DIR}/error.log" >> apache-template.conf 
               echo "    CustomLog ${APACHE_LOG_DIR}/access.log combined" >> apache-template.conf 
               echo "</VirtualHost>" >> apache-template.conf
               
               cd ..
          else
               echo "Failure, exit status: $?"
     fi 
}


### 4. Moving flask app folder to the correct directory
func_10(){
     if sudo mv ~/'my_flask_app'/ /var/www/
          then
               echo "The trasnfer was successfull"
          else
               echo echo "Failure, exit status: $?"
     fi
}



### 5. Execute the Playbook
func_11(){
     echo "Enter private key name"
     read private_key_name
     ansible-playbook /etc/ansible/playbook/config_apache.yml --private-key $private_key_name
}



### 6. Activate Flask App web page
func_12(){
     if cd /etc/apache2/sites-available/
          then
               sudo a2ensite ExampleFlask.conf
               echo "Website has been enabled!"
          else
               echo echo "Failure, exit status: $?"
     fi
}



for name in $names
    do
        func_$name
done


echo All done
