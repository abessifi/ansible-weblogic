# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'spec_helper'

describe "Check WebLogic installation" do

  describe group('oinstall') do
    it { should exist }
  end

  describe user('oracle') do
    it { should exist }
    it { should belong_to_group 'oinstall' }
  end

  describe file('/u01/app/oracle/product/fmw/12.2.1.0/WebLogic_Server') do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end

  ['/etc/oraInst.loc', '/u01/app/oracle/inventory/ContentsXML/inventory.xml'].each do |loc_file|
    describe file(loc_file) do
      it { should exist }
    end
  end

end
