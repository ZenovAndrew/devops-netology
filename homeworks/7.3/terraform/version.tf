terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "zenov.bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "*****************kgSJ86-jiN0"
    secret_key = "**************HWnlqvSzaPsbCkQ0JliHZH6A"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
