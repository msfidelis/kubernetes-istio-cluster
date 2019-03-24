resource "aws_instance" "nodes-a" {
    count = 1
    ami = "ami-0a313d6098716f372"
    instance_type = "t2.micro"

    subnet_id = "${var.public_subnet_1a}"

    associate_public_ip_address = true

    vpc_security_group_ids = ["${aws_security_group.nodes_sg.id}"]

    key_name = "${var.cluster_key}"

    tags {
        Name        = "${var.cluster_name}-node"
        Workload    = "kubernetes"
        Role        = "node"
    }
}


resource "aws_instance" "nodes-b" {
    count = 1
    ami = "ami-0a313d6098716f372"
    instance_type = "t2.micro"

    subnet_id = "${var.public_subnet_1b}"

    associate_public_ip_address = true

    vpc_security_group_ids = ["${aws_security_group.nodes_sg.id}"]

    key_name = "${var.cluster_key}"

    tags {
        Name = "${var.cluster_name}-node"
        Workload = "kubernetes"
        Role = "node"
    }
}

resource "aws_security_group" "nodes_sg" {

  name        = "${var.cluster_name}-nodes-sg"
  description = "${var.cluster_name} cluster"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.cluster_name}-nodes-sg"
  }

}