!#/bin/bash

names='1 2 3'

echo "Enter Admin's Private Key name:"
read private_key_name

### 1. Transfering Ansible Key Pair file to the Admin machine
func_1(){
     scp -r -i "C:/Users/user/Desktop/OnlyFlights/$private_key_name" "C:/Users/user/Desktop/OnlyFlights/$private_key_name" ec2-3-126-108-245.eu-central-1.compute.amazonaws.com:~
}



### 2. Transfering Shell scripts to the Admin machine
func_2(){
     scp -r -i "C:/Users/user/Desktop/OnlyFlights/$private_key_name" "C:\Users\user\Desktop\GitLab\semester-3-case-study-project\OnlyFlights - Shell Scripts" ec2-3-126-108-245.eu-central-1.compute.amazonaws.com:~
}

### 3. Transfering Shell scripts to the Admin machine
func_3(){
     scp -r -i "C:/Users/user/Desktop/OnlyFlights/$private_key_name" "C:\Users\user\Desktop\GitLab\semester-3-case-study-project\OnlyFlights - Ansible Playbooks" ec2-3-126-108-245.eu-central-1.compute.amazonaws.com:~
}


for name in $names
    do
        func_$name
done

echo "All done"