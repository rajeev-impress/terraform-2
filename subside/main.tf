provider "aws" {
    region = "${var.region}"
}


resource "aws_vpc" "panasonic" {
    cidr_block  = "${var.vpc_cidr}"
    instance_tenancy = "default"
    tags{
        Name = "Pansonic-DEV"    
    }
}

resource "aws_subnet" "pub-subnets"{
 count = "${length(data.aws_availability_zones.azs.names)}"
 vpc_id = "${aws_vpc.panasonic.id}"
 cidr_block = "${element(var.subnet_cidr-pub,count.index)}"
 availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
 map_public_ip_on_launch = true
 tags{
     Name = "PUB-Subnet-${count.index+1}"
 }
}

 resource "aws_subnet" "prv-subnets"{
 count = "${length(data.aws_availability_zones.azs.names)}"
 vpc_id = "${aws_vpc.panasonic.id}"
 cidr_block = "${element(var.subnet_cidr-priv,count.index)}"
 availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
 tags{
     Name = "PRIV-Subnet-${count.index+1}"
 }

}