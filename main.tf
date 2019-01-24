# The provider here is aws but it can be other provider

provider "aws" {
   region = "${var.region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "panasonic" {
  cidr_block  = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "us-east-1-172.16.0.0/16",
    Env  =  "Panasonic"
  }
}

# Create a way out to the internet
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.panasonic.id}"
  tags {
        Name = "InternetGateway"
    }
}

# Public route as way out to the internet
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.panasonic.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}


# Create the private route table
resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.panasonic.id}"

    tags {
        Name = "Private route table"
    }
}

# Create private route
resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

# Create an EIP for the natgateway
resource "aws_eip" "nat" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}


# Create a nat gateway and it will depend on the internet gateway creation
resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.subneT_us-east-1a.id}"
    depends_on = ["aws_internet_gateway.gw"]
}

# Create a subnet in the AZ us-east-1a
resource "aws_subnet" "subneT_us-east-1a" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "us-east-1a_Dev-Panasonic-SG_PUB"
  }
}


resource "aws_subnet" "subneT_us-east-1b" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
        Name =  "us-east-1b_Dev-Panasonic-SG_PUB"
  }
}

resource "aws_subnet" "subneT_us-east-1c" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1c"
  tags = {
        Name =  "us-east-1c_Dev-Panasonic-SG_PUB"
  }
}

resource "aws_subnet" "subneT_us-east-1d" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.4.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1d"
  tags = {
        Name =  "us-east-1d_Dev-Panasonic-SG_PUB"
  }
}

resource "aws_subnet" "subneT_us-east-1e" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.5.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1e"
  tags = {
        Name =  "us-east-1e_Dev-Panasonic-SG_PUB"
  }
}

resource "aws_subnet" "subneT_us-east-1f" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.6.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1f"
  tags = {
        Name =  "us-east-1f_Dev-Panasonic-SG_PUB"
  }
}

#############PRIV SUBNET ###############

# Create a subnet in the AZ us-east-1a
resource "aws_subnet" "PRV_subneT_us-east-1a" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.1.1/24"
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "us-east-1a_Dev-Panasonic-SG_PRIV"
  }
}

# Create a subnet in the AZ us-east-1b
resource "aws_subnet" "PRV_subneT_us-east-1b" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.2.1/24"
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "us-east-1b_Dev-Panasonic-SG_PRIV"
  }
}

# Create a subnet in the AZ us-east-1c
resource "aws_subnet" "PRV_subneT_us-east-1c" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.3.1/24"
  availability_zone = "us-east-1c"
  tags = {
  	Name =  "us-east-1c_Dev-Panasonic-SG_PRIV"
  }
}

# Create a subnet in the AZ us-east-1d
resource "aws_subnet" "PRV_subneT_us-east-1d" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.4.1/24"
  availability_zone = "us-east-1d"
  tags = {
  	Name =  "us-east-1d_Dev-Panasonic-SG_PRIV"
  }
}

# Create a subnet in the AZ us-east-1e
resource "aws_subnet" "PRV_subneT_us-east-1e" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.5.1/24"
  availability_zone = "us-east-1e"
  tags = {
  	Name =  "us-east-1e_Dev-Panasonic-SG_PRIV"
  }
}

# Create a subnet in the AZ us-east-1f
resource "aws_subnet" "PRV_subneT_us-east-1f" {
  vpc_id                  = "${aws_vpc.panasonic.id}"
  cidr_block              = "172.16.6.1/24"
  availability_zone = "us-east-1f"
  tags = {
        Name =  "us-east-1f_Dev-Panasonic-SG_PRIV"
  }
}




# Associate subnet  to PUBLIC TABLE  ##############################################
resource "aws_route_table_association" "subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.subneT_us-east-1a.id}"
    route_table_id = "${aws_vpc.panasonic.main_route_table_id}"
}

resource "aws_route_table_association" "subnet_eu_west_1b_association" {
    subnet_id = "${aws_subnet.subneT_us-east-1b.id}"
    route_table_id = "${aws_vpc.panasonic.main_route_table_id}"
}

resource "aws_route_table_association" "subnet_eu_west_1c_association" {
    subnet_id = "${aws_subnet.subneT_us-east-1c.id}"
    route_table_id = "${aws_vpc.panasonic.main_route_table_id}"
}

resource "aws_route_table_association" "subnet_eu_west_1d_association" {
    subnet_id = "${aws_subnet.subneT_us-east-1d.id}"
    route_table_id = "${aws_vpc.panasonic.main_route_table_id}"
}

resource "aws_route_table_association" "subnet_eu_west_1e_association" {
    subnet_id = "${aws_subnet.subneT_us-east-1e.id}"
    route_table_id = "${aws_vpc.panasonic.main_route_table_id}"
}
resource "aws_route_table_association" "subnet_eu_west_1f_association" {
    subnet_id = "${aws_subnet.subneT_us-east-1f.id}"
    route_table_id = "${aws_vpc.panasonic.main_route_table_id}"
}

# Associate subnet  to PRIVATE TABLE  #############################################
resource "aws_route_table_association" "PRV_subnet_eu_west_1a_association" {
    subnet_id = "${aws_subnet.PRV_subneT_us-east-1a.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "PRV_subnet_eu_west_1b_association" {
    subnet_id = "${aws_subnet.PRV_subneT_us-east-1b.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "PRV_subnet_eu_west_1c_association" {
    subnet_id = "${aws_subnet.PRV_subneT_us-east-1c.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "PRV_subnet_eu_west_1d_association" {
    subnet_id = "${aws_subnet.PRV_subneT_us-east-1d.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "PRV_subnet_eu_west_1e_association" {
    subnet_id = "${aws_subnet.PRV_subneT_us-east-1e.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_route_table_association" "PRV_subnet_eu_west_1f_association" {
    subnet_id = "${aws_subnet.PRV_subneT_us-east-1f.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}

##configure SG for IBS 

resource "aws_security_group" "websg" {
  name = "vpc_test_web"
  description = "Allow incoming SSH access from IBS"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["103.251.140.226/32"]
    self = "true"
  }
    lifecycle {
create_before_destroy = true
}

  

vpc_id = "${aws_vpc.panasonic.id}"
  tags {
    Name = "IBS Web Server SG"
  }
}


resource "aws_security_group_rule" "ssh" {
security_group_id = "${aws_security_group.websg.id}"
type = "ingress"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

################################################################ SCALING #######################################
resource "aws_launch_configuration" "webcluster" {
  name_prefix   = "panasonic-lc"
  image_id      = "ami-1853ac65"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.websg.id}"]

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_autoscaling_group" "scalegroup" {
launch_configuration = "${aws_launch_configuration.webcluster.name}"
availability_zones = ["${data.aws_availability_zones.azs.names}"]
min_size = 1
max_size = 4
enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
metrics_granularity="1Minute"
load_balancers= ["${aws_elb.elb1.id}"]
health_check_type="ELB"
tag {
key = "Name"
value = "terraform-asg-example"
propagate_at_launch = true
}
}


### ADD ELB ###################################################################
resource "aws_autoscaling_policy" "autopolicy" {
name = "terraform-autoplicy"
scaling_adjustment = 1
adjustment_type = "ChangeInCapacity"
cooldown = 300
autoscaling_group_name = "${aws_autoscaling_group.scalegroup.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpualarm" {
alarm_name = "terraform-alarm"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = "60"

dimensions {
AutoScalingGroupName = "${aws_autoscaling_group.scalegroup.name}"
}

alarm_description = "This metric monitor EC2 instance cpu utilization"
alarm_actions = ["${aws_autoscaling_policy.autopolicy.arn}"]
}

#
resource "aws_autoscaling_policy" "autopolicy-down" {
name = "terraform-autoplicy-down"
scaling_adjustment = -1
adjustment_type = "ChangeInCapacity"
cooldown = 300
autoscaling_group_name = "${aws_autoscaling_group.scalegroup.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
alarm_name = "terraform-alarm-down"
comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = "10"

dimensions {
AutoScalingGroupName = "${aws_autoscaling_group.scalegroup.name}"
}

alarm_description = "This metric monitor EC2 instance cpu utilization"
alarm_actions = ["${aws_autoscaling_policy.autopolicy-down.arn}"]
}



resource "aws_security_group" "elbsg" {
name = "security_group_for_elb"
ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

lifecycle {
create_before_destroy = true
}
}

resource "aws_elb" "elb1" {
name = "terraform-elb"
availability_zones = ["${data.aws_availability_zones.azs.names}"]
security_groups = ["${aws_security_group.elbsg.id}"]
access_logs {
bucket = "elb-log.davidwzhang.com"
bucket_prefix = "elb"
interval = 5
}
listener {
instance_port = 80
instance_protocol = "http"
lb_port = 80
lb_protocol = "http"
}
health_check {
healthy_threshold = 2
unhealthy_threshold = 2
timeout = 3
target = "HTTP:80/"
interval = 30
}

cross_zone_load_balancing = true
idle_timeout = 400
connection_draining = true
connection_draining_timeout = 400

tags {
Name = "terraform-elb"
}
}

resource "aws_lb_cookie_stickiness_policy" "cookie_stickness" {
name = "cookiestickness"
load_balancer = "${aws_elb.elb1.id}"
lb_port = 80
cookie_expiration_period = 600
}


  
#############################################################################################
output "elb_dns_name" {
  value = "${aws_elb.elb1.dns_name}"
}
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${aws_vpc.panasonic.cidr_block}"
}
output "details subnet-public 1" {
  description = "subnet-pub-1a"
  value       = "${aws_subnet.subneT_us-east-1a.cidr_block}"
}
output "details subnet-public 2" {
  description = "subnet-pub-1b"
  value       = "${aws_subnet.subneT_us-east-1b.cidr_block}"
}
output "details subnet-public 3" {
  description = "subnet-pub-1c"
  value       = "${aws_subnet.subneT_us-east-1c.cidr_block}"
}

output "details subnet-public 4" {
  description = "subnet-pub-1d"
  value       = "${aws_subnet.subneT_us-east-1d.cidr_block}"
}
output "details subnet-public 5" {
  description = "subnet-pub-1e"
  value       = "${aws_subnet.subneT_us-east-1e.cidr_block}"
}

output "details subnet-public 6" {
  description = "subnet-pub-1f"
  value       = "${aws_subnet.subneT_us-east-1f.cidr_block}"
}
output "details subnet-private 1" {
  description = "subnet-private-d"
  value       = "${aws_subnet.PRV_subneT_us-east-1d.cidr_block}"
}
output "details subnet-private 2" {
  description = "subnet-private-e"
  value       = "${aws_subnet.PRV_subneT_us-east-1e.cidr_block}"
}
output "details subnet-private 3" {
  description = "subnet-private-f"
  value       = "${aws_subnet.PRV_subneT_us-east-1f.cidr_block}"
}

output "details subnet-private 4" {
  description = "subnet-private-d"
  value       = "${aws_subnet.PRV_subneT_us-east-1a.cidr_block}"
}

output "details subnet-private 5" {
  description = "subnet-private-d"
  value       = "${aws_subnet.PRV_subneT_us-east-1b.cidr_block}"
}

output "details subnet-private 6" {
  description = "subnet-private-d"
  value       = "${aws_subnet.PRV_subneT_us-east-1c.cidr_block}"
}





