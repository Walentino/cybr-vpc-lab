#########################
# VPC CONFIGURATION
#########################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "NetworkFirewallVPC" }
}

resource "aws_subnet" "firewall" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = element(var.availability_zones, count.index)
  tags              = { Name = "NetworkFirewallSubnet-${count.index}" }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "MainIGW" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "PublicRouteTable" }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "subnet_assoc" {
  count          = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.firewall[count.index].id
  route_table_id = aws_route_table.public.id
}