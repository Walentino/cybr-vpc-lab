resource "aws_networkfirewall_firewall_policy" "AllowAllTrafficPolicy" {
  name = "AllowAllTrafficPolicy"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:pass"]

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:us-west-2:387974667323:stateful-rule-group/ExampleRuleGroup"
    }
  }
}

resource "aws_networkfirewall_firewall" "main" {
  name                = "SecureInfraFirewall"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.AllowAllTrafficPolicy.arn
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
