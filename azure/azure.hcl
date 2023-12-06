locals {
  org_prefix                 = "jt"
  app_dev_subscription_id    = "5284e392-c44d-444a-bf2e-07452a860241"
  app_prod_subscription_id   = "f4722c2d-47d5-4513-a562-80465e3ee813"
  app_shrd_subscription_id   = "2fab7d68-45cf-4cea-b2d6-7cf5136a80a8"
  conn_dev_subscription_id   = "3d6c3571-dbcd-47fa-a4f1-f2993adb6c90"
  conn_prod_subscription_id  = "5091f2ec-a527-4b51-8e63-9f5de65e3a66"
  conn_shrd_subscription_id  = "7366298b-6e45-4e81-903b-05d3376c6ad1"
  iden_shrd_subscription_id  = "97f65cdf-6be6-4e62-b0d2-a4b985a8f047"
  mgmt_dev_subscription_id   = "9661faf5-39f5-400b-931a-342f9240c71b"
  mgmt_prod_subscription_id  = "354a71d2-11ed-4c91-abb2-a08a2b4abe69"
  mgmt_shrd_subscription_id  = "3bdf403f-77ac-4879-8fba-fa41c2cc94ee"
  setup_prod_subscription_id = "625faac3-7208-4816-8899-7e546d0e830b"
  tf_ext_subscription_id     = "cac174dc-d598-40ea-857d-8cb88c823031"
  default_tags = {
    data-classification = "confidential"
    criticality         = "mission-critical"
    ops-commitment      = "workload-operations"
    ops-team            = "sre"
    cost-owner          = "jltaffurelli@outlook.com"
    owner               = "jltaffurelli@outlook.com"
    sla                 = "high"
  }
}
