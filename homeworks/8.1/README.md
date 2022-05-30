# Домашнее задание к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.
```bash
# Была установлена версия 2.9.6, удаляем
vagrant@test1:~$ apt remove ansible
#устанавливаем версию посвежее
vagrant@test1:~$ sudo apt update
vagrant@test1:~$ sudo apt install software-properties-common
vagrant@test1:~$ sudo add-apt-repository --yes --update ppa:ansible/ansible
vagrant@test1:~$ sudo apt install ansible

#проверяем
vagrant@test1:~$ ansible --version
ansible [core 2.12.6]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/vagrant/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]
  jinja version = 2.10.1
  libyaml = True
```

2. Создайте свой собственный публичный репозиторий на github с произвольным именем.
```
https://github.com/ZenovAndrew/Ansible_homework1
```

3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
```
сделано
```


## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.
```bash
vagrant@test1:~/8.1/Ansible_homework1$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


#фиксируем значение "12"

```


2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.
```
vagrant@test1:~/8.1/Ansible_homework1$ nano group_vars/all/examp.yml 
---
  some_fact: all default fact
  
  
# проверяем

vagrant@test1:~/8.1/Ansible_homework1$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```



3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
```bash
# качаем образы  
root@test1:/home/vagrant# sudo su
root@test1:/home/vagrant# docker pull pycontribs/centos:7
root@test1:/home/vagrant# docker pull pycontribs/ubuntu:latest
# запускаем контейнеры

root@test1:/home/vagrant# docker run -d --name centos7 pycontribs/centos:7 /bin/sleep 77777777777777777
root@test1:/home/vagrant# docker run -d --name ubuntu pycontribs/ubuntu:latest /bin/sleep 77777777777777777

```

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ****************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ***********************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

# для centos7 some_fact лежит в el, а для ubuntu в deb
```

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.
```bash
# добавляем
root@test1:/home/vagrant/8.1/Ansible_homework1# nano  group_vars/deb/examp.yml
root@test1:/home/vagrant/8.1/Ansible_homework1# nano  group_vars/el/examp.yml

```


6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
```bash

# проверяем
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ****************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ***********************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-vault encrypt group_vars/el/* group_vars/deb/*
New Vault password:
Confirm New Vault password:
Encryption successful

# проверяем
root@test1:/home/vagrant/8.1/Ansible_homework1# cat group_vars/el/examp.yml group_vars/deb/examp.yml
$ANSIBLE_VAULT;1.1;AES256
39303966633136393437396231333166353033613866646564626166613732633330613962333765
6136643936343666616235633734633738386661636534310a613961326134393233343937393232
30663130323664653038366233636264343766313739373132323066313164333534346163393264
3161396665353665340a616265386462323935656164386365316631616138313661396130653138
37363932363832323631393231376665623466373636613433373762366333646231363634383164
6330623166343062313335616433613662373335373666623238
$ANSIBLE_VAULT;1.1;AES256
33663830636331336539363839303264373966373731626539636333353763346433613934613435
6364306166663234346135306233613761653330353461330a393032616339373536613765663437
65376436666333346239393365356433323264653737353865333231316464393031363637333235
3337636531633833330a333039666564323533313465386634663436636539623931633331373331
35396338626236636130323530313030346638326332356165393732353165306330646636663038
3265646564373162646165653261306434616164333563623034

```
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ************************************************************************************************************************************
ERROR! Attempting to decrypt but no vault secrets found
root@test1:/home/vagrant/8.1/Ansible_homework1#

# пробуем подсунуть пароль
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ****************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ***********************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
# все ок!
```
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
```bash
local                          execute on controller

```
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# nano inventory/prod.yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local

```
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ****************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ***********************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
https://github.com/ZenovAndrew/Ansible_homework1


## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-vault decrypt group_vars/deb/* group_vars/el/*
Vault password:
Decryption successful
```

2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-vault encrypt_string 'PaSSw0rd'
New Vault password:
Confirm New Vault password:
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          63663632663832323662626535333434356531353238633461393938363962323563326238383030
          6134373533663363356263623061363266373431373136370a646239333335353563326334326430
          61386233653630306237346463623631633862336439663933376534393164636135636535396464
          3630613235333839310a396261303534623430313333333062623361383833383035373362663737
          3635
Encryption successful
```



3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ****************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP ***********************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот](https://hub.docker.com/r/pycontribs/fedora).
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# docker pull pycontribs/fedora
Using default tag: latest
latest: Pulling from pycontribs/fedora
588cf1704268: Pull complete
49425a0e12c7: Pull complete
Digest: sha256:20eeb45ef6e394947058dc24dc2bd98dfb7a8fecbbe6363d14ab3170f10a27ab
Status: Downloaded newer image for pycontribs/fedora:latest
docker.io/pycontribs/fedora:latest

root@test1:/home/vagrant/8.1/Ansible_homework1# docker run -d --name fedora pycontribs/fedora:latest /bin/sleep 77777777777777777
d4326a1343df40703dcf346306afe5cbf0f65fef79b94b3a2384ae26352f1ebb

root@test1:/home/vagrant/8.1/Ansible_homework1# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************
ok: [localhost]
ok: [fedora]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ******************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [fedora] => {
    "msg": "Fedora"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ****************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [fedora] => {
    "msg": "fedora default fact"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP ***********************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


```
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
```bash
пока тут пусто =(
```
6. Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.
```bash
root@test1:/home/vagrant/8.1/Ansible_homework1# git add .
root@test1:/home/vagrant/8.1/Ansible_homework1# git commit -m "ansible 8.1"
root@test1:/home/vagrant/8.1/Ansible_homework1# git push

```
---
# Самоконтроль выполненения задания

1. Где расположен файл с `some_fact` из второго пункта задания?
```
group_vars/all/examp.yml 
```
2. Какая команда нужна для запуска вашего `playbook` на окружении `test.yml`?
```
ansible-playbook -i inventory/test.yml site.yml
```
3. Какой командой можно зашифровать файл?
```
ansible encrypt <путь_к_файлу>
```
4. Какой командой можно расшифровать файл?
```
ansible decrypt <путь_к_файлу>
```
5. Можно ли посмотреть содержимое зашифрованного файла без команды расшифровки файла? Если можно, то как?
```
Да, с помощью команды
ansible-vault view <путь_к_файлу>
```
6. Как выглядит команда запуска `playbook`, если переменные зашифрованы?
```
ansible-playbook -i inventory/test.yml site.yml --ask-vault-pass
```
7. Как называется модуль подключения к host на windows?

```
winrm   Run tasks over Microsoft's WinRM
```
8. Приведите полный текст команды для поиска информации в документации ansible для модуля подключений ssh
```
ansible-doc -t connection ssh
```
9. Какой параметр из модуля подключения `ssh` необходим для того, чтобы определить пользователя, под которым необходимо совершать подключение?
```
remote_user
        User name with which to login to the remote server, normally set by the remote_user keyword.
        If no user is supplied, Ansible will let the SSH client binary choose the user as it normally.
        [Default: (null)]
        set_via:
          cli:
          - name: user
            option: --user
          env:
          - name: ANSIBLE_REMOTE_USER
          ini:
          - key: remote_user
            section: defaults
          vars:
          - name: ansible_user
          - name: ansible_ssh_user
```

