data "aws_ami" "debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "http" "my_ip" {
  url = "https://api.ipify.org"
}

locals {
  my_cidr = "${chomp(data.http.my_ip.response_body)}/32"
  name    = "novasphere-${var.owner}"
}

resource "aws_key_pair" "main" {
  key_name   = "${local.name}-key"
  public_key = file(pathexpand(var.ssh_public_key_path))
}

# En S2 etape 5, la source devient :
# source = "git::https://github.com/<vous>/terraform-aws-ec2-server.git?ref=v1.0.0"
module "web" {
  source = "./modules/ec2-server"

  name          = "web"
  ami_id        = data.aws_ami.debian.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name
  admin_cidr    = local.my_cidr
  open_ports    = [80]
}

module "monitoring" {
  source = "./modules/ec2-server"

  name          = "monitoring"
  ami_id        = data.aws_ami.debian.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name
  admin_cidr    = local.my_cidr
  open_ports    = []
  tags          = { Tier = "ops" }
}

# Refactoring sans destruction : les ressources de S1 changent d'adresse
moved {
  from = aws_instance.web
  to   = module.web.aws_instance.this
}

moved {
  from = aws_security_group.web
  to   = module.web.aws_security_group.this
}

resource "local_file" "inventory" {
  filename             = "${path.module}/../ansible/inventory.ini"
  file_permission      = "0644"
  directory_permission = "0755"
  content = templatefile("${path.module}/inventory.tftpl", {
    web_ip        = module.web.public_ip
    monitoring_ip = module.monitoring.public_ip
  })
}
