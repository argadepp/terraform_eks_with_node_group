resource "aws_eip" "nat" {
  count = 1
  vpc   = true
  tags  = local.tags
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  # insert the 23 required variables here
  name = "${local.environment}-${var.product}-vpc"
  cidr = local.vpc_conf.vpc_cidr_block
  public_subnets = local.vpc_conf.public_subnet_cidrs
  private_subnets = local.vpc_conf.private_subnet_cidrs
  database_subnets = local.vpc_conf.database_subnet_cidrs

  enable_dns_hostnames = true
  azs = local.env_conf.azs
  single_nat_gateway = true
  enable_nat_gateway = true
  reuse_nat_ips = true

  ########## NACLs ###########
  create_database_subnet_route_table = true
  database_dedicated_network_acl     = true
  database_inbound_acl_rules         = [{ "cidr_block" : "0.0.0.0/0", "from_port" : 0, "protocol" : "-1", "rule_action" : "allow", "rule_number" : 100, "to_port" : 0 }]
  database_outbound_acl_rules        = [{ "cidr_block" : "0.0.0.0/0", "from_port" : 0, "protocol" : "-1", "rule_action" : "allow", "rule_number" : 100, "to_port" : 0 }]
  private_dedicated_network_acl      = true
  private_inbound_acl_rules          = [{ "cidr_block" : "0.0.0.0/0", "from_port" : 0, "protocol" : "-1", "rule_action" : "allow", "rule_number" : 100, "to_port" : 0 }]
  private_outbound_acl_rules         = [{ "cidr_block" : "0.0.0.0/0", "from_port" : 0, "protocol" : "-1", "rule_action" : "allow", "rule_number" : 100, "to_port" : 0 }]
  public_dedicated_network_acl       = true
  public_inbound_acl_rules           = [{ "cidr_block" : "0.0.0.0/0", "from_port" : 0, "protocol" : "-1", "rule_action" : "allow", "rule_number" : 100, "to_port" : 0 }]
  public_outbound_acl_rules          = [{ "cidr_block" : "0.0.0.0/0", "from_port" : 0, "protocol" : "-1", "rule_action" : "allow", "rule_number" : 100, "to_port" : 0 }]
 

  external_nat_ip_ids = aws_eip.nat.*.id 

  }