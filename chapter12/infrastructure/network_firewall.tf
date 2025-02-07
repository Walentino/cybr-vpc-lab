#########################
# FIREWALL INSTANCE
#########################
resource "aws_networkfirewall_firewall" "main" {
  name                = "SecureInfraFirewall"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.main.arn
  vpc_id              = aws_vpc.main.id

  subnet_mapping {
    subnet_id = aws_subnet.firewall[0].id
  }
}