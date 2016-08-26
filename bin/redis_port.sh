#!/bin/bash
# discovery port for zabbix redis monitor

exec 2>&1
set -e

netstat -tunlp | grep redis | perl -ne '
   BEGIN{
      my $i = 0;
      my %redis_port;
   }
   chomp;
   $redis_port{$1}++ if /:(\d+)\s/;
   END {
      $| = 1;
      my $data = "{\"data\":[";
      foreach my $key (keys %redis_port){
         $i++;
         $data .= "\{\"{#REDISPORT}\":\"$key\"\}";
         $data .= $i == keys %redis_port
               ?  "]}"
               :  ",";
      }
      print $data;
   }
'
