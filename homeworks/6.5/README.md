# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

```

root@test1:/home/vagrant/6.5# cat Dockerfile
# version 0.1
FROM    centos:7
ENV     DIR=/opt/elasticsearch/
ENV     USER=elastic
WORKDIR $DIR/elasticsearch-8.1.0

RUN     useradd -d $DIR -m -s /bin/bash $USER && \
        mkdir /var/lib/data && \
        mkdir /var/lib/logs && \
        chown $USER /var/lib/data && \
        chown $USER /var/lib/logs && \
        yum -y install wget && \
        yum -y install perl-Digest-SHA && \
        cd $DIR && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512 && \
        shasum -a 512 -c elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512  && \
        tar -zxvf elasticsearch-8.1.0-linux-x86_64.tar.gz && \
        echo "node.name: netology_test" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "path.data: /var/lib/data" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "path.logs: /var/lib/logs" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "xpack.security.enabled: false" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        chown -R $USER $DIR/elasticsearch-8.1.0 && \
        rm -f elasticsearch-8.1.0-linux-x86_64.tar.gz

USER    elastic



# for REST
EXPOSE 9200
# for nodes communication
EXPOSE 9300

CMD ["./bin/elasticsearch"]



root@test1:/home/vagrant/6.5# docker build . -t zenova/elasticsearch:8.1.0

root@test1:/home/vagrant/6.5# docker login -u "zenova"
Password:
Error response from daemon: Get "https://registry-1.docker.io/v2/": unauthorized: incorrect username or password
root@test1:/home/vagrant/6.5# docker login -u "zenova"
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
root@test1:/home/vagrant/6.5# docker push zenova/elasticsearch:8.1.0
The push refers to repository [docker.io/zenova/elasticsearch]
f1b0ab50e5c7: Pushed
847bcf9ec9bb: Pushed
174f56854903: Mounted from library/centos
8.1.0: digest: sha256:dd3b5a58aaea40876847bcc38f079e0fedf29460f0b7f6097973f30d0b988be4 size: 949


# ссылка на образ
https://hub.docker.com/repository/docker/zenova/elasticsearch

root@test1:/home/vagrant/6.5# docker run --rm -d --name elastic -p 9200:9200 -p 9300:9300 zenova/elasticsearch:8.1.0

root@test1:/home/vagrant/6.5# docker ps
CONTAINER ID   IMAGE                        COMMAND                 CREATED       STATUS       PORTS                                                                                  NAMES
793f476e2709   zenova/elasticsearch:8.1.0   "./bin/elasticsearch"   3 hours ago   Up 3 hours   0.0.0.0:9200->9200/tcp, :::9200->9200/tcp, 0.0.0.0:9300->9300/tcp, :::9300->9300/tcp   elastic
root@test1:/home/vagrant/6.5#

Вот тут проблема >>>
root@test1:/home/vagrant/6.5# curl -X GET localhost:9200
curl: (56) Recv failure: Connection reset by peer

На хостовой машине ошибка хотя порты прокинуты, если зайти в контейнер информация по запросу выводится, как в документации по еластику



root@test1:/home/vagrant# docker exec -it elastic bash

bash-4.2$ curl -X GET localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "ze2Z3ZXfSvSvKQ-PQTkTHQ",
  "version" : {
    "number" : "8.1.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "3700f7679f7d95e36da0b43762189bab189bc53a",
    "build_date" : "2022-03-03T14:20:00.690422633Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
bash-4.2$

Прошу помочь <<< 


```
