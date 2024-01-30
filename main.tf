# Configure terraform
terraform {
  required_version = "~> 1.0"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

# Configure the New Relic provider
provider "newrelic" {
  account_id = 1815717
  api_key = "NRAK-"   # usually prefixed with 'NRAK'
  region = "US"                    # Valid regions are US and EU
}

//locals {
//  rg = csvdecode(file("./data/account_eduardo.csv"))
//}

//output "rg" {
//  value = local.rg
//}
