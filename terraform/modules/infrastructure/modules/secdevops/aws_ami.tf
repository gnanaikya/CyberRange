data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "kali" {
  most_recent = true

  filter {
    name   = "name"
    values = ["kali*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["paravirtual"]
  }

  owners = ["679593333241"]
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
//
//
//// direct import from https://github.com/clong/DetectionLab
//# Use Data Sources to resolve the AMI-ID for the pre-built DC host
//data "aws_ami" "dc_ami" {
//  owners = ["505638924199"]
//  filter {
//    name = "tag:Name"
//    values = ["dc"]
//  }
//  filter {
//    name = "image-id"
//    values = ["${var.dc_ami}"]
//  }
//}
//
//# Use Data Sources to resolve the AMI-ID for the pre-built WEF host
//data "aws_ami" "wef_ami" {
//  owners = ["505638924199"]
//  most_recent = true
//  filter {
//    name = "tag:Name"
//    values = ["wef"]
//  }
//  filter {
//    name = "image-id"
//    values = ["${var.wef_ami}"]
//  }
//}

//# Use Data Sources to resolve the AMI-ID for the pre-built Win10 host
//data "aws_ami" "win10_ami" {
//  owners = ["505638924199"]
//  most_recent = true
//  filter {
//    name = "tag:Name"
//    values = ["win10"]
//  }
//  filter {
//    name = "image-id"
//    values = ["${var.win10_ami}"]
//  }
//}
//
//# If you are building your own AMIs, replace the default values below with
//# the AMI IDs
//variable "logger_ami" {
//  default = "*"
//}
//variable "dc_ami" {
//  default = "*"
//}
//variable "wef_ami" {
//  default = "*"
//}
//variable "win10_ami" {
//  default = "*"
//}


//todo: make python script or erb template to create desired public assets
variable "ami_winchoco" {
  description = "The ami of the windows chocolatey desktop"
  default     = "ami-3e768644"
}


variable "ami_fristileaks" {
  default     = "ami-0539fa87bb2306efe"
  description = "FristiLeaks_1.3"
}

variable "ami_mrrobot" {
  default     = "ami-067d428e8151617b0"
  description = "mrRobot"
}

variable "ami_sickos" {
  default     = "ami-0af37127c6324f3f4"
  description = "Sick0s1.2"
}

variable "ami_vulnos" {
  default     = "ami-0b5b15c7c25534a9c"
  description = "VulnOSv2"
}

variable "ami_stapler" {
  default     = "ami-0cbf02480a95b6edd"
  description = "Stapler"
}

variable "ami_ms3_2k8" {
  default     = "ami-0da37791afc9aea77"
  description = "metasploitable3-win2k8"
}

variable "ami_ms3_nix" {
  default     = "ami-05056794734905857"
  description = "metasploitable3-ubuntu-1404"
}

variable "ami_ms3_2k12" {
  default     = "ami-0370dcc12619f05e1"
  description = "metasploitable3-win2k12"
}

variable "ami_skytower" {
  default     = "ami-0edaa47a082e55340"
  description = "SkyTower"
}
# public kali image
variable "ami_kali-old" {
  default     = "ami-07360d1b1c9e13198"
  description = "Kali-2018.3"
}

# private kali image
variable "ami_kali" {
  default     = "ami-0e13b2fb6e590fc77"
  description = "Kali-2019.1"
}

# clean template win7 asset
variable "ami_win7" {
  default     = "ami-02f2c19a14caca250"
  description = "Win7"
}

# clean template win8 asset
variable "ami_win8" {
  default     = "ami-0de7687b932832df7"
  description = "Win8"
}

# seed lab vm from Syr.edu
variable "ami_seed_ubuntu1604" {
  default     = "ami-0ebb80088327d57fc"
  description = "seed-ubuntu-1604"
}
#
variable "ami_hackinos" {
  default     = "ami-0d3b2e68e1701a861"
  description = "hack-in-os"
}

#
variable "ami_r7" {
  default     = "ami-0911621222a8c9590"
  description = "r7vm"
}

#
variable "ami_nessus" {
  default     = "ami-08eacb613e5117551"
  description = "Nessus"
}

#
variable "ami_was" {
  default     = "ami-082347635d1dcc9fa"
  description = "WebApp Scanner"
}

#
variable "ami_nnm" {
  default     = "ami-0bd120b2cee2fe956"
  description = "Nessus Network Monitor"
}

#
variable "ami_sc" {
  default     = "ami-0278263968295c6e8"
  description = "security center"
}

//-- new
variable "ami_myhouse7" {
  default     = "ami-016b701c461d2f341"
  description = "myhouse7"
}

variable "ami_bulldog" {
  default     = "ami-088907da57ded04b2"
  description = "bulldog"
}

variable "ami_defender_win2k10" {
  default     = "ami-0ba457e31b3666965"
  description = "defender-win2010"
}

//variable "ami_ms3_2k12" {
//  default     = "ami-0370dcc12619f05e1"
//  description = "metasploitable3-win2k12"
//}

variable "ami_win2003"{
  description = "The ami of the Windows_Server-2003-R2_SP2-English-32Bit-Base-2019.02.13 server asset"
  default = "ami-09ca0032099efb5a8"
}

variable "ami_win2008"{
  description = "The ami of the Windows_Server-2008-R2_SP1-English-64Bit-SQL_2008_R2_SP3_Express-2019.03.13 server asset"
  default = "ami-039be681c6acc0443"
}

variable "ami_win2012"{
  description = "The ami of the Windows_Server-2012-RTM-English-64Bit-SQL_2012_SP4_Express-2019.03.13 server asset"
  default = "ami-0c25c3d407774dfdc"
}

variable "ami_win2012_RTM"{
  description = "The ami of the Windows_Server-2012-R2_RTM-English-64Bit-SQL_2016_SP2_Express-2019.03.13 server asset"
  default = "ami-00e4f149aa6ba8fcc"
}

variable "ami_win2016"{
  description = "The ami of the Windows_Server-2016-English-Full-ECS_Optimized-2017.11.24 server asset"
  default = "ami-9f1182e5"
}

variable "ami_win2019"{
  description = "The ami of the Windows_Server-2019-English-Full-Base-2019.03.13 server asset"
  default = "ami-02d43577e47e684d9"
}
