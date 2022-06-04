data "yandex_iam_policy" "admin" {
  binding {
    role = "admin"

    members = [
      "userAccount:user_id_1",
    ]
  }

  binding {
    role = "viewer"

    members = [
      "userAccount:user_id_2",
    ]
  }
}
data "yandex_iam_service_account" "builder" {
  service_account_id = "sa_id"
}
data "yandex_resourcemanager_cloud" "foo" {
  name = "cloud"
}

output "cloud_create_timestamp" {
  value = "${data.yandex_resourcemanager_cloud.foo.created_at}"
} 

resource "yandex_iam_service_account" "sa" {
  name        = "VM Manager"
  description = "service account to manage VMs"
}
