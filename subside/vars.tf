variable "region"{
    default = "us-east-1"
}
variable "vpc_cidr"{
    default = "172.16.0.0/16"
}
variable "subnet_cidr-pub" {
    type = "list"
    default = ["172.16.1.0/24","172.16.2.0/24","172.16.3.0/24","172.16.4.0/24","172.16.5.0/24","172.16.6.0/24"]
}
variable "subnet_cidr-priv" {
    type = "list"
    default = ["172.16.7.0/24","172.16.8.0/24","172.16.9.0/24","172.16.10.0/24","172.16.11.0/24","172.16.12.0/24"]   
}
data "aws_availability_zones" "azs" {}