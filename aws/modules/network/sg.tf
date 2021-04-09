
resource "aws_security_group" "bluecloud_velocihelk" {
  name        = "bluecloud_helk_security_group"
  description = "Allow Velociraptor and HELK traffic"
  vpc_id      = aws_vpc.bluecloud_vpc.id 
  ingress {
    from_port   = -1 
    to_port     = -1 
    protocol    = "icmp"
    cidr_blocks = [var.src_ip, var.vpc_cidr]
  }
  ingress {
    from_port   = 9092 
    to_port     = 9092 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr]
  }
  ingress {
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }
  ingress {
    from_port   = 443 
    to_port     = 443 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }
  ingress {
    from_port   = 8080 
    to_port     = 8080 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }

  ingress {
    from_port   = 8088 
    to_port     = 8088 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }

  ingress {
    from_port   = 2181 
    to_port     = 2181 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }
  ingress {
    from_port   = 8889 
    to_port     = 8889 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }
  ingress {
    from_port   = 8000 
    to_port     = 8000 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip, var.vpc_cidr] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bluecloud_velocihelk_security_group"
  }
}

resource "aws_security_group" "bluecloud_windows" {
  name        = "bluecloud_windows_security_group"
  description = "Allow traffic to Windows"
  vpc_id      = aws_vpc.bluecloud_vpc.id 
  ingress {
    from_port   = 3389 
    to_port     = 3389 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip]
  }
  ingress {
    from_port   = 5985 
    to_port     = 5985 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip]
  }
  ingress {
    from_port   = 5986 
    to_port     = 5986 
    protocol    = "tcp"
    cidr_blocks = [var.src_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bluecloud_windows_security_group"
  }
}
