# Домашнее задание к занятию "09.03 Jenkins"

## Подготовка к выполнению

1. Установить jenkins по любой из [инструкций](https://www.jenkins.io/download/)
```
первоначально поставил jenkins в докере 
Проверил и настроил, при добавлении динамического агента в докере столкнулся с проблемой, которую не смог решить
В итоге провозившись 4 дня принял решение поставить как в видео Алексея Метлякова.
А именно:
1. Создаем ВМ
2. Выполняем плейбук

```

2. Запустить и проверить работоспособность
```
выполнено
```
3. Сделать первоначальную настройку
```
Производим первоначальную настройку
ssh jenkinss@51.250.94.56
cat /var/lib/jenkins/secrets/initialAdminPassword
вставляем в http://51.250.94.56:8080
Dashboard > Nodes > мастер > отключаем Количество процессов-исполнителей =0

добавляем агента
Dashboard > Nodes > agent-1 > Type Permanent Agent > Create
Доп. настройки агента 
Корень удаленной ФС > /opt/jenkins_agent/
Метки > jenkins_agent
Способ запуска > Launch agent via execution of command on thr controller
Команда запуска > ssh 51.250.94.56 java -jar /opt/jenkins_agent/agent.jar
проверяем готовность агента 
Dashboard > Nodes > agent-1

ssh 51.250.90.146 java -jar /opt/jenkins_agent/agent.jar
<===[JENKINS REMOTING CAPACITY]===>channel started
Remoting version: 4.13
This is a Unix agent
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by jenkins.slaves.StandardOutputSwapper$ChannelSwapper to constructor java.io.FileDescriptor(int)
WARNING: Please consider reporting this to the maintainers of jenkins.slaves.StandardOutputSwapper$ChannelSwapper
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
Evacuated stdout
Agent successfully connected and online
```

4. Настроить под свои нужды
```
Dashboard > Credentials > System > Global credentials (unrestricted) 
Добавляем ключи GitHub
```

5. Поднять отдельный cloud
6. Для динамических агентов можно использовать [образ](https://hub.docker.com/repository/docker/aragast/agent)
```
#эксперты, как всетаки настроисть динамического агента в докере??? Пробовал несколько мануалов, в т.ч на офф. сайте

```
7. Обязательный параметр: поставить label для динамических агентов: `ansible_docker`
8.  Сделать форк репозитория с [playbook](https://github.com/aragastmatb/example-playbook)
```
сделано
```



## Основная часть

1. Сделать Freestyle Job, который будет запускать `ansible-playbook` из форка репозитория


<details>
<summary> Freestyle Job </summary>


Started by user andrew
Running as SYSTEM
Building remotely on agent1 (jenkins_agent) in workspace /opt/jenkins_agent/workspace/Freestyle Job
[WS-CLEANUP] Deleting project workspace...
[WS-CLEANUP] Deferred wipeout is used...
[WS-CLEANUP] Done
The recommended git tool is: NONE
using credential github_key
Cloning the remote Git repository
Cloning repository git@github.com:ZenovAndrew/example-playbook.git
 > git init /opt/jenkins_agent/workspace/Freestyle Job # timeout=10
Fetching upstream changes from git@github.com:ZenovAndrew/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Freestyle Job@tmp/jenkins-gitclient-ssh17329396550584200748.key
 > git fetch --tags --progress git@github.com:ZenovAndrew/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url git@github.com:ZenovAndrew/example-playbook.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
Checking out Revision ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 # timeout=10
Commit message: "Update requirements.yml"
 > git rev-list --no-walk ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 # timeout=10
[Freestyle Job] $ /bin/sh -xe /tmp/jenkins8175951428008858729.sh
+ ansible-vault decrypt secret --vault-password-file vault_pass
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
+ mv secret /home/jenkins/.ssh/id_rsa
++ ssh-agent -s
+ eval 'SSH_AUTH_SOCK=/tmp/ssh-9ezGY2MjtHwv/agent.14309;' export 'SSH_AUTH_SOCK;' 'SSH_AGENT_PID=14310;' export 'SSH_AGENT_PID;' echo Agent pid '14310;'
++ SSH_AUTH_SOCK=/tmp/ssh-9ezGY2MjtHwv/agent.14309
++ export SSH_AUTH_SOCK
++ SSH_AGENT_PID=14310
++ export SSH_AGENT_PID
++ echo Agent pid 14310
Agent pid 14310
+ ssh-add /home/jenkins/.ssh/id_rsa
Identity added: /home/jenkins/.ssh/id_rsa (aragast@192.168.1.55)
++ ssh -T git@github.com -o StrictHostKeyChecking=no
Hi netology-code/mnt-homeworks-ansible! You've successfully authenticated, but GitHub does not provide shell access.
+ eval
+ ssh-add /home/jenkins/.ssh/id_rsa
Identity added: /home/jenkins/.ssh/id_rsa (aragast@192.168.1.55)
+ ansible-galaxy role install -r requirements.yml
Starting galaxy role install process
- java (1.0.1) is already installed, skipping.
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
+ ansible-playbook site.yml -i inventory/prod.yml

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
changed: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
changed: [localhost]

TASK [java : Extract java in the installation directory] ***********************
changed: [localhost]

TASK [java : Export environment variables] *************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=4    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   

Finished: SUCCESS




</details>




2. Сделать Declarative Pipeline, который будет выкачивать репозиторий с плейбукой и запускать её


<details>
<summary> Declarative Pipeline </summary>




Started by user andrew
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent1 in /opt/jenkins_agent/workspace/Declarative Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
The recommended git tool is: NONE
No credentials specified
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Declarative Pipeline/.git # timeout=10
 > git config remote.origin.url https://github.com/ZenovAndrew/example-playbook.git # timeout=10
Fetching upstream changes from https://github.com/ZenovAndrew/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
 > git fetch --tags --progress https://github.com/ZenovAndrew/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 (refs/remotes/origin/master)
Commit message: "Update requirements.yml"
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 # timeout=10
 > git rev-list --no-walk ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Prepare)
[Pipeline] sh
+ ansible-vault decrypt secret --vault-password-file vault_pass
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
[Pipeline] sh
+ mv secret /home/jenkins/.ssh/id_rsa
[Pipeline] sh
++ ssh-agent -s
+ eval 'SSH_AUTH_SOCK=/tmp/ssh-ZBIqaU5Gw2ZW/agent.14991;' export 'SSH_AUTH_SOCK;' 'SSH_AGENT_PID=14992;' export 'SSH_AGENT_PID;' echo Agent pid '14992;'
++ SSH_AUTH_SOCK=/tmp/ssh-ZBIqaU5Gw2ZW/agent.14991
++ export SSH_AUTH_SOCK
++ SSH_AGENT_PID=14992
++ export SSH_AGENT_PID
++ echo Agent pid 14992
Agent pid 14992
+ ssh-add /home/jenkins/.ssh/id_rsa
Identity added: /home/jenkins/.ssh/id_rsa (aragast@192.168.1.55)
++ ssh -T git@github.com -o StrictHostKeyChecking=no
Hi netology-code/mnt-homeworks-ansible! You've successfully authenticated, but GitHub does not provide shell access.
+ eval
[Pipeline] sh
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Playbook)
[Pipeline] sh
+ ansible-galaxy role install -r requirements.yml
Starting galaxy role install process
- java (1.0.1) is already installed, skipping.
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
[Pipeline] sh
+ ansible-playbook site.yml -i inventory/prod.yml

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
ok: [localhost]

TASK [java : Extract java in the installation directory] ***********************
skipping: [localhost]

TASK [java : Export environment variables] *************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS


</details>




3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`
4. Перенастроить Job на использование `Jenkinsfile` из репозитория



<details>
<summary> Job на использование Jenkinsfile из репо </summary>


Started by user andrew
Obtained Jenkinsfile from git git@github.com:ZenovAndrew/example-playbook.git
[Pipeline] Start of Pipeline
[Pipeline] node (hide)
Running on agent1 in /opt/jenkins_agent/workspace/Declarative Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github_key
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Declarative Pipeline/.git # timeout=10
 > git config remote.origin.url git@github.com:ZenovAndrew/example-playbook.git # timeout=10
Fetching upstream changes from git@github.com:ZenovAndrew/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Declarative Pipeline@tmp/jenkins-gitclient-ssh9443507093503450860.key
 > git fetch --tags --progress git@github.com:ZenovAndrew/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision eeafc24bb6429b82b5936f3b997b98a8dd963609 (refs/remotes/origin/master)
Commit message: "jenkisfile add"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
Fetching changes from the remote Git repository
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eeafc24bb6429b82b5936f3b997b98a8dd963609 # timeout=10
Checking out Revision eeafc24bb6429b82b5936f3b997b98a8dd963609 (refs/remotes/origin/master)
Commit message: "jenkisfile add"
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Declarative Pipeline/.git # timeout=10
 > git config remote.origin.url https://github.com/ZenovAndrew/example-playbook.git # timeout=10
Fetching upstream changes from https://github.com/ZenovAndrew/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
 > git fetch --tags --progress https://github.com/ZenovAndrew/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eeafc24bb6429b82b5936f3b997b98a8dd963609 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master eeafc24bb6429b82b5936f3b997b98a8dd963609 # timeout=10
 > git rev-list --no-walk ce10d86ece9b4fb1fd0ea1bd10da952a84ad8de6 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Prepare)
[Pipeline] sh
+ ansible-vault decrypt secret --vault-password-file vault_pass
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
[Pipeline] sh
+ mv secret /home/jenkins/.ssh/id_rsa
[Pipeline] sh
++ ssh-agent -s
+ eval 'SSH_AUTH_SOCK=/tmp/ssh-53paWtj9yWoO/agent.15445;' export 'SSH_AUTH_SOCK;' 'SSH_AGENT_PID=15446;' export 'SSH_AGENT_PID;' echo Agent pid '15446;'
++ SSH_AUTH_SOCK=/tmp/ssh-53paWtj9yWoO/agent.15445
++ export SSH_AUTH_SOCK
++ SSH_AGENT_PID=15446
++ export SSH_AGENT_PID
++ echo Agent pid 15446
Agent pid 15446
+ ssh-add /home/jenkins/.ssh/id_rsa
Identity added: /home/jenkins/.ssh/id_rsa (aragast@192.168.1.55)
++ ssh -T git@github.com -o StrictHostKeyChecking=no
Hi netology-code/mnt-homeworks-ansible! You've successfully authenticated, but GitHub does not provide shell access.
+ eval
[Pipeline] sh
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Playbook)
[Pipeline] sh
+ ansible-galaxy role install -r requirements.yml
Starting galaxy role install process
- java (1.0.1) is already installed, skipping.
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
[Pipeline] sh
+ ansible-playbook site.yml -i inventory/prod.yml

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
ok: [localhost]

TASK [java : Extract java in the installation directory] ***********************
skipping: [localhost]

TASK [java : Export environment variables] *************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
</details>


5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline)


6. Заменить credentialsId на свой собственный
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозитрий в файл `ScriptedJenkinsfile`



<details>
<summary> Scripted Pipeline </summary>

Started by user andrew
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent1 in /opt/jenkins_agent/workspace/test
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential github_key
Cloning the remote Git repository
Cloning repository git@github.com:ZenovAndrew/example-playbook.git
 > git init /opt/jenkins_agent/workspace/test # timeout=10
Fetching upstream changes from git@github.com:ZenovAndrew/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/test@tmp/jenkins-gitclient-ssh9117861812271124376.key
 > git fetch --tags --progress git@github.com:ZenovAndrew/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
Checking out Revision eeafc24bb6429b82b5936f3b997b98a8dd963609 (refs/remotes/origin/master)
Commit message: "jenkisfile add"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Check ssh key)
[Pipeline] script
[Pipeline] {
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Prepare)
[Pipeline] sh
 > git config remote.origin.url git@github.com:ZenovAndrew/example-playbook.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eeafc24bb6429b82b5936f3b997b98a8dd963609 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b master eeafc24bb6429b82b5936f3b997b98a8dd963609 # timeout=10
+ ansible-vault decrypt secret --vault-password-file vault_pass
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
[Pipeline] sh
+ mv secret /home/jenkins/.ssh/id_rsa
[Pipeline] sh
++ ssh-agent -s
+ eval 'SSH_AUTH_SOCK=/tmp/ssh-qLGlAuBRzbRl/agent.15935;' export 'SSH_AUTH_SOCK;' 'SSH_AGENT_PID=15937;' export 'SSH_AGENT_PID;' echo Agent pid '15937;'
++ SSH_AUTH_SOCK=/tmp/ssh-qLGlAuBRzbRl/agent.15935
++ export SSH_AUTH_SOCK
++ SSH_AGENT_PID=15937
++ export SSH_AGENT_PID
++ echo Agent pid 15937
Agent pid 15937
+ ssh-add /home/jenkins/.ssh/id_rsa
Identity added: /home/jenkins/.ssh/id_rsa (aragast@192.168.1.55)
++ ssh -T git@github.com -o StrictHostKeyChecking=no
Hi netology-code/mnt-homeworks-ansible! You've successfully authenticated, but GitHub does not provide shell access.
+ eval
[Pipeline] sh
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Playbook)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ ansible-galaxy role install -r requirements.yml
Starting galaxy role install process
- java (1.0.1) is already installed, skipping.
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
[Pipeline] sh
+ ansible-playbook site.yml -i inventory/prod.yml

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography and will be removed in a future release.
  from cryptography.exceptions import InvalidSignature
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
ok: [localhost]

TASK [java : Extract java in the installation directory] ***********************
skipping: [localhost]

TASK [java : Export environment variables] *************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

</details>


8. Отправить ссылку на репозиторий в ответе

https://github.com/ZenovAndrew/example-playbook

```
PS: очень много времени потеряно на обучение работы с данным продуктом, видимо как сказал Алексей Метляков в лекции, главный плюс что он полностью бесплатный..
```

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, которые завершились хотя бы раз неуспешно. Добавить скрипт в репозиторий с решеним с названием `AllJobFailure.groovy`
2. Установить customtools plugin
3. Поднять инстанс с локальным nexus, выложить туда в анонимный доступ  .tar.gz с `ansible`  версии 2.9.x
4. Создать джобу, которая будет использовать `ansible` из `customtool`
5. Джоба должна просто исполнять команду `ansible --version`, в ответ прислать лог исполнения джобы 

