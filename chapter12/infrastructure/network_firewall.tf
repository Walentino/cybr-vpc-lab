resource "aws_networkfirewall_firewall" "main" {
  name                = "network-firewall-${var.environment}"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.main.arn
  vpc_id              = data.aws_vpc.main.id

  subnet_mapping {
    subnet_id = data.aws_subnet.firewall.id
  }
}

data "aws_vpc" "main" {
  id = "vpc-0488a892d43711307" # Your existing VPC ID
}

data "aws_subnet" "firewall" {
  id = "subnet-064cd6599825d706d" # Your existing subnet ID
}
