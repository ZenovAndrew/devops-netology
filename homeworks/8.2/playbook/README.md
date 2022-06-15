# Playbook для установки Clickhouse и Vector
Описание  блоков 
- Groups_vars/
* Каталог clickhouse/
vars.yml - файл с описанием версии и устанавливаемых пакетах 
clickhouse_version  - Версия clickhouse "22.3.3.44"
clickhouse_packages - устанавливаемые пакеты: clickhouse-client, clickhouse-server, clickhouse-common-static
  
* Каталог vector/
vars.yml - файл с описанием версии Vector, домашнего каталога и дистрибутива
vector_version: - Версия "0.22.1"
vector_home: - Домашняя директория "/tmp/vector"
vector_url: - Ссылка на пакет установки

- Каталог inventory/
prod.yml - файл с hosts и параметров подключения

- site.yml - файл описывает поэтапное выполнение действий для установки Clickhouse и Vector на хосты из файла Inventory

- Используемые теги: 

vector


- Запуск плейбука

```code
ansible-playbook site.yml -i inventory/prod.yml
```
