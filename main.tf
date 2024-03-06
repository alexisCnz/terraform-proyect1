resource "aws_vpc" "vpc_proyect1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc_proyect1"
  }
}
#vpc de proyecto 1
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.vpc_proyect1.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-west-2a"
    tags = {
        Name = "subnet11"
    }
  
}
#subred1 del proyecto 1
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.vpc_proyect1.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-west-2b"
    tags = {
        Name = "subnet12"
    }
  
}
#subred2 
resource "aws_internet_gateway" "proyect1_igtw" {
  vpc_id = aws_vpc.vpc_proyect1.id 
  tags = {
    Name = "proyect1_igtw"
  }
}
#tabla de enrutamiento
resource "aws_route_table" "proyect1_routetable" {
  vpc_id = aws_vpc.vpc_proyect1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.proyect1_igtw.id
  }
  tags = {
    Name = "proyect1_routetable"
  }
}
#asosiacion de la subnet1
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.proyect1_routetable.id
}
#asosiacion de la subnet 2
resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.proyect1_routetable.id
}

resource "aws_security_group" "proyect1_sg"{
  name = "proyect1_sg"
  description = "proyect1 grupo de seguridad"
  vpc_id = aws_vpc.vpc_proyect1.id

  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress  {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "aws_instance_proyecto1" {
  ami = "ami-0eb5115914ccc4bc2"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  tags = {
    Name = "aws_instance_proyecto1"
  }
}

  


