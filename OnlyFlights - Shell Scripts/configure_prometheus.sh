#!/bin/bash

echo "Good morning. The system will be prapared for work. Do not turn it of in the next few minutes."

names='1 2 3 4'

func_1(){
     if for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done 
          then          
               for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
          else
               echo “Failure, exit status: $?”
     fi
}

func_2(){
     if sudo chown -R prometheus:prometheus /var/lib/prometheus/
          then          
               sudo systemctl daemon-reload
          else
               echo “Failure, exit status: $?”
     fi
}

func_3(){
     if sudo systemctl start prometheus
          then          
               sudo systemctl enable prometheus
          else
               echo “Failure, exit status: $?”
     fi
}

func_4(){
     if sudo ufw allow 9090/tcp
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

for name in $names
    do
        func_$name
done


echo All done