# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'spec_helper'
require 'wls_params'

describe "Check default created domain" do

  describe file(WEBLOGIC_DOMAIN_HOME) do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe file("#{ORACLE_MIDDLEWARE_DIR}/domain-registry.xml") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain "location=\"#{WEBLOGIC_DOMAIN_HOME}\"" }
  end

end

describe "Check WebLogic Nodemanager" do

  describe file("#{WEBLOGIC_DOMAIN_HOME}/bin/startNodeManager.sh") do
    it { should contain 'JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.security.egd=file:///dev/urandom -Dweblogic.RootDirectory=${DOMAIN_HOME}"' }
  end

  describe file("#{WEBLOGIC_NODEMANAGER_HOME}/nodemanager.properties") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain "DomainsFile=#{WEBLOGIC_NODEMANAGER_HOME}/nodemanager.domains" }
    it { should contain "StartScriptEnabled=true" }
  end

  describe file("#{WEBLOGIC_NODEMANAGER_HOME}/nodemanager.domains") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain "#{WEBLOGIC_DOMAIN_HOME}" }
  end

  describe file("#{WEBLOGIC_DOMAIN_HOME}/security/DemoIdentity.jks") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe port(5556) do
    it { should be_listening.with('tcp6') }
  end

  describe service('nodemanager') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file("#{WEBLOGIC_NODEMANAGER_HOME}/nodemanager.process.id") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe command('pgrep -a java -u oracle | grep \'weblogic.NodeManager\'') do
    its(:exit_status) { should eq 0 }
  end

end

describe "Check WebLogic AdminServer" do

  describe file("#{WEBLOGIC_DOMAIN_HOME}/bin/setUserOverrides.sh") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should be_mode 750 }
    it { should contain 'USER_MEM_ARGS="-Xms1024m -Xmx1024m"' }
    it { should contain 'JAVA_OPTIONS="-Djava.security.egd=file:///dev/urandom"' }
  end

  describe file("#{WEBLOGIC_ADMIN_SERVER_HOME}") do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe file("#{WEBLOGIC_ADMIN_SERVER_HOME}/security/boot.properties") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain 'username=' }
    it { should contain 'password=' }
  end

  describe command('pgrep -a java -u oracle | egrep \'Dweblogic.Name=AdminServer.*weblogic.Server$\'') do
    its(:exit_status) { should eq 0 }
  end

  describe port(7001) do
    it { should be_listening.with('tcp6') }
  end

  describe port(7002) do
    it { should be_listening.with('tcp6') }
  end

end

describe "Check WebLogic ManagedServer" do

  describe file(WEBLOGIC_MANAGED_SERVER_HOME) do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe file("#{WEBLOGIC_MANAGED_SERVER_HOME}/security/boot.properties") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain 'username=' }
    it { should contain 'password=' }
  end

  describe command('pgrep -a java -u oracle | egrep \'Dweblogic.Name=ManagedServer1.*weblogic.Server$\'') do
    its(:exit_status) { should eq 0 }
  end

  describe port(7002) do
    it { should be_listening.with('tcp6') }
  end

end
