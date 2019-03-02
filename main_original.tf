# Setup the region in which to work.
provider "aws" {
  region = "us-east-1"
}


# Create a VPC to run our system in
resource "aws_vpc" "experiment" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true

  tags {
    Name = "tf-cluster-1"
  }
}

resource "aws_subnet" "private" {
  count                           = "2"
  availability_zone               = "${element(data.aws_availability_zones.available.names, count.index)}"
  cidr_block                      = "${cidrsubnet(aws_vpc.experiment.cidr_block, 8, count.index)}"
  vpc_id                          = "${aws_vpc.experiment.id}"

  tags = {
    Name = "tf-cluster-1-private-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

resource "aws_subnet" "public" {
  count                           = "2"
  availability_zone               = "${element(data.aws_availability_zones.available.names, count.index)}"
  cidr_block                      = "${cidrsubnet(aws_vpc.experiment.cidr_block, 8, count.index + length(data.aws_availability_zones.available.names))}"
  map_public_ip_on_launch         = true
  vpc_id                          = "${aws_vpc.experiment.id}"

  tags = {
    Name = "tf-cluster-1-public-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}

# Grab the list of availability zones
data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.experiment.id}"

  tags {
    Name = "tf-cluster-1-main-gw"
  }
}


resource "aws_eip" "nat" {
  count      = "2"
  vpc        = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "gw" {
  count         = "2"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    Name = "NAT tf-cluster-1 ${element(aws_subnet.public.*.availability_zone, count.index)}"
  }

  depends_on = ["aws_eip.nat"]
}



resource "aws_route_table" "public" {
  count  = "2"
  vpc_id = "${aws_vpc.experiment.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "public tf-cluster-1 ${element(aws_subnet.public.*.availability_zone, count.index)}"
  }
}

resource "aws_route_table" "private" {
  count  = "2"
  vpc_id = "${aws_vpc.experiment.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.gw.*.id, count.index)}"
  }

  tags {
    Name = "private tf-cluster-1 ${element(aws_subnet.public.*.availability_zone, count.index)}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "2"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

resource "aws_route_table_association" "private" {
  count          = "2"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}


# Create an aws public instance with ubuntu on it
resource "aws_instance" "public-ubuntu" {
  count = 2
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  associate_public_ip_address = true

  user_data = <<EOF
#!/bin/bash
sudo apt update
EOF

  tags {
    Name = "Ubuntu - tf-cluster-1 -public instance- ${count.index}"
  }

  depends_on = ["aws_subnet.private", "aws_subnet.public"]
}

# Create an aws private instance with ubuntu on it
resource "aws_instance" "private-ubuntu" {
  count = 2
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${element(aws_subnet.private.*.id, count.index)}"

  user_data = <<EOF
#!/bin/bash
sudo apt update

EOF

  tags {
    Name = "Ubuntu - tf-cluster-1 private-instance- ${count.index}"
  }

  depends_on = ["aws_subnet.private", "aws_subnet.public"]
}

# The url for our load balancer
output "ubuntu1" {
  value = "${element(aws_instance.public-ubuntu.*.public_ip, 0)}"
}

output "ubuntu2" {
  value = "${element(aws_instance.public-ubuntu.*.public_ip, 1)}"
}