resource "aws_networkfirewall_firewall" "main" {
  name                = "SecureInfraFirewall"
  firewall_policy_arn = "arn:aws:network-firewall:us-west-2:387974667323:firewall-policy/AllowAllTrafficPolicy"
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
