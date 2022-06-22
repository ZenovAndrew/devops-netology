# Домашнее задание к занятию "09.04 Jenkins"

## Подготовка к выполнению

1. Создать 2 VM: для jenkins-master и jenkins-agent.
2. Установить jenkins при помощи playbook'a.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

```
1. Создаем ВМ
2. Выполняем плейбук
3. Производим первоначальную настройку
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
## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
```
Создаем задачу свободной конфигурации с именем "vector-role"
Dashboard > Все
Ограничить лейблы сборщиков, которые могут исполнять данную задачу "jenkins_agent"


```
2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, которые завершились хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением с названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline таким образом, чтобы он мог сначала запустить через Ya.Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Тем самым, мы должны по нажатию кнопки получить готовую к использованию систему.
