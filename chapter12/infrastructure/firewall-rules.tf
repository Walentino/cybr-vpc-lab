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
      # New security rules
      rules_string = <<EOF
# Block known malicious user agents
alert http any any -> any any (msg:"Suspicious User Agent Detected"; flow:established,to_server; http.user_agent; content:"malicious-agent"; sid:1000001; rev:1;)

# Detect SQL injection attempts
alert http any any -> any any (msg:"SQL Injection Attempt"; flow:established,to_server; http.uri; content:"union"; nocase; pcre:"/union.*select/i"; sid:1000002; rev:1;)

# Block outbound connections to known malicious IPs
alert ip any any -> 192.0.2.0/24 any (msg:"Connection to Known Bad IP"; sid:1000003; rev:1;)

# Detect potential data exfiltration
alert http any any -> any any (msg:"Large POST Detection"; flow:established,to_server; http.method; content:"POST"; http.content_len:>1000000; sid:1000004; rev:1;)
EOF
    }
  }
}