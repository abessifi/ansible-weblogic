# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'spec_helper'

oracle_base_dir='/u01/app/oracle'
oracle_middleware_dir="#{oracle_base_dir}/product/middleware"
weblogic_domain_home="#{oracle_middleware_dir}/user_projects/domains/base_domain"
weblogic_nodemanager_home="#{oracle_middleware_dir}/user_projects/nodemanagers/base_domain"

describe "Check default created domain" do

  describe file(weblogic_domain_home) do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe file("#{oracle_middleware_dir}/domain-registry.xml") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain "location=\"#{weblogic_domain_home}\"" }
  end

end

describe "Check WebLogic Nodemanager" do

  describe file("#{weblogic_domain_home}/bin/startNodeManager.sh") do
    it { should contain 'JAVA_OPTIONS="${JAVA_OPTIONS} -Djava.security.egd=file:///dev/urandom -Dweblogic.RootDirectory=${DOMAIN_HOME}"' }
  end

  describe file("#{weblogic_nodemanager_home}/nodemanager.properties") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain "DomainsFile=#{weblogic_nodemanager_home}/nodemanager.domains" }
    it { should contain "StartScriptEnabled=true" }
  end

  describe file("#{weblogic_nodemanager_home}/nodemanager.domains") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain "#{weblogic_domain_home}" }
  end

  describe file("#{weblogic_domain_home}/security/DemoIdentity.jks") do
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

  describe file("#{weblogic_nodemanager_home}/nodemanager.pid") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  describe process('startNodeManage') do
    its(:user) { should eq 'oracle' }
  end

end

describe "Check WebLogic AdminServer" do

  describe file("#{weblogic_domain_home}/servers/AdminServer/security/boot.properties") do
    it { should be_file }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
    it { should contain 'username=' }
    it { should contain 'password=' }
  end

  describe port(7001) do
    it { should be_listening.with('tcp6') }
  end

  describe port(7002) do
    it { should be_listening.with('tcp6') }
  end

end

