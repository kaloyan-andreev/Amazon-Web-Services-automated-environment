#!/bin/bash

echo "Good morning. The system will be prapared for work. Do not turn it of in the next few minutes."

names='1 2 3 4 5'
 
func_1(){
     if sudo apt-get install -y adduser libfontconfig1 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_2(){
     if wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.3.2_amd64.deb 
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_3(){
     if sudo dpkg -i grafana-enterprise_9.3.2_amd64.deb
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_4(){
     if sudo systemctl daemon-reload
          then          
               echo “Success”
          else
               echo “Failure, exit status: $?”
     fi
}

func_5(){
     if sudo systemctl start grafana-server
          then
               echo “Success”
          else
               echo "Failure, exit status: $?"
     fi
}


for name in $names
    do
        func_$name
done


echo All done