#########################
# FIREWALL RULE GROUPS
#########################
resource "aws_networkfirewall_rule_group" "allow_basic_traffic" {
  capacity = 100
  name     = "allow-basic-traffic"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      stateful_rule {
        action = "PASS"
        header {
          destination      = "ANY"
          destination_port = "ANY"
          protocol         = "TCP"
          direction        = "ANY"
          source_port      = "ANY"
          source           = "ANY"
        }
        rule_option { keyword = "sid:1" }
      }
    }
  }
}