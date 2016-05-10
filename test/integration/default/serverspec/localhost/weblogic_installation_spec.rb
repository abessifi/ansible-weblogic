# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'spec_helper'
require 'wls_params'

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

  SYS_KERNEL_PARAMS.each do |sys_key, sys_value|
    context linux_kernel_parameter(sys_key) do
      its(:value) { should eq sys_value }
    end
  end

  describe file('/etc/sysctl.conf') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
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

  describe file(ORACLE_MIDDLEWARE_DIR) do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  ['/etc/oraInst.loc',
   "#{ORACLE_BASE_DIR}/inventory/ContentsXML/inventory.xml"
  ].each do |loc_file|
    describe file(loc_file) do
      it { should exist }
    end
  end

  describe file("#{ORACLE_MIDDLEWARE_DIR}/oracle_common/common/bin/wlst.sh") do
    it { should contain "JVM_ARGS=\"-Dprod.props.file" }
  end

end

describe "Check Ansible custom facts" do
  describe file('/etc/ansible/facts.d/weblogic.fact') do
    it { should contain "version=12c" }
    it { should contain "release=12.2.1.0" }
  end

end
