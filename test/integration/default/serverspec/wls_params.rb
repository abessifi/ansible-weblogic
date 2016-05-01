# -*- mode: ruby -*-
# vi: set ft=ruby :

ORACLE_BASE_DIR="/u01/app/oracle"
ORACLE_MIDDLEWARE_DIR="#{ORACLE_BASE_DIR}/product/middleware"
WEBLOGIC_DOMAIN_HOME="#{ORACLE_MIDDLEWARE_DIR}/user_projects/domains/base_domain"
WEBLOGIC_NODEMANAGER_HOME="#{ORACLE_MIDDLEWARE_DIR}/user_projects/nodemanagers/base_domain"
WEBLOGIC_ADMIN_SERVER_HOME="#{WEBLOGIC_DOMAIN_HOME}/servers/AdminServer"
WEBLOGIC_MANAGED_SERVER_HOME="#{WEBLOGIC_DOMAIN_HOME}/servers/ManagedServer1"

SYS_KERNEL_PARAMS = {
  'vm.swappiness' => 10,
  'kernel.shmmax' => 2147483648,
  'net.core.rmem_max' => 16777216,
  'fs.file-max' => 262144,
  'net.ipv4.tcp_keepalive_time' => 300,
}

