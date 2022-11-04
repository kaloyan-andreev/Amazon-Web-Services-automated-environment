!#/bin/bash

names='1 2'

echo "Enter private key name:"
read private_key_name

### 1. Transfering Ansible Key Pair file to the Web Server
func_1(){
     scp -r -i "C:/Users/user/Desktop/$private_key_name" "C:/Users/user/Desktop/$private_key_name" ubuntu@ec2-3-74-167-19.eu-central-1.compute.amazonaws.com:~
}



### 2. Transfering Flask Application to the Web Server
func_2(){
     scp -r -i $private_key_name "C:/Users/user/Desktop/my_flask_app" ubuntu@ec2-3-74-167-19.eu-central-1.compute.amazonaws.com:~
}



for name in $names
    do
        func_$name
done

echo "All done"

