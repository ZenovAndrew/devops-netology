# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
2. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 


## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
	
	```
	


```
#ошибка инициализации без VPN
vagrant@test1:~/7.3$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Reusing previous version of terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex from the dependency lock file
╷
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: failed to query provider mirror
│ https://terraform-mirror.yandexcloud.net/ for registry.terraform.io/yandex-cloud/yandex: the request failed after 2
│ attempts, please try again later: Get
│ "https://terraform-mirror.yandexcloud.net/registry.terraform.io/yandex-cloud/yandex/index.json": dial tcp: lookup
│ terraform-mirror.yandexcloud.net on 127.0.0.53:53: server misbehaving
╵

╷
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider
│ terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex: could not connect to
│ terraform-registry.storage.yandexcloud.net: Failed to request discovery document: Get
│ "https://terraform-registry.storage.yandexcloud.net/.well-known/terraform.json": dial tcp: lookup
│ terraform-registry.storage.yandexcloud.net on 127.0.0.53:53: server misbehaving
```

```
#подключил VPN

vagrant@test1:~/7.3$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
- Reusing previous version of terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex from the dependency lock file
- Installing yandex-cloud/yandex v0.75.0...
- Installed yandex-cloud/yandex v0.75.0 (unauthenticated)
- Using previously-installed terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex v0.72.0

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

	```
2. Создайте два воркспейса `stage` и `prod`.

```
vagrant@test1:~/7.3$ terraform workspace new stage
vagrant@test1:~/7.3$ terraform workspace new prod
vagrant@test1:~/7.3$ terraform workspace select prod
```
3. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
4. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
5. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
6. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
7. При желании поэкспериментируйте с другими параметрами и рессурсами.




В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.
```
vagrant@test1:~/7.3$ terraform workspace list
  default
* prod
  stage


```
* Вывод команды `terraform plan` для воркспейса `prod`.  

```


vagrant@test1:~/7.3$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "test-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8iofc8jffgt2qs0eco"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm[1] will be created
  + resource "yandex_compute_instance" "vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "test-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8iofc8jffgt2qs0eco"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm_for_each["netology_1"] will be created
  + resource "yandex_compute_instance" "vm_for_each" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "netology_1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd83n3uou8m03iq9gavu"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 1
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm_for_each["netology_2"] will be created
  + resource "yandex_compute_instance" "vm_for_each" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "netology_2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd83n3uou8m03iq9gavu"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-1 will be created
  + resource "yandex_vpc_subnet" "subnet-1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```



``` 
# terraform apply c ошибкой, хотя plan ok! 

vagrant@test1:~/7.3$ terraform apply
yandex_vpc_network.network-1: Refreshing state... [id=enpq71c7bui6ls8plcmr]
yandex_vpc_subnet.subnet-1: Refreshing state... [id=e9bvpt1n80en2027ch2j]
yandex_compute_instance.vm[0]: Refreshing state... [id=fhm2unr37q32ls7sksfs]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have
affected this plan:

  # yandex_vpc_network.network-1 has been deleted
  - resource "yandex_vpc_network" "network-1" {
      - id         = "enpq71c7bui6ls8plcmr" -> null
        name       = "network1"
        # (4 unchanged attributes hidden)
    }

  # yandex_vpc_subnet.subnet-1 has been deleted
  - resource "yandex_vpc_subnet" "subnet-1" {
      - id             = "e9bvpt1n80en2027ch2j" -> null
        name           = "subnet1"
        # (7 unchanged attributes hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes,
the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "test-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8iofc8jffgt2qs0eco"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm_for_each["netology_1"] will be created
  + resource "yandex_compute_instance" "vm_for_each" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "netology_1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd83n3uou8m03iq9gavu"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 1
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm_for_each["netology_2"] will be created
  + resource "yandex_compute_instance" "vm_for_each" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj5UzFyvrMCF00SKNFRu6bLlLMNaCapR+H4u4oG53Qrt9o/FSpgyYBDt5gXvT9tysWZLK27YscINJT44Qjhz3FA7mruCCPobSuxkpdTPuWIlJM4DPgZ1o0ybl6TyfMV6DlCKCZwUh4KKNBMkvFJCyP1DlPMYqaFn63WStZQNJd0Mt/SvBBzOK3uKN9PB+Dul07gZkAgKOzvmpNo6UXZNxvNxX8jqefs3D3dw6LIvxRrngPAgSC3wECPI/bTZ/lwbBuVBEKH2HdjnpVQZePJJb4HNrMLekgMouD6c52pVI4rONYKiNfjEeGXq/NKiotKSMywWmmNZmL45IW3fxBZDjThMSAouAjTiaw6raqnl9t+ee8pDkYU9Dz6MrznLPrDTI3h8LksGPLIW3lk8kusZGlIfPqN26ita8Gqvvkg/89e775iuWBGfOykOYJXtCMOWmt5IKkptnGuhgbsoY6rDLVdDmFgZl3ie7PZWrL2VuJIYlP7B7smP1BIfMi+UzSIOU= vagrant@test1
            EOT
        }
      + name                      = "netology_2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd83n3uou8m03iq9gavu"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-1 will be created
  + resource "yandex_vpc_subnet" "subnet-1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions in workspace "stage"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.network-1: Creating...
yandex_vpc_network.network-1: Creation complete after 3s [id=enpqks8nfbapt1qkldv8]
yandex_vpc_subnet.subnet-1: Creating...
yandex_vpc_subnet.subnet-1: Creation complete after 1s [id=e9bf5kjnqpdg663258du]
yandex_compute_instance.vm[0]: Creating...
yandex_compute_instance.vm_for_each["netology_1"]: Creating...
yandex_compute_instance.vm_for_each["netology_2"]: Creating...
yandex_compute_instance.vm[0]: Still creating... [10s elapsed]
yandex_compute_instance.vm[0]: Still creating... [20s elapsed]
yandex_compute_instance.vm[0]: Still creating... [30s elapsed]
yandex_compute_instance.vm[0]: Still creating... [40s elapsed]
yandex_compute_instance.vm[0]: Still creating... [50s elapsed]
yandex_compute_instance.vm[0]: Still creating... [1m0s elapsed]
yandex_compute_instance.vm[0]: Creation complete after 1m8s [id=fhmeicafor4esjrskm64]
╷
│ Error: Error while requesting API to create instance: server-request-id = 6201e167-9826-4d43-b29a-1f19f2c56286 server-trace-id = 6777efb90a436e86:ebf591584794b4f:6777efb90a436e86:1 client-request-id = 64abe911-ecf3-40f8-b196-ca758bd44bef client-trace-id = 05029466-2cbc-4303-97b1-eadbeb5074a0 rpc error: code = InvalidArgument desc = Request validation error: Name: invalid resource name
│
│   with yandex_compute_instance.vm_for_each["netology_1"],
│   on main.tf line 33, in resource "yandex_compute_instance" "vm_for_each":
│   33: resource "yandex_compute_instance" "vm_for_each" {
│
╵
╷
│ Error: Error while requesting API to create instance: server-request-id = 09d073a5-40e6-4bd5-868e-2e07fc80b20b server-trace-id = 9efa17afaf7f697c:e35a20e878f502d2:9efa17afaf7f697c:1 client-request-id = c8a049ae-2bd8-426c-9b1d-5c8dde6364e2 client-trace-id = 05029466-2cbc-4303-97b1-eadbeb5074a0 rpc error: code = InvalidArgument desc = Request validation error: Name: invalid resource name
│
│   with yandex_compute_instance.vm_for_each["netology_2"],
│   on main.tf line 33, in resource "yandex_compute_instance" "vm_for_each":
│   33: resource "yandex_compute_instance" "vm_for_each" {


```

```
bucket создался
```

![pics/bucket.png]


```
PS: наверное самое сложное для меня задание, 3 для разбирался с авторизацией и ролями, а потом ЯК фиг пойми почему не работает 
```



