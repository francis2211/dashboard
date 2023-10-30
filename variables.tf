variable "newrelic_account_id" {
  type        = number
  description = "New Relic Account Id"
  default = 1815717
}

variable "newrelic_account_api_key" {
  type        = string
  description = "New Relic Account API Key"
  default = "NRAK-I0JZZ0PKD186Z9FBP5176KLEDH9"
}

variable "accounts" {
  type    = list(string)
  default = ["675452",
            "1981818",
            "2349882",
            "315128",
            "2059782",
            "2745532",
            "1253438",
            "1905165",
            "1821312",
            "2714913",
            "3515501",
            "3377440",
            "3892361",
            "3831446",
            "504810"]
}