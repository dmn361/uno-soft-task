# Задание

Создать Docker Compose скрипт для развертки кластера из трех инстансов cassandra, причем каждый из них должен быть доступен из основной (локальной) сети по отдельному ip адресу.

1. На машине А (ubuntu 24.04 lts) в локальной сети с ip 192.168.1.197 запускается скрипт docker-compose для поднятия 3 образов с ip адресами 192.168.1.200-202.
2. Затем с машины Б (ubuntu 24.04 lts) из той же локальной сети с ip 192.168.1.198 необходимо подключиться через cqlsh к каждой из машин-образов.
3. Настроить ssh для возможности подключения к 1.200 с 1.197
4. Все приведённые операции необходимо задокументировать и описать инструкцией с командами и объяснениями в Readme
5. Добавить скриншот результата в Readme.

# Решение

Выполнялось задание на гипервизоре Virtualbox. Если ваш сетевой интерфейс - не `enp0s3`, то необходимо заменить его в `ipvlan.sh` и `docker-compose.yml`

Ubuntu 24.04 LTS, 50GB Storage, 2 CPUs, 4GB RAM, Bridge Adapter

При установке необходимо задать статические IP-адреса по условию задачи ("Машина А" - 1.197, "Машина Б" - 1.198) в сети 192.168.1.0/24

![Screenshot 2025-08-23 112927.png](https://github.com/dmn361/uno-soft-task/blob/main/pics/Screenshot%202025-08-23%20112927.png)

## На "Машине А":

1. Клонировать репозиторий
```
git clone https://github.com/dmn361/uno-soft-task.git
cd uno-soft-task
```

2. Устновить Docker
```
./install_docker.sh
```

3. Устновить сервис, который при запуске системы создаёт интерфейс, позволяющий взаимодействовать с контейнерами в сети IPvlan L2
```
./install_service.sh
```
4. Сгенерировать SSH-ключ и скопировать его в директорию
```
ssh-keygen -t ed25519 && cp ~/.ssh/id_ed25519.pub .
```

5. Собрать и запустить кластер Cassandra
```
sudo docker compose build
sudo docker compose up -d
```

6. Запустить сервис SSH в контейнере `cassandra-1`
```
sudo docker exec -it cassandra-1 service ssh start
```

7. Подключиться к контейнеру `cassandra-1` по SSH
```
ssh root@192.168.1.200
```
![Screenshot 2025-08-23 160531.png](https://github.com/dmn361/uno-soft-task/blob/main/pics/Screenshot%202025-08-23%20160531.png)

## На "Машине Б"

1. Установить `cqlsh`
```
sudo snap install cqlsh
```

2. Подключиться к необходимому контейнеру
```
cqlsh 192.168.1.200 # 201, 202
```

![Screenshot 2025-08-23 160221.png](https://github.com/dmn361/uno-soft-task/blob/main/pics/Screenshot%202025-08-23%20160221.png)
