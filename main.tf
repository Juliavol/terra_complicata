resource "aws_instance" "Jenkins01" {
    ami                         = "ami-0ac019f4fcb7cb7e6"
    availability_zone           = "us-east-1a"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = "Session3_jenkins_keyPair"
    subnet_id                   = "subnet-031d59283185f0385"
    vpc_security_group_ids      = ["sg-07a6cb62ccade9c9a"]
    associate_public_ip_address = true
    private_ip                  = "10.0.0.54"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "Jenkins01"
    }
}

resource "aws_instance" "Ubuntu---tf-cluster-1--public-instance--0" {
    ami                         = "ami-0a313d6098716f372"
    availability_zone           = "us-east-1a"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = ""
    subnet_id                   = "subnet-0502121cb3d06db90"
    vpc_security_group_ids      = ["sg-019d93cbe124e2a2a"]
    associate_public_ip_address = true
    private_ip                  = "10.0.6.22"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "Ubuntu - tf-cluster-1 -public instance- 0"
    }
}

resource "aws_instance" "Ubuntu---tf-cluster-1-private-instance--0" {
    ami                         = "ami-0a313d6098716f372"
    availability_zone           = "us-east-1a"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = ""
    subnet_id                   = "subnet-06c6485754506e424"
    vpc_security_group_ids      = ["sg-019d93cbe124e2a2a"]
    associate_public_ip_address = false
    private_ip                  = "10.0.0.38"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "Ubuntu - tf-cluster-1 private-instance- 0"
    }
}

resource "aws_instance" "Jenkins_node01" {
    ami                         = "ami-0ac019f4fcb7cb7e6"
    availability_zone           = "us-east-1b"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = "Session3_jenkins_keyPair"
    subnet_id                   = "subnet-03b4fea9b94ae60a8"
    vpc_security_group_ids      = ["sg-07a6cb62ccade9c9a"]
    associate_public_ip_address = false
    private_ip                  = "10.0.3.247"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "Jenkins_node01"
    }
}

resource "aws_instance" "Ubuntu---tf-cluster-1--public-instance--1" {
    ami                         = "ami-0a313d6098716f372"
    availability_zone           = "us-east-1b"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = ""
    subnet_id                   = "subnet-0a79a078de30bceaf"
    vpc_security_group_ids      = ["sg-019d93cbe124e2a2a"]
    associate_public_ip_address = true
    private_ip                  = "10.0.7.188"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "Ubuntu - tf-cluster-1 -public instance- 1"
    }
}

resource "aws_instance" "Ubuntu---tf-cluster-1-private-instance--1" {
    ami                         = "ami-0a313d6098716f372"
    availability_zone           = "us-east-1b"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = ""
    subnet_id                   = "subnet-02aaae61b1d0f8c89"
    vpc_security_group_ids      = ["sg-019d93cbe124e2a2a"]
    associate_public_ip_address = false
    private_ip                  = "10.0.1.25"
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "Ubuntu - tf-cluster-1 private-instance- 1"
    }
}

resource "aws_vpc" "tf-cluster-1" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "tf-cluster-1"
    }
}

resource "aws_vpc" "vpc-98b709e2" {
    cidr_block           = "172.31.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
    }
}

resource "aws_vpc" "Jenkins_VPC" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = false
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Name" = "Jenkins_VPC"
    }
}

resource "aws_subnet" "subnet-03b4fea9b94ae60a8-private_subnet_slave_jenkins" {
    vpc_id                  = "vpc-0cb96b8973dd438dc"
    cidr_block              = "10.0.3.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false

    tags {
        "Name" = "private_subnet_slave_jenkins"
    }
}

resource "aws_subnet" "subnet-02aaae61b1d0f8c89-tf-cluster-1-private-us-east-1b" {
    vpc_id                  = "vpc-073c1ac516aa6b5ac"
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false

    tags {
        "Name" = "tf-cluster-1-private-us-east-1b"
    }
}

resource "aws_subnet" "subnet-0294a7e0c29ef52ef-private_subnet_jenkins" {
    vpc_id                  = "vpc-0cb96b8973dd438dc"
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "private_subnet_jenkins"
    }
}

resource "aws_subnet" "subnet-031d59283185f0385-public_subnet_jenkins" {
    vpc_id                  = "vpc-0cb96b8973dd438dc"
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "public_subnet_jenkins"
        "Description" = "DMZ"
    }
}

resource "aws_subnet" "subnet-06c6485754506e424-tf-cluster-1-private-us-east-1a" {
    vpc_id                  = "vpc-073c1ac516aa6b5ac"
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false

    tags {
        "Name" = "tf-cluster-1-private-us-east-1a"
    }
}

resource "aws_subnet" "subnet-0502121cb3d06db90-tf-cluster-1-public-us-east-1a" {
    vpc_id                  = "vpc-073c1ac516aa6b5ac"
    cidr_block              = "10.0.6.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true

    tags {
        "Name" = "tf-cluster-1-public-us-east-1a"
    }
}

resource "aws_subnet" "subnet-0a79a078de30bceaf-tf-cluster-1-public-us-east-1b" {
    vpc_id                  = "vpc-073c1ac516aa6b5ac"
    cidr_block              = "10.0.7.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true

    tags {
        "Name" = "tf-cluster-1-public-us-east-1b"
    }
}

resource "aws_security_group" "vpc-073c1ac516aa6b5ac-default" {
    name        = "default"
    description = "default VPC security group"
    vpc_id      = "vpc-073c1ac516aa6b5ac"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "vpc-0cb96b8973dd438dc-launch-wizard-1" {
    name        = "launch-wizard-1"
    description = "launch-wizard-1 created 2019-02-25T11:50:42.443+02:00"
    vpc_id      = "vpc-0cb96b8973dd438dc"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
    }

    ingress {
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "vpc-0cb96b8973dd438dc-default" {
    name        = "default"
    description = "default VPC security group"
    vpc_id      = "vpc-0cb96b8973dd438dc"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "vpc-98b709e2-default" {
    name        = "default"
    description = "default VPC security group"
    vpc_id      = "vpc-98b709e2"

    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = []
        self            = true
    }


    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_route_table" "DMZ_route_table" {
    vpc_id     = "vpc-0cb96b8973dd438dc"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-0806e5158abaf0480"
    }

    tags {
        "Name" = "DMZ_route_table"
    }
}

resource "aws_route_table" "private-tf-cluster-1-us-east-1b" {
    vpc_id     = "vpc-073c1ac516aa6b5ac"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags {
        "Name" = "private tf-cluster-1 us-east-1b"
    }
}

resource "aws_route_table" "private-tf-cluster-1-us-east-1a" {
    vpc_id     = "vpc-073c1ac516aa6b5ac"

    route {
        cidr_block = "0.0.0.0/0"
    }

    tags {
        "Name" = "private tf-cluster-1 us-east-1a"
    }
}

resource "aws_route_table" "rtb-02a232b1b2d9d0668" {
    vpc_id     = "vpc-073c1ac516aa6b5ac"

    tags {
    }
}

resource "aws_route_table" "public-tf-cluster-1-us-east-1b" {
    vpc_id     = "vpc-073c1ac516aa6b5ac"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-096a6bd4ff2257b1f"
    }

    tags {
        "Name" = "public tf-cluster-1 us-east-1b"
    }
}

resource "aws_route_table" "public-tf-cluster-1-us-east-1a" {
    vpc_id     = "vpc-073c1ac516aa6b5ac"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-096a6bd4ff2257b1f"
    }

    tags {
        "Name" = "public tf-cluster-1 us-east-1a"
    }
}

resource "aws_route_table" "rtb-7471740b" {
    vpc_id     = "vpc-98b709e2"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw-dffc11a4"
    }

    tags {
    }
}

resource "aws_route_table_association" "DMZ_route_table-rtbassoc-0e57f83e532740e35" {
    route_table_id = "rtb-070113f4d5f8b0aed"
    subnet_id = "subnet-031d59283185f0385"
}

resource "aws_route_table_association" "private-tf-cluster-1-us-east-1b-rtbassoc-040ed9f0ebcf7edbd" {
    route_table_id = "rtb-0ca9e6e6fd821a123"
    subnet_id = "subnet-02aaae61b1d0f8c89"
}

resource "aws_route_table_association" "private-tf-cluster-1-us-east-1a-rtbassoc-0591c38186d8bfbd4" {
    route_table_id = "rtb-039a949a012e6731c"
    subnet_id = "subnet-06c6485754506e424"
}

resource "aws_route_table_association" "public-tf-cluster-1-us-east-1b-rtbassoc-0046d2c932a9bb9e7" {
    route_table_id = "rtb-00df367c4e968fd54"
    subnet_id = "subnet-0a79a078de30bceaf"
}

resource "aws_route_table_association" "public-tf-cluster-1-us-east-1a-rtbassoc-04f62c6f6ac6256ab" {
    route_table_id = "rtb-0ddf1ae60dc58512e"
    subnet_id = "subnet-0502121cb3d06db90"
}

