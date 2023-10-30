
resource "newrelic_dashboard" "example" {
  name        = "LATAM [Eduardo] Consumption test"
  permissions = "PUBLIC_READ_WRITE"
}

resource "newrelic_dashboard_page" "ingest" {
  dashboard_id = newrelic_dashboard.example.id
  name        = "Ingest"
}

resource "newrelic_dashboard_page" "users" {
  dashboard_id = newrelic_dashboard.example.id
  name        = "Users"
}

resource "newrelic_dashboard_widget" "ingest_by_customer" {
  dashboard_id = newrelic_dashboard.example.id
  page_id     = newrelic_dashboard_page.ingest.id
  title       = "Ingest by Customer"
  layout {
    column = 1
    row    = 1
    width  = 3
    height = 6
  }
  visualization_id = "viz.bar"
  linked_entity_guids = ["MTgxNTcxN3xWSVp8REFTSEJPQVJEfDExMTkwMTcw"]
  raw_configuration = jsonencode({
    facet = {
      showOtherSeries = false
    }
    nrqlQueries = [
      {
        accountIds = [1815717]
        query      = "FROM NrConsumption SELECT rate(sum(BytesIngested), 1 month) AS 'Ingest/mo' where nr.aggregationEntityId is NULL AND nr.billableEntityId in ({{account_id}}) and masterAccountName in ({{account_name}}) facet masterAccountName, nr.billableEntityId since 1 month ago"
      }
    ]
    platformOptions = {
      ignoreTimeRange = false
    }
  })
}

# Define other widgets and pages here...

# Define variables
resource "newrelic_dashboard_variable" "account_name" {
  name                 = "account_name"
  dashboard_id         = newrelic_dashboard.example.id
  type                 = "NRQL"
  is_multi_selection   = true
  replacement_strategy = "STRING"
  default_values = [
    {
      value = {
        string = "*"
      }
    }
  ]
  nrql_query {
    account_ids = [1815717]
    query = "FROM NrConsumption SELECT uniques(masterAccountName) where nr.billableEntityId in (3424112,2395354,3403345,3515501,825536,497919,1975063,1981818,2985553,401732,611,2772960,3561975,3575332,3626552,504810,1002752,2725311,2160178,3367014,1845173,3630916,3047070,2745532,2349882,3270870,3217744,315128,1537749,3377440,960733) since 1 month ago"
  }
}

resource "newrelic_dashboard_variable" "account_id" {
  name                 = "account_id"
  dashboard_id         = newrelic_dashboard.example.id
  type                 = "NRQL"
  is_multi_selection   = true
  replacement_strategy = "NUMBER"
  default_values = [
    {
      value = {
        string = "*"
      }
    }
  ]
  nrql_query {
    account_ids = [1815717]
    query = "FROM NrConsumption SELECT uniques(nr.billableEntityId) where nr.billableEntityId in (3424112,2395354,3403345,3515501,825536,497919,1975063,1981818,2985553,401732,611,2772960,3561975,3575332,3626552,504810,1002752,2725311,2160178,3367014,1845173,3630916,3047070,2745532,2349882,3270870,3217744,315128,1537749,3377440,960733) since 1 month ago"
  }
}

# Define other variables here...
