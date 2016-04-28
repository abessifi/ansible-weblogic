# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'spec_helper'

oracle_base_dir='/u01/app/oracle'
oracle_middleware_dir="#{oracle_base_dir}/product/middleware"

describe "Check installation prerequisites" do

  describe "in centos 7 distribution",
    :if => (os[:family] == 'redhat' && os[:release].start_with?('7.2')) do

      describe file('/etc/selinux/config') do
        it { should contain '^SELINUX=disabled' }
      end
      describe service('firewalld') do
        it { should_not be_enabled }
      end
  end

  describe file('/etc/sysctl.conf') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should contain "kernel.shmmax=2147483648" }
    it { should contain "net.core.rmem_max=16777216" }
    it { should contain "net.ipv4.tcp_rmem=4096 87380 16777216" }
    it { should contain "vm.swappiness=10" }
    it { should contain "fs.file-max=262144" }
    it { should contain "net.ipv4.tcp_keepalive_time=300" }
  end

  describe command("sysctl -a") do
    its(:stdout) { should match /^kernel\.shmmax = 2147483648$/ }
    its(:stdout) { should match /^net\.core\.rmem_max = 16777216$/ }
    its(:stdout) { should match /^net\.ipv4\.tcp_rmem = 4096\s+87380\s+16777216$/ }
    its(:stdout) { should match /^vm\.swappiness = 10$/ }
    its(:stdout) { should match /^fs\.file-max = 262144$/ }
    its(:stdout) { should match /^net\.ipv4\.tcp_keepalive_time = 300$/ }
  end

  ['/etc/security/limits.d/99-nofile.conf',
   '/etc/security/limits.d/99-nproc.conf'
  ].each do |ulimits_conf_file|
    describe file(ulimits_conf_file) do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end

end

describe "Check WebLogic installation" do

  describe group('oinstall') do
    it { should exist }
  end

  describe user('oracle') do
    it { should exist }
    it { should belong_to_group 'oinstall' }
  end

  describe file(oracle_middleware_dir) do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  ['/etc/oraInst.loc',
   "#{oracle_base_dir}/inventory/ContentsXML/inventory.xml"
  ].each do |loc_file|
    describe file(loc_file) do
      it { should exist }
    end
  end

  describe file("#{oracle_middleware_dir}/oracle_common/common/bin/wlst.sh") do
    it { should contain "JVM_ARGS=\"-Dprod.props.file" }
  end

end
