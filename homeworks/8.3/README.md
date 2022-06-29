```
выполнено по заданию из ветки MNT13, тк. нет возможности скачивания и разворачивания ELK стека
```
# Домашнее задание к занятию "8.4 Работа с Roles"

## Подготовка к выполнению
1. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.

https://github.com/ZenovAndrew/lighthouse-role
https://github.com/ZenovAndrew/vector-role


2. Добавьте публичную часть своего ключа к своему профилю в github.
```
было добавлено
```

## Основная часть

Наша основная цель - разбить наш playbook на отдельные roles. Задача: сделать roles для clickhouse, vector и lighthouse и написать playbook для использования этих ролей. Ожидаемый результат: существуют три ваших репозитория: два с roles и один с playbook.

1. Создать в старой версии playbook файл `requirements.yml` и заполнить его следующим содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.11.0"
       name: clickhouse 
   ```

```
выполнено
```

2. При помощи `ansible-galaxy` скачать себе эту роль.
```
vagrant@test1:~/8.3$ ansible-galaxy install -r requirements.yml -p roles
Starting galaxy role install process
- extracting clickhouse to /home/vagrant/8.3/roles/clickhouse
- clickhouse (1.11.0) was installed successfully
```
3. Создать новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.
```
vagrant@test1:~/8.3$ ansible-galaxy role init vector
- Role vector was created successfully
```
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 
5. Перенести нужные шаблоны конфигов в `templates`.
6. Описать в `README.md` обе роли и их параметры.
7. Повторите шаги 3-6 для lighthouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию Добавьте roles в `requirements.yml` в playbook.
```
Пушим все роли. Добавляем теги 

vagrant@test1:~/8.3/roles/vector$ git tag -a 0.0.1 -m "test for req"
vagrant@test1:~/8.3/roles/vector$ git push  --tags
vagrant@test1:~/8.3/roles/lighthouse$ git tag -a 0.0.1 -m "test for req"
vagrant@test1:~/8.3/roles/lighthouse$ git push  --tags

Для nginx использовал готовую роль https://galaxy.ansible.com/geerlingguy/nginx
vagrant@test1:~/8.3$ nano requirements.yml
---
  - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
    scm: git
    version: "1.11.0"
    name: clickhouse
  - src: git@github.com:geerlingguy/ansible-role-nginx
    scm: git
    version: "3.1.1"
    name: nginx
  - src: git@github.com:ZenovAndrew/vector-role.git
    scm: git
    version: 0.0.1"
    name: vector
  - src: git@github.com:ZenovAndrew/lighthouse-role.git
    scm: git
    version: "0.0.1"
    name: lighthouse
```

```
Проверяем что работает 
vagrant@test1:~/8.3$ ansible-galaxy install -r requirements.yml -p roles
Starting galaxy role install process
- extracting clickhouse to /home/vagrant/8.3/roles/clickhouse
- clickhouse (1.11.0) was installed successfully
- extracting nginx to /home/vagrant/8.3/roles/nginx
- nginx (3.1.1) was installed successfully
- extracting vector to /home/vagrant/8.3/roles/vector
- vector (0.0.1) was installed successfully
- extracting lighthouse to /home/vagrant/8.3/roles/lighthouse
- lighthouse (0.0.1) was installed successfully

и пилим плейбук...
```

9. Переработайте playbook на использование roles. Не забудьте про зависимости lighthouse и возможности совмещения `roles` с `tasks`.

<details>
<summary> Проверка выполнения плейбука </summary>

vagrant@test1:~/8.3$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Install nginx, clickhouse, lighthouse, vector] *******************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [server]

TASK [nginx : Include OS-specific variables.] **************************************************************************
ok: [server]

TASK [nginx : Define nginx_user.] **************************************************************************************
ok: [server]

TASK [nginx : include_tasks] *******************************************************************************************
included: /home/vagrant/8.3/roles/nginx/tasks/setup-RedHat.yml for server

TASK [nginx : Enable nginx repo.] **************************************************************************************
changed: [server]

TASK [nginx : Ensure nginx is installed.] ******************************************************************************
changed: [server]

TASK [nginx : include_tasks] *******************************************************************************************
skipping: [server]

TASK [nginx : include_tasks] *******************************************************************************************
skipping: [server]

TASK [nginx : include_tasks] *******************************************************************************************
skipping: [server]

TASK [nginx : include_tasks] *******************************************************************************************
skipping: [server]

TASK [nginx : include_tasks] *******************************************************************************************
skipping: [server]

TASK [nginx : Remove default nginx vhost config file (if configured).] *************************************************
skipping: [server]

TASK [nginx : Ensure nginx_vhost_path exists.] *************************************************************************
ok: [server]

TASK [nginx : Add managed vhost config files.] *************************************************************************

TASK [nginx : Remove managed vhost config files.] **********************************************************************

TASK [nginx : Remove legacy vhosts.conf file.] *************************************************************************
ok: [server]

TASK [nginx : Copy nginx configuration in place.] **********************************************************************
changed: [server]

TASK [nginx : Ensure nginx service is running as configured.] **********************************************************
changed: [server]

TASK [clickhouse : Include OS Family Specific Variables] ***************************************************************
ok: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/precheck.yml for server

TASK [clickhouse : Requirements check | Checking sse4_2 support] *******************************************************
ok: [server]

TASK [clickhouse : Requirements check | Not supported distribution && release] *****************************************
skipping: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/params.yml for server

TASK [clickhouse : Set clickhouse_service_enable] **********************************************************************
ok: [server]

TASK [clickhouse : Set clickhouse_service_ensure] **********************************************************************
ok: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/install/dnf.yml for server

TASK [clickhouse : Install by YUM | Ensure clickhouse repo GPG key imported] *******************************************
changed: [server]

TASK [clickhouse : Install by YUM | Ensure clickhouse repo installed] **************************************************
changed: [server]

TASK [clickhouse : Install by YUM | Ensure clickhouse package installed (latest)] **************************************
changed: [server]

TASK [clickhouse : Install by YUM | Ensure clickhouse package installed (version latest)] ******************************
skipping: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/configure/sys.yml for server

TASK [clickhouse : Check clickhouse config, data and logs] *************************************************************
ok: [server] => (item=/var/log/clickhouse-server)
changed: [server] => (item=/etc/clickhouse-server)
changed: [server] => (item=/var/lib/clickhouse/tmp/)
changed: [server] => (item=/var/lib/clickhouse/)

TASK [clickhouse : Config | Create config.d folder] ********************************************************************
changed: [server]

TASK [clickhouse : Config | Create users.d folder] *********************************************************************
changed: [server]

TASK [clickhouse : Config | Generate system config] ********************************************************************
changed: [server]

TASK [clickhouse : Config | Generate users config] *********************************************************************
changed: [server]

TASK [clickhouse : Config | Generate remote_servers config] ************************************************************
skipping: [server]

TASK [clickhouse : Config | Generate macros config] ********************************************************************
skipping: [server]

TASK [clickhouse : Config | Generate zookeeper servers config] *********************************************************
skipping: [server]

TASK [clickhouse : Config | Fix interserver_http_port and intersever_https_port collision] *****************************
skipping: [server]

TASK [clickhouse : Notify Handlers Now] ********************************************************************************

RUNNING HANDLER [nginx : reload nginx] *********************************************************************************
changed: [server]

RUNNING HANDLER [clickhouse : Restart Clickhouse Service] **************************************************************
ok: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/service.yml for server

TASK [clickhouse : Ensure clickhouse-server.service is enabled: True and state: restarted] *****************************
changed: [server]

TASK [clickhouse : Wait for Clickhouse Server to Become Ready] *********************************************************
ok: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/configure/db.yml for server

TASK [clickhouse : Set ClickHose Connection String] ********************************************************************
ok: [server]

TASK [clickhouse : Gather list of existing databases] ******************************************************************
ok: [server]

TASK [clickhouse : Config | Delete database config] ********************************************************************

TASK [clickhouse : Config | Create database config] ********************************************************************

TASK [clickhouse : include_tasks] **************************************************************************************
included: /home/vagrant/8.3/roles/clickhouse/tasks/configure/dict.yml for server

TASK [clickhouse : Config | Generate dictionary config] ****************************************************************
skipping: [server]

TASK [clickhouse : include_tasks] **************************************************************************************
skipping: [server]

TASK [lighthouse : Installing git] *************************************************************************************
changed: [server]

TASK [lighthouse : Copy Lighthouse to folder] **************************************************************************
changed: [server]

TASK [vector : Create vector_home dir] *********************************************************************************
changed: [server]

TASK [vector : Get vector distrib] *************************************************************************************
changed: [server]

TASK [vector : Create folder for unit-file] ****************************************************************************
changed: [server]

TASK [vector : Create vector.service-file from template] ***************************************************************
changed: [server]

TASK [vector : Install vector packages] ********************************************************************************
changed: [server]

TASK [Create nginx config] *********************************************************************************************
changed: [server]

TASK [Copy clickhouse to www] ******************************************************************************************
changed: [server]

RUNNING HANDLER [vector : Start Vector service] ************************************************************************
changed: [server]

RUNNING HANDLER [Restart nginx service] ********************************************************************************
changed: [server]

PLAY RECAP *************************************************************************************************************
server                     : ok=46   changed=25   unreachable=0    failed=0    skipped=18   rescued=0    ignored=0

</details>

10. Выложите playbook в репозиторий.

https://github.com/ZenovAndrew/devops-netology/tree/main/homeworks/8.3

11. В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

https://github.com/ZenovAndrew/lighthouse-role
https://github.com/ZenovAndrew/vector-role


PS: была проблема с доступом по готовой роли, пришлось подправить ansible config
