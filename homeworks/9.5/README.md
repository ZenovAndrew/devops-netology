# Домашнее задание к занятию "09.05 Gitlab"

## Подготовка к выполнению

1. Необходимо [зарегистрироваться](https://about.gitlab.com/free-trial/)
2. Создайте свой новый проект
3. Создайте новый репозиторий в gitlab, наполните его [файлами](./repository)
4. Проект должен быть публичным, остальные настройки по желанию

## Основная часть

### DevOps

В репозитории содержится код проекта на python. Проект - RESTful API сервис. Ваша задача автоматизировать сборку образа с выполнением python-скрипта:
1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated)
2. Python версии не ниже 3.7
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`
4. Создана директория `/python_api`
5. Скрипт из репозитория размещён в /python_api
6. Точка вызова: запуск скрипта
7. Если сборка происходит на ветке `master`: Образ должен пушится в docker registry вашего gitlab `python-api:latest`, иначе этот шаг нужно пропустить

```
Сборку образа по традиции описываем в [Dockerfile] (https://gitlab.com/ZenovAndrew/devops-gitlab/-/blob/master/Dockerfile).
Тестируем правильность по адресу http://localhost:5290/get_info. 

docker build --tag python-api .
docker run -d --name python-api -p 5290:5290 python-api:latest

Создаем пайплайн по шаблону для образа Docker (файл .gitlab-ci.yml создается в корне репозитория )
Для запуска пайплайна необходимо зарегистрировать runner
Settings-CI/CD-Runners
# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start
Command to register runner
sudo gitlab-runner register --url https://gitlab.com/ --registration-token $REGISTRATION_TOKEN

Далее возникли проблемы по работе этого runner`а. Для решения потребовалось добавить в /etc/gitlab-runner/config.toml  строки "privileged=true" и "volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]""

После выполнения пайплайна образ размещается в репозитории гитлаб 
```
[python-api:latest](registry.gitlab.com/zenovandrew/devops-gitlab/python-api:latest)



### Product Owner

Вашему проекту нужна бизнесовая доработка: необходимо поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:
1. Какой метод необходимо исправить
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`
3. Issue поставить label: feature

### Developer

Вам пришел новый Issue на доработку, вам необходимо:
1. Создать отдельную ветку, связанную с этим issue
2. Внести изменения по тексту из задания
3. Подготовить Merge Requst, влить необходимые изменения в `master`, проверить, что сборка прошла успешно

```
Выполнено. После изменения в ветке отличной от мастер, происходит билд. После мерджа в мастер - билд+деплой+тест 
```

### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:
1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый


```

docker exec python-api curl -s http://0.0.0.0:5290/get_info | grep Running && echo "--------------PASSED!--------------" && docker push "$CI_REGISTRY_IMAGE"/python-api:latest

```

## Итог

После успешного прохождения всех ролей - отправьте ссылку на ваш проект в гитлаб, как решение домашнего задания

[Ссылка на гитлаб](https://gitlab.com/ZenovAndrew/devops-gitlab)

## Необязательная часть

Автомазируйте работу тестировщика, пусть у вас будет отдельный конвейер, который автоматически поднимает контейнер и выполняет проверку, например, при помощи curl. На основе вывода - будет приниматься решение об успешности прохождения тестирования

```
выполнено
```

---
