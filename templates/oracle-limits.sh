#!/bin/bash

if [ $USER = "{{ weblogic.user }}" ]; then
  if [ $SHELL = "/bin/ksh" ]; then
    ulimit -p {{ sys_ulimits.nproc[1]['value'] }}
    ulimit -n {{ sys_ulimits.nofile[1]['value'] }}
  else
    ulimit -u {{ sys_ulimits.nproc[1]['value'] }} -n {{ sys_ulimits.nofile[1]['value'] }}
  fi
fi
