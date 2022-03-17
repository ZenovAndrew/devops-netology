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
# version 1.0
FROM    centos:7
ENV     ES_HOME=/opt/elasticsearch/
ENV     USER=elastic
WORKDIR $ES_HOME/elasticsearch-8.1.0

RUN     useradd -d $ES_HOME -m -s /bin/bash $USER && \
        mkdir /var/lib/data && \
        mkdir /var/lib/logs && \
        chown $USER /var/lib/data && \
        chown $USER /var/lib/logs && \
        yum -y install wget && \
        yum -y install perl-Digest-SHA && \
        cd $ES_HOME && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512 && \
        shasum -a 512 -c elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512  && \
        tar -zxvf elasticsearch-8.1.0-linux-x86_64.tar.gz && \
        echo "node.name: netology_test" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "path.data: /var/lib/data" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "path.logs: /var/lib/logs" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "xpack.security.enabled: false" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "network.host: 0.0.0.0" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        echo "discovery.type: single-node" >> elasticsearch-8.1.0/config/elasticsearch.yml && \
        chown -R $USER $ES_HOME/elasticsearch-8.1.0 && \
        rm -f elasticsearch-8.1.0-linux-x86_64.tar.gz elasticsearch-8.1.0-linux-x86_64.tar.gz.sha512


USER   $USER

EXPOSE 9200 9300

CMD ["./bin/elasticsearch"]


root@test1:/home/vagrant/6.5# docker build . -t zenova/elasticsearch:8.1.0

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

root@test1:/home/vagrant# curl -X GET localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "aI-Aw_pAS0CY2ZEWivGgqQ",
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



```


## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

```

root@test1:/home/vagrant# curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}

root@test1:/home/vagrant# curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}
root@test1:/home/vagrant# curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}


```
Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.
```

#Список индексов
root@test1:/home/vagrant# curl -X GET localhost:9200/_cat/indices?v
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 7N83wxS5R4iYjK-h5UWzag   1   0          0            0       225b           225b
yellow open   ind-3 5udjGu3kS9C5shcrklRoZQ   4   2          0            0       900b           900b
yellow open   ind-2 XmtsgKxGS1W1iTvVyPdBvw   2   1          0            0       450b           450b
 
# Статус индексов
root@test1:/home/vagrant# curl -X GET localhost:9200/_cluster/health/ind-1?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
root@test1:/home/vagrant# curl -X GET localhost:9200/_cluster/health/ind-2?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
root@test1:/home/vagrant# curl -X GET localhost:9200/_cluster/health/ind-3?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}


```
Получите состояние кластера `elasticsearch`, используя API.
```

root@test1:/home/vagrant# curl -X GET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```
Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

```
Часть индексов и кластер находятся в состоянии yellow, потому что присутствуют неназначенные шарды.
Т.к. у нас поднята одна node, а индексы ind-2 и ind-3 созданы с указанием количества реплик, соответственно требуют наличия дополнительных реплик. Т.к. других нод нет, реплицировать некуда.
```

Удалите все индексы.
```
root@test1:/home/vagrant# curl -X DELETE localhost:9200/ind-1?pretty
{
  "acknowledged" : true
}
root@test1:/home/vagrant# curl -X DELETE localhost:9200/ind-2?pretty
{
  "acknowledged" : true
}
root@test1:/home/vagrant# curl -X DELETE localhost:9200/ind-3?pretty
{
  "acknowledged" : true
}
root@test1:/home/vagrant# curl -X GET localhost:9200/_cat/indices?v
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size

```
**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.


## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

```

root@test1:/home/vagrant/6.5# curl -X PUT 'localhost:9200/_snapshot/netology_backup' -H 'Content-Type: application/json' 
 -d '{ "type": "fs", "settings": { "location": "/opt/elasticsearch/elasticsearch-8.1.0/snapshots",  "compress": true } }'
 
{"acknowledged":true}



root@test1:/home/vagrant/6.5# curl -X GET "localhost:9200/_snapshot/netology_backup?pretty"
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "compress" : "true",
      "location" : "/opt/elasticsearch/elasticsearch-8.1.0/snapshots"
    }
  }
}
```



Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

```

root@test1:/home/vagrant/6.5# curl -X PUT -H "Content-Type: application/json" http://localhost:9200/test?pretty -d '{
"settings": {
	"index": {
		"number_of_shards": 1,
		"number_of_replicas": 0
		}
	}
}'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test"
}

root@test1:/home/vagrant/6.5#  curl -X GET localhost:9200/_cat/indices?v
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  extaUbjdTl-HrkbhDNDXYQ   1   0          0            0       225b           225b

root@test1:/home/vagrant/6.5#  curl -X PUT "localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true"
{"snapshot":{"snapshot":"elasticsearch","uuid":"50BdDkD7TSemC5CdUUXgpA","repository":"netology_backup","version_id":8010099,"version":"8.1.0","indices":[".geoip_databases","test"],"data_streams":[],"include_global_state":true,"state":"SUCCESS","start_time":"2022-03-17T08:33:21.849Z","start_time_in_millis":1647506001849,"end_time":"2022-03-17T08:33:23.059Z","end_time_in_millis":1647506003059,"duration_in_millis":1210,"failures":[],"shards":{"total":2,"failed":0,"successful":2},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}root@test1:/home/vagrant/6.5#
root@test1:/home/vagrant/6.5#

```

**Приведите в ответе** список файлов в директории со `snapshot`ами.

```
root@test1:/home/vagrant/6.5# docker exec -it elastic bash
bash-4.2$ ls /opt/elasticsearch/elasticsearch-8.1.0/snapshots/
index-0  index.latest  indices  meta-50BdDkD7TSemC5CdUUXgpA.dat  snap-50BdDkD7TSemC5CdUUXgpA.dat
```


Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```

root@test1:/home/vagrant/6.5# curl -X DELETE "localhost:9200/test?pretty"
{
  "acknowledged" : true
}
root@test1:/home/vagrant/6.5# curl -X PUT "localhost:9200/test-2" -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}root@test1:/home/vagrant/6.5#
root@test1:/home/vagrant/6.5# curl -X GET "localhost:9200/_cat/indices?v"
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 sId9_PgBQk2KfhjbMKiKow   1   0          0            0       225b           225b
root@test1:/home/vagrant/6.5#
```
[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```
root@test1:/home/vagrant/6.5# curl -X POST "localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty" -H '
Content-Type: application/json' -d' { "indices": "*", "include_global_state": true }'
{
  "accepted" : true
}
root@test1:/home/vagrant/6.5# curl -X GET "localhost:9200/_cat/indices?v"
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 sId9_PgBQk2KfhjbMKiKow   1   0          0            0       225b           225b
green  open   test   OeAOzjfjT-6raU4_XIbLFw   1   0          0            0       225b           225b
```

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`



---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
