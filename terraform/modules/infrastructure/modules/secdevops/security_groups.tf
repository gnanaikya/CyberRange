resource "aws_security_group" "tpot" {
  name        = "T-Pot"
  description = "T-Pot Honeypot"
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 0
    to_port     = 64294
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 64295
    to_port     = 64295
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 64297
    to_port     = 64297
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 64298
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all traffic from the private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "T-Pot"
  }
}

resource "aws_security_group" "fbctf" {
  name        = "FB-CTF"
  description = "FaceBook Capture The Flag"
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Allow all traffic from the private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name                    = "FB-CTF-${count.index}"
    Environment             = "${var.environment}"
    Terraform               = "True"
    Zombie                  = "True"
    Initialization_Complete = "True"
  }
}

resource "aws_security_group" "kali" {
  name        = "kali"
  description = "kali"
  vpc_id      = "${var.vpc-id}"


  # terminal/ssh rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # vnc rule
  ingress {
    from_port   = 5901
    to_port     = 5901
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # just open up everything else
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.ip_list}"]
  }
  # Allow all traffic from the private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name        = "kali-${count.index}"
    Environment = "${var.environment}"
    Terraform   = "True"
  }
}

#WebGoat security group rules
resource "aws_security_group" "webgoat" {
  name        = "webgoat-instances"
  description = "Access to webgoat instances"
  vpc_id      = "${var.vpc-id}"

  # terminal/ssh rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # terminal/ssh rule
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # inbound rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Allow all traffic from the private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.ip_list}"]
  }
  tags = {
    Name        = "webgoat-instances"
    Environment = "${var.environment}"
    Terraform   = "True"
    Zombie      = "false"
    verified    = "false"
  }
}

resource "aws_security_group_rule" "allow_all_between_webgoat_and_kali" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.webgoat.id}"
}

resource "aws_security_group_rule" "allow_all_between_kali_and_webgoat" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kali.id}"
}

// import from https://github.com/clong/DetectionLab
resource "aws_security_group" "logger" {
  name        = "logger_security_group"
  description = "DetectionLab: Security Group for the logger host"
  vpc_id      = "${var.vpc-id}"

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Splunk access
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Fleet access
  ingress {
    from_port   = 8412
    to_port     = 8412
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Caldera access
  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Allow all traffic from the private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
// import from https://github.com/clong/DetectionLab
resource "aws_security_group" "windows" {
  name        = "windows_security_group"
  description = "DetectionLab: Security group for the Windows hosts"
  vpc_id      = "${var.vpc-id}"

  # RDP
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # WinRM
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Windows ATA
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_list}"]
  }

  # Allow all traffic from the private subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}