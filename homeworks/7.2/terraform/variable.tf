# первоначальная настройка утилитой yc init
# токен берем из https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
# информация из вывода утилиты yc config list

# ID облака
variable "yandex_cloud_id" {
  default = "b1g9ndtf5btu3mfnm9nm"
}

# Folder ID облака
variable "yandex_folder_id" {
  default = "b1g1nf0tap4272dp18no"
}


#Зона размещения инфраструктуры по-умолчанию
variable "yandex_zone_default" {
  default = "ru-central1-a"
}

#Токен присваиваем переменной ENV TF_VAR_yandex_token
variable "yandex_token" {
  type = string
}

# ID берем из вывода команды yc compute image list --folder-id standard-images | grep ubuntu
variable "ubuntu" {
  default = "fd8iofc8jffgt2qs0eco"
}
