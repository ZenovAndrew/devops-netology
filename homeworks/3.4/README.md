### Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

#### 1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter: 

- поместите его в автозагрузку,
- предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на `systemctl cat cron`),
- удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.


```
andrew@andrew-virtual-machine:/etc/systemd/system$ cat node_exporter.service 
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
EnvironmentFile=-/etc/default/node.conf
ExecStart=/usr/bin/prometheus-node-exporter $NODE_OPT
Restart=always

[Install]
WantedBy=multi-user.target
andrew@andrew-virtual-machine:/etc/systemd/system$ cat /etc/default/node.conf
NODE_OPT=""
andrew@andrew-virtual-machine:/etc/systemd/system$ systemctl status node_exporter
● node_exporter.service - Prometheus Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; disabled; vendor preset: enabled)
     Active: active (running) since Mon 2021-11-29 11:18:58 MSK; 44s ago
   Main PID: 4561 (prometheus-node)
      Tasks: 8 (limit: 2184)
     Memory: 7.7M
     CGroup: /system.slice/node_exporter.service
             └─4561 /usr/bin/prometheus-node-exporter

ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - stat" source="node_exporter.go:104"
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - systemd" source="node_exporter.go:>
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - textfile" source="node_exporter.go>
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - time" source="node_exporter.go:104"
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - timex" source="node_exporter.go:10>
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - uname" source="node_exporter.go:10>
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - vmstat" source="node_exporter.go:1>
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - xfs" source="node_exporter.go:104"
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg=" - zfs" source="node_exporter.go:104"
ноя 29 11:18:58 andrew-virtual-machine prometheus-node-exporter[4561]: time="2021-11-29T11:18:58+03:00" level=info msg="Listening on :9100" source="node_expo>

```
![pics/1.png]


#### 2. Ознакомьтесь с опциями node_exporter и выводом `/metrics` по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

CPU: время, использованное системой и программами;
высокий steal означает, что гипервизор перегружен и процессор занят другими ВМ;
iowait - поможет отследить, всё ли в порядке с дисковой системой.  
```shell
node_cpu_seconds_total{cpu="0",mode="idle"} 178.81
node_cpu_seconds_total{cpu="0",mode="system"} 2.98
node_cpu_seconds_total{cpu="0",mode="user"} 2.15


```
MEM: MemTotal - количество памяти; 
MemFree и MemAvailable - свободная и доступная память; 
SwapTotal, SwapFree, SwapCached - если не хватает RAM.

```shell
node_memory_MemAvailable_bytes 7.86436096e+08
node_memory_MemFree_bytes 6.93653504e+08
node_memory_MemTotal_bytes 1.028694016e+09


```

DISK: size_bytes и avail_bytes  объём и свободное место; 
readonly=1 может говорить о проблемах ФС, из-за чего она перешла в режим только для чтения;
io_now - интенсивность работы с диском в текущий момент.
```shell
node_disk_io_time_seconds_total{device="sda"} 16.908
node_disk_read_bytes_total{device="sda"} 2.32109056e+08
node_disk_write_time_seconds_total{device="sda"} 3.802


```

NET: carrier_down, carrier_up - высокое значение - проблема с физическим подключением; 
info - общая информация по интерфейсу; 
mtu_bytes - диагностика потерь когда трафик с хостов не проходит через маршрутизатор; 
receive_errs_total, transmit_errs_total, receive_packets_total, transmit_packets_total - ошибки передачи,проблемы сети или с хостом
```shell
node_network_receive_errs_total{device="eth0"} 0
node_network_transmit_errs_total{device="eth0"} 0
node_network_up{device="eth0"} 1

```

#### 3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (`sudo apt install -y netdata`). После успешной установки:

- в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`,
```shell
$ sudo nano /etc/netdata/netdata.conf
$ grep -e bind -e web /etc/netdata/netdata.conf
	web files owner = root
	web files group = root
	# bind socket to IP = 127.0.0.1
	bind to = 0.0.0.0
```
- добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:  
```shell
config.vm.network "forwarded_port", guest: 19999, host: 19999
```
```shell
% sudo nano vagrantfile
% vagrant reload
% vagrant port
The forwarded ports for the machine are listed below. Please note that
these values may differ from values configured in the Vagrantfile if the
provider supports automatic port collision detection and resolution.

    22 (guest) => 2222 (host)
 19999 (guest) => 19999 (host)
  9100 (guest) => 9100 (host)
```

После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.  

http://localhost:19999

![pics/2.png]
#### 4. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Да можно, если выполнить dmesg | grep virt, то на выводе будут строки
```shell
$ dmesg | grep virt
[    0.003436] CPU MTRRs all blank - virtualized system.
[    0.111183] Booting paravirtualized kernel on KVM
[    4.833310] systemcmd[1]: Detected virtualization oracle.
```


#### 5. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?

```shell
$ sysctl fs.nr_open
fs.nr_open = 1048576
```
fs.nr_open - жесткий лимит на открытые дескрипторы для ядра (системы)
```shell
$ ulimit -Sn
1024
```
Soft limit на пользователя, может быть изменен как большую, так и меньшую сторону  
```shell
$ ulimit -Hn
1048576
```
Hard limit на пользователя, может быть изменен только в меньшую сторону  
Оба `ulimit` -n не могут превышать `fs.nr_open`

#### 6. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.

Terminal #1
```shell
vagrant@vagrant:~$ sudo unshare -f --pid --mount-proc sleep 1h
```
Terminal #2
```shell
vagrant@vagrant:~$ ps -e | grep sleep
   1789 pts/0    00:00:00 sleep
vagrant@vagrant:~$ sudo nsenter --target 1789 --mount --uts --ipc --net --pid ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   9828   580 pts/0    S+   09:34   0:00 sleep 1h
root           6  0.0  0.3  13216  3336 pts/1    R+   09:39   0:00 ps aux
```

#### 7. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

Данная запись  - Fork bomb. Функция, которая вызывает себя дважды при каждом вызове и не имеет возможности завершить себя. Функция будут плодить своих потомков пока не закончатся системные ресурсы. 
:() означает, что вы определяете функцию под названием :
{:|: &} означает, что запустите функцию : и снова отправьте свой вывод в функцию : и запустите ее в фоновом режиме.
; является разделителем команд, как &&.
: запускает функцию в первый раз.
Вывод dmesg после form bomb:
[ 1124.447515] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-6.scope
Ограничить можно с использованием ulimit -u 30. 
В данном случае число процессов будет ограниченно 30 для пользователя
Значение по умолчанию 3571
