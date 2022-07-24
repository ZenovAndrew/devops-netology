# Описание провайдера 
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  # Настройка backend конфигурации
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "zenov.bucket"
    region   = "ru-central1"
    key      = "terraform.tfstate"
    # ключи спрятаны в ENV
    #    access_key = 
    #    secret_key = 

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
# Описание провайдера (настройка)
provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}
