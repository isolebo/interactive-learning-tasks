
//creates subnets
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Team        = "DevOps"
    Environment = "Dev"
  }

}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Team        = "DevOps"
    Environment = "Dev"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]


  tags = {
    Team        = "DevOps"
    Environment = "Dev"
  }
}

//creates an eip address
resource "aws_eip" "example_eip" {
  vpc = true
}



//creates a natgateway
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example_eip.id
  subnet_id     = aws_subnet.subnet1.id
}




resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.private.id


}