#########################
# OUTPUTS
#########################
output "firewall_id" {
  value = aws_networkfirewall_firewall.main.id
}

output "firewall_policy_arn" {
  value = aws_networkfirewall_firewall_policy.main.arn
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.firewall[*].id
}