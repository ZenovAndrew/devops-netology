
# Playbook для установки Elasticsearch и Kibana
Описание  блоков 
- Groups_vars/
* Каталог all
vars.yml - файл с описанием версии и дистрибутива java
java_jdk_version - Версия Java JDK (11.0.15.1)
java_oracle_jdk_package - Файл архива Java JDK.
Скачиваем по ссылке и кладем в каталог /files
https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/java/jdk/11.0.15.1%2B2/d76aabb62f1c47aa8588b9ae5a8a5b46/jdk-11.0.15.1_linux-x64_bin.tar.gz

* Каталог elasticsearch
vars.yml - файл с описанием версии Elasticsearch и домашнего каталога
elastic_version - версия Elasticsearch (7.10.1)
elastic_home - домашний каталог Elasticsearch

* Каталог kibana
vars.yml - файл с описанием версии Kibana и домашнего каталога
kibana_version - ссылка на версию Elasticsearch (7.10.1)
kibana_home - домашний каталог Kibana

- Каталог inventory/
prod.yml - файл с hosts и параметров подключения


- site.yml - файл описывает поэтапное выполнение действий для установки Java, Elasticsearch и Kibana на хосты из файла Inventory

- Используемые теги: 
java
elastic
kibana

- Запуск плейбука

```code
ansible-playbook site.yml -i inventory/prod.yml
```
