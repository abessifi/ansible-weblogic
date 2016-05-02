# Ansible WebLogic Role

## Description

This is an Ansible role to install and configure Oracle Weblogic Server on CentOS 7.

## Supported systems

- CentOS

## Requirements

- **Ansible 1.9** or higher (can be easily installed via `pip`. E.g: `sudo pip install ansible==1.9.2`)
- **[Vagrant](https://www.vagrantup.com) 1.7** or higher
- `sshpass` package which is needed by Ansible if you are using SSH authentication by password. On Ubuntu/Debian: `$ sudo apt-get install sshpass`
- **Virtualbox**
- **[Oh-my-box](https://github.com/abessifi/oh-my-box)** tool, optional, if you want to quickly provision and package a Vagrant base box with **Ansible** and **Ruby** pre-installed.

## Dependencies

This version of Oracle WebLogic Server and the Quick Installer require the use of JDK 1.8.  Ensure that you have the proper JDK version installed and ready for use before starting.

Use [this](https://github.com/abessifi/ansible-java) Ansible Java role to install Oracle JDK 8 (Installation: `$ ansible-galaxy install abessifi.java`).

## Role Variables

TODO

# Usage

TODO

# Development and testing

## Test with Vagrant

For quick tests, you can spinup a CentOS VM using Vagrant. You maybe need to adapt the Vagrantfile to suit your environment (IP addresses, etc).

    $ vagrant up

## Run acceptance tests

Acceptance/Integration tests could be run against the role using the magic `test-kitchen` tool. All the written acceptance tests are in the **./test/integration/** directory.

The `.kitchen.yml` file discribes the testing configuration and the list of tests suite to run. By default, your instances will be converged with Ansible and run in Vagrant virtual machines.

To list the instances:

    $ kitchen list

    Instance                            Driver   Provisioner      Verifier  Transport  Last Action
    default-centos-7-x64				Vagrant  AnsiblePlaybook  Busser    Ssh        <Not Created>

To run the default test suite on a CentOS 7 platform, run the following:

    $ kitchen test

## Author

This role was created by [Ahmed Bessifi](https://www.linkedin.com/in/abessifi), a DevOps enthusiast.
