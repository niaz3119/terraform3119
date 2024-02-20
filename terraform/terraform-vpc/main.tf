provider "aws" {
    region = var.region
  
}
resource "aws_vpc" "Myvpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = "ProjectVPC"
    }
  
}
resource "aws_internet_gateway" "MyIGW" {
vpc_id = aws_vpc.Myvpc.id
  
}
resource "aws_subnet" "Private_subnet" {
   vpc_id = aws_vpc.Myvpc.id
cidr_block = var.priv_cidr_block
availability_zone = var.priv_availability_zone
  
}
resource "aws_subnet" "public_subnet" {
   vpc_id = aws_vpc.Myvpc.id
cidr_block = var.pub_cidr_block
availability_zone = var.pub_availability_zone
  
}
resource "aws_route_table" "Publicroutetable"{
vpc_id = aws_vpc.Myvpc.id
tags={
    Name = var.public_route_table
}
    
}

resource "aws_route_table" "Privaterouttable"{
    vpc_id = aws_vpc.Myvpc.id
    tags ={
        Name = var.private_route_table
    }
}

resource "aws_route_table" "public_route"{
  vpc_id = aws_vpc.Myvpc.id
    tags ={
        Name = var.public_route_table
}
}

resource "aws_route" "Public_route"{
  route_table_id = aws_route_table.public_route.id
  gateway_id = aws_internet_gateway.MyIGW.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "Public_route_association"{
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "Private_route_association"{
    subnet_id = aws_subnet.Private_subnet.id
    route_table_id = aws_route_table.Privaterouttable.id
}

