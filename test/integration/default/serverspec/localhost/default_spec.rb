# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'spec_helper'

describe "Check for prerequisites" do

  describe "in centos 7 distribution", :if => (os[:family] == 'redhat' && os[:release].start_with?('7.2')) do
    describe package('jdk1.8.0_77') do
      it { should be_installed }
    end
    describe command('java -version') do
      its(:stderr) { should include 'java version "1.8.0' }
    end
  end

end

