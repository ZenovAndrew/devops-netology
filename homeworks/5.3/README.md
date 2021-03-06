
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

```
Ссылка на ответ: 
https://hub.docker.com/repository/docker/zenova/my_nginx
```

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
```
В данном случае подойдет физическая машина, т.к. приложение монолитное, и нужен доступ к физическим ресурсам машины
```

- Nodejs веб-приложение;
```
Т.к. это веб приложение использование докера будет хорошим решением
```
- Мобильное приложение c версиями для Android и iOS;
```
Docker контейнер в данном случае не подойдет, т.к. у докера нет возможности отображения интерфейса. 
Подойдет либо виртуальная  либо физическая машина

```
- Шина данных на базе Apache Kafka;
```
Если потеря данных не критична (например для тестовой среды) то можно использовать контейнер на базе докера, для продакшн-среды всетаки лучше будет виртуалка
```
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
```
Можно использовать и докер и виртуалки. Для реализации кластера и то и то решение подходит. По нодам можно так же использовать и или докер или виртуалки. Нашел и такие и такие примеры применения. 
```
- Мониторинг-стек на базе Prometheus и Grafana;
```
Докер контейнер будет хорошим решением данной задачи, т.к. не используется хранение данных.
```
- MongoDB, как основное хранилище данных для java-приложения;
```
в данном случае лушче будет использовать виртуалку. Т.к. скорость запись данных при использовании докера будет заметно ниже чем у виртуалки 
```
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
```
Gitlab сервер - виртуальная машина, т.к. не сервер не высоконагруженный
Docker Registry - в докере будет самым лучшим решением
```

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

```
[root@94d7c673a60c data]# ls
file1 file2
[root@94d7c673a60c data]# cat file1
1file
[root@94d7c673a60c data]# cat file2
2file

```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.
```
andrew@andrew-virtual-machine:~/docker$ mkdir alpine && cd alpine
andrew@andrew-virtual-machine:~/docker/alpine$ nano Dockerfile
andrew@andrew-virtual-machine:~/docker/alpine$ docker build -t zenova/ansible:29.24 .
andrew@andrew-virtual-machine:~/docker/alpine$ docker push zenova/ansible

ссылка на докерхаб
https://hub.docker.com/repository/docker/zenova/ansible
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
