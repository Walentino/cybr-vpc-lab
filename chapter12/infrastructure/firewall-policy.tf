#########################
# FIREWALL POLICY
#########################
resource "aws_networkfirewall_firewall_policy" "main" {
  name = "network-firewall-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:pass"]
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.allow_basic_traffic.arn
    }
  }
}