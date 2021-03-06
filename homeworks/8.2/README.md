<details>
<summary> Домашнее задание к занятию "08.02 Работа с Playbook из ветки main </summary>
# Домашнее задание к занятию "08.02 Работа с Playbook"
```
  задание не выполнено полностью, проблемы со скачиванием java и ёлки
```  
## Подготовка к выполнению
1. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
2. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
3. Подготовьте хосты в соотвтествии с группами из предподготовленного playbook. 
4. Скачайте дистрибутив [java](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) и положите его в директорию `playbook/files/`. 


## Основная часть
1. Приготовьте свой собственный inventory файл `prod.yml`.
```
kibana:
  hosts:
    localhost:
      ansible_connection: local
      ansible_user: root
```	  
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.
```
- name: Install Kibana
  hosts: kibana
  tasks:
    - name: Upload tar.gz Kibana from remote URL
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_kibana
      until: get_kibana is succeeded
      tags: kibana
    - name: Create directrory for Kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract Kibana in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags:
        - kibana
    - name: Set environment Kibana
      become: true
      template:
        src: templates/kib.sh.j2
        dest: /etc/profile.d/kib.sh
      tags: kibana

```

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
Ошибки исправлены
```

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
vagrant@test1:~/homeworks/devops-netology/homeworks/8.2/playbook$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [localhost]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [localhost]

TASK [Ensure installation dir exists] **********************************************************************************
changed: [localhost]

TASK [Extract java in the installation directory] **********************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [localhost]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/17.0.3.1' must be an existing dir"}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=4    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0


```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```


vagrant@test1:~/homeworks/devops-netology/homeworks/8.2/playbook$ sudo ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [localhost]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [localhost]

TASK [Ensure installation dir exists] **********************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/17.0.3.1",
-    "state": "absent"
+    "state": "directory"
 }

changed: [localhost]

TASK [Extract java in the installation directory] **********************************************************************
changed: [localhost]

TASK [Export environment variables] ************************************************************************************
ok: [localhost]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
FAILED - RETRYING: [localhost]: Upload tar.gz Elasticsearch from remote URL (3 retries left).
FAILED - RETRYING: [localhost]: Upload tar.gz Elasticsearch from remote URL (2 retries left).
FAILED - RETRYING: [localhost]: Upload tar.gz Elasticsearch from remote URL (1 retries left).
fatal: [localhost]: FAILED! => {"attempts": 3, "changed": false, "dest": "/tmp/elasticsearch-7.10.1-linux-x86_64.tar.gz", "elapsed": 0, "gid": 1000, "group": "vagrant", "mode": "0755", "msg": "Request failed", "owner": "vagrant", "response": "HTTP Error 403: Forbidden", "size": 318801277, "state": "file", "status_code": 403, "uid": 1000, "url": "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.1-linux-x86_64.tar.gz"}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=7    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

PS: закончился бесплатный трафик VPN =( 
```

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
vagrant@test1:~/homeworks/devops-netology/homeworks/8.2/playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [localhost]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [localhost]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [localhost]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [localhost]

TASK [Export environment variables] ************************************************************************************
ok: [localhost]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
FAILED - RETRYING: [localhost]: Upload tar.gz Elasticsearch from remote URL (3 retries left).
```

9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.

[Ссылка на репозиторий с playbook](./playbook_/README.md)



## Необязательная часть

1. Приготовьте дополнительный хост для установки logstash.
2. Пропишите данный хост в `prod.yml` в новую группу `logstash`.
3. Дополните playbook ещё одним play, который будет исполнять установку logstash только на выделенный для него хост.
4. Все переменные для нового play определите в отдельный файл `group_vars/logstash/vars.yml`.
5. Logstash конфиг должен конфигурироваться в части ссылки на elasticsearch (можно взять, например его IP из facts или определить через vars).
6. Дополните README.md, протестируйте playbook, выложите новую версию в github. В ответ предоставьте ссылку на репозиторий.

---
</details>

# Домашнее задание к занятию "08.02 Работа с Playbook" (из ветки mnt-13)

## Подготовка к выполнению

1. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
2. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
3. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Приготовьте свой собственный inventory файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
andrew@andrew-virtual-machine:~/devops-netology/homeworks/8.2/playbook$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] ************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "andrew", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "andrew", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ***************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create vector_home dir] ********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get vector distrib] ************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install vector packages] *******************************************************************************************************************************
ok: [clickhouse-01]

PLAY RECAP ***************************************************************************************************************************************************
clickhouse-01              : ok=7    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0  


```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
andrew@andrew-virtual-machine:~/devops-netology/homeworks/8.2/playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff


PLAY [Install Clickhouse] ************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "andrew", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "andrew", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ***************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create vector_home dir] ********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get vector distrib] ************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install vector packages] *******************************************************************************************************************************
ok: [clickhouse-01]

PLAY RECAP ***************************************************************************************************************************************************
clickhouse-01              : ok=8    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0  





```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```


andrew@andrew-virtual-machine:~/devops-netology/homeworks/8.2/playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "andrew", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "andrew", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ***************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create vector_home dir] ********************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get vector distrib] ************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install vector packages] *******************************************************************************************************************************
ok: [clickhouse-01]

PLAY RECAP ***************************************************************************************************************************************************
clickhouse-01              : ok=8    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   



```
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.


[Ссылка на репозиторий с playbook](./playbook/README.md)

