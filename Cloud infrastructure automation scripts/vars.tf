variable "AWS_REGION" {    
    default = "eu-central-1"
}

# Database variables
variable "engine" {
    default = "mysql"
}
variable "engine_version" {
    default = "8.0"
}     
variable "instance_class" {
    default = "db.t3.medium"
}
variable "name"  {
    default = "mydb"
}       
variable "username" {
    default = "user1"
}  
variable "password" {
    default = "password"
} 
variable "parameter_group_name" {
    default = "default.mysql8.0"
}
