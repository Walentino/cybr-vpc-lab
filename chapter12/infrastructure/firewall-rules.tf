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
        rule_option {
          keyword = "sid:1"
        }
      }

      stateful_rule {
        action = "PASS"
        header {
          destination      = "ANY"
          destination_port = "ANY"
          protocol         = "UDP"
          direction        = "ANY"
          source_port      = "ANY"
          source           = "ANY"
        }
        rule_option {
          keyword = "sid:2"
        }
      }

      stateful_rule {
        action = "PASS"
        header {
          destination      = "ANY"
          destination_port = "ANY"
          protocol         = "ICMP"
          direction        = "ANY"
          source_port      = "ANY"
          source           = "ANY"
        }
        rule_option {
          keyword = "sid:3"
        }
      }
    }
  }
}

resource "aws_networkfirewall_firewall_policy" "main" {
  name = "allow-basic-traffic-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.allow_basic_traffic.arn
    }
  }
}
