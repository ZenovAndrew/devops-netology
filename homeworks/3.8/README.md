# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
Routing entry for 195.46.160.0/19, supernet
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 6d17h ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 6d17h ago
      Route metric is 0, traffic share count is 1
      AS Hops 2
      Route tag 6939
      MPLS label: none

show bgp x.x.x.x/32
BGP routing table entry for 195.46.160.0/19, version 1385533509
Paths: (24 available, best #16, table default)
  Not advertised to any peer
  Refresh Epoch 1
  4901 6079 3356 3216
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE168A8C248 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 3
  3303 3216
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3216:2001 3216:2999 3216:4100 3303:1004 3303:1006 3303:1030 3303:3056
      path 7FE0D3B57088 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 1273 3216
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin IGP, localpref 100, valid, external
      Community: 2516:1030 7660:9003
      path 7FE133433E68 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 3216
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE135EB2A50 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 3356 3216
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:2999 3216:4100 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      path 7FE018532C80 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 3356 3216
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE0440F1C08 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 1103 3216
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      Community: 3216:2001 3216:2999 3216:4100 65000:52254
      path 7FE168E5F630 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 3216
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE1563F1010 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 1273 3216
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30352 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE1877951F0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 3216
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:2999 3216:4100 8283:1 8283:101 65000:52254
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 
      path 7FE0FFFB4B38 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 3216
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:2999 3216:4100 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      path 7FE0A4E6C308 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  2497 3216
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external
      path 7FE133CAD920 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 3216
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE160154EB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 3356 3216
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE0C1CB4BF8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 3216
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE0BD149898 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 3216
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, best
      path 7FE16085E990 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  701 1273 3216
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external
      path 7FE0DA58E3C0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 3356 3216
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8794 3257:30043 3257:50001 3257:54900 3257:54901
      path 7FE0EFAA51C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 3216
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:2999 3216:4100 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
      path 7FE11E822A98 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 6453 6453 3356 3216
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 14315:5000 53767:5000
      path 7FE155DA63A8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 174 3216
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 174:21101 174:22010
      Extended Community: RT:101:22100
      path 7FE0D3491208 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 3216
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE14B5D3460 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 3216
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE0FC467AF0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 174 3216
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 174:21101 174:22010
      path 7FE07FBCB140 RP

```
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
```
andrew@andrew-virtual-machine:~$ sudo modprobe -v dummy
andrew@andrew-virtual-machine:~$ lsmod | grep dummy
dummy                  16384  0
andrew@andrew-virtual-machine:~$ ifconfig -a | grep dummy
andrew@andrew-virtual-machine:~$ sudo ip link add dummy0 type dummy
andrew@andrew-virtual-machine:~$ ifconfig -a | grep dummy
dummy0: flags=130<BROADCAST,NOARP>  mtu 1500
andrew@andrew-virtual-machine:~$ sudo ip addr add 192.168.1.100/24 dev dummy0
andrew@andrew-virtual-machine:~$ sudo ip link set dummy0 up
andrew@andrew-virtual-machine:~$ ip ro sh 192.168.1.100/24
192.168.1.0/24 dev dummy0 proto kernel scope link src 192.168.1.100
andrew@andrew-virtual-machine:~$ sudo route add -net 195.1.201.0 netmask 255.255.255.0 gw 192.168.1.100 dummy0
andrew@andrew-virtual-machine:~$ sudo route add -net 195.1.202.0 netmask 255.255.255.0 gw 192.168.1.100 dummy0
andrew@andrew-virtual-machine:~$ ip route show 
default via 192.168.233.2 dev ens33 proto dhcp metric 100 
169.254.0.0/16 dev ens33 scope link metric 1000 
192.168.1.0/24 dev dummy0 proto kernel scope link src 192.168.1.100 
192.168.233.0/24 dev ens33 proto kernel scope link src 192.168.233.130 metric 100 
195.1.201.0/24 via 192.168.1.100 dev dummy0 scope link 
195.1.202.0/24 via 192.168.1.100 dev dummy0 scope link

```

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
```
andrew@andrew-virtual-machine:~$ sudo netstat -ltnp 
Активные соединения с интернетом (only servers)
Proto Recv-Q Send-Q Local Address Foreign Address State       PID/Program name    
tcp        0      0 0.0.0.0:58381           0.0.0.0:*               LISTEN      1133/rpc.mountd     
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init              
tcp        0      0 0.0.0.0:34449           0.0.0.0:*               LISTEN      1133/rpc.mountd     
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      627/systemd-resolve 
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      14883/cupsd         
tcp        0      0 0.0.0.0:35609           0.0.0.0:*               LISTEN      1133/rpc.mountd     
tcp        0      0 0.0.0.0:44193           0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:2049            0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::58217                :::*                    LISTEN      1133/rpc.mountd     
tcp6       0      0 :::42345                :::*                    LISTEN      1133/rpc.mountd     
tcp6       0      0 :::9100                 :::*                    LISTEN      708/prometheus-node 
tcp6       0      0 :::39117                :::*                    LISTEN      -                   
tcp6       0      0 :::111                  :::*                    LISTEN      1/init              
tcp6       0      0 :::48277                :::*                    LISTEN      1133/rpc.mountd     
tcp6       0      0 ::1:631                 :::*                    LISTEN      14883/cupsd         
tcp6       0      0 :::2049                 :::*                    LISTEN      -                   
tcp6       0      0 :::9090                 :::*                    LISTEN      709/prometheu

```
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

```
andrew@andrew-virtual-machine:~$ sudo netstat -lunp 
Активные соединения с интернетом (only servers)
Proto Recv-Q Send-Q Local Address Foreign Address State       PID/Program name    
udp        0      0 0.0.0.0:52416           0.0.0.0:*                           1133/rpc.mountd     
udp        0      0 0.0.0.0:5353            0.0.0.0:*                           689/avahi-daemon: r 
udp        0      0 0.0.0.0:39148           0.0.0.0:*                           689/avahi-daemon: r 
udp        0      0 0.0.0.0:43261           0.0.0.0:*                           1133/rpc.mountd     
udp        0      0 0.0.0.0:57875           0.0.0.0:*                           -                   
udp        0      0 0.0.0.0:631             0.0.0.0:*                           14884/cups-browsed  
udp        0      0 0.0.0.0:37559           0.0.0.0:*                           1133/rpc.mountd     
udp        0      0 0.0.0.0:2049            0.0.0.0:*                           -                   
udp        0      0 127.0.0.53:53           0.0.0.0:*                           627/systemd-resolve 
udp        0      0 0.0.0.0:111             0.0.0.0:*                           1/init              
udp        0      0 192.168.1.100:123       0.0.0.0:*                           1124/ntpd           
udp        0      0 192.168.233.130:123     0.0.0.0:*                           1124/ntpd           
udp        0      0 127.0.0.1:123           0.0.0.0:*                           1124/ntpd           
udp        0      0 0.0.0.0:123             0.0.0.0:*                           1124/ntpd           
udp6       0      0 :::5353                 :::*                                689/avahi-daemon: r 
udp6       0      0 :::38188                :::*                                1133/rpc.mountd     
udp6       0      0 :::52610                :::*                                -                   
udp6       0      0 :::41772                :::*                                689/avahi-daemon: r 
udp6       0      0 :::50125                :::*                                1133/rpc.mountd     
udp6       0      0 :::2049                 :::*                                -                   
udp6       0      0 :::58440                :::*                                1133/rpc.mountd     
udp6       0      0 :::111                  :::*                                1/init              
udp6       0      0 fe80::200:ff:fe11:1:123 :::*                                1124/ntpd           
udp6       0      0 fe80::993c:9858:62e:123 :::*                                1124/ntpd           
udp6       0      0 ::1:123                 :::*                                1124/ntpd           
udp6       0      0 :::123                  :::*                                1124/ntpd   

```
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали. 

![pics/1.png]
 ---
## Задание для самостоятельной отработки (необязательно к выполнению)

6*. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

7*. Установите bird2, настройте динамический протокол маршрутизации RIP.

8*. Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.

 ---

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Также вы можете выполнить задание в [Google Docs](https://docs.google.com/document/u/0/?tgif=d) и отправить в личном кабинете на проверку ссылку на ваш документ.
Название файла Google Docs должно содержать номер лекции и фамилию студента. Пример названия: "1.1. Введение в DevOps — Сусанна Алиева".

Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. Чтобы это проверить, откройте ссылку в браузере в режиме инкогнито.

[Как предоставить доступ к файлам и папкам на Google Диске](https://support.google.com/docs/answer/2494822?hl=ru&co=GENIE.Platform%3DDesktop)

[Как запустить chrome в режиме инкогнито ](https://support.google.com/chrome/answer/95464?co=GENIE.Platform%3DDesktop&hl=ru)

[Как запустить  Safari в режиме инкогнито ](https://support.apple.com/ru-ru/guide/safari/ibrw1069/mac)

Любые вопросы по решению задач задавайте в чате учебной группы.

---
