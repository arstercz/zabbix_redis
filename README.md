# zabbix_redis
  multiport redis monitor for zabbix with low level discovery methods.

## Require
    nc.x86_64

## Install

Configure Redis connectivity on Zabbix Agent

```
    1. # git clone https://github.com/chenzhe07/zabbix_redis.git /usr/local/zabbix_redis
    2. # bash /usr/local/zabbix_mysql/install.sh
```

* note: redis should be listen on 127.0.0.1 or 0.0.0.0.

Configure Zabbix Server
    
```
    1. import templates/zbx_redis_multiport_templates.xml using Zabbix UI(Configuration -> Templates -> Import), and Create/edit hosts by assigning them and linking the template "redis_zabbix" (Templates tab).
```

## Note

* As zabbix process running by zabbix user, netstat must run with following command:
```
    chmod +s /bin/netstat
```

## Test

```
# zabbix_get -s cz-test1 -k "redis.discovery" | python -m json.tool
{
    "data": [
        {
            "{#REDISPORT}": "6381"
        }, 
        {
            "{#REDISPORT}": "6380"
        }
    ]
}
# zabbix_get -s cz-test1 -k "redis_stats[6380, role]"
master
# zabbix_get -s cz-test1 -k "redis_stats[6380, total_commands_processed]"
5958568
```
