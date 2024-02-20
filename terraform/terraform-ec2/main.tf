provider "aws" {
    region = var.region
}
resource "aws_instance" "ServerTest1" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = var.Name
    }
}

