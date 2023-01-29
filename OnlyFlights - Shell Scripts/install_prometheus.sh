#!/bin/bash

echo "Good morning. The system will be prapared for work. Do not turn it of in the next few minutes."

names='1 2 3 4 5 6 7 8 9'

func_1(){
     if sudo groupadd --system prometheus 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_2(){
     if sudo useradd -s /sbin/nologin --system -g prometheus prometheus 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_3(){
     if sudo mkdir /var/lib/prometheus
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_4(){
     if for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_5(){
     if sudo apt update
          then
               sudo apt -y install wget curl vim
          else
               echo "Failure, exit status: $?"
     fi
}

func_6(){
     if mkdir -p /tmp/prometheus && cd /tmp/prometheus
          then
               curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
          else
               echo "Failure, exit status: $?"
     fi
}

func_7(){
     if tar xvf prometheus*.tar.gz
          then
               cd prometheus*/
          else
               echo "Failure, exit status: $?"
     fi
}

func_8(){
     if sudo mv prometheus promtool /usr/local/bin/
          then
               sudo mv prometheus.yml /etc/prometheus/prometheus.yml
          else
               echo "Failure, exit status: $?"
     fi
}

func_9(){
     if sudo mv consoles/ console_libraries/ /etc/prometheus/
          then
               cd ~
          else
               echo "Failure, exit status: $?"
     fi
}


for name in $names
    do
        func_$name
done


echo All done