subnet_type                = "public-private"
domain                     = "clouddrove.ca"
records                    = []
hub_destination_cidr       = ["10.11.0.0/16", "10.12.0.0/16"]
vpn_cidr_block             = "172.16.0.0/16"
resource_share_account_ids = ["******", "*****"] # Add account id of all other accounts where to Peer