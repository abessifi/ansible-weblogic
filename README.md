oracle-weblogic
===============

Ansible role to install and configure Oracle Weblogic Server.

Requirements
------------

Download oracle weblogic installers from http://www.oracle.com/technetwork/middleware/weblogic/downloads/index.html

Role Variables
--------------

**defaults file for ansible-oracle-wls**

*required if tag 'install' will be executed*

- **oracle_weblogic_version**: 12c or 11g
- **oracle_weblogic_release**: 12.2.1 or 10.3.6
- **oracle_weblogic_quick_installation**: yes or no

- **oracle_weblogic_install_type**: Complete with Examples # WebLogic Server, Coherence, Complete with Examples

- **oracle_weblogic_jar**: JAR installer path

**vars file for ansible-oracle-wls**

*it is recommended to keep these vars by default*

- **oracle_oracle.user**: oraclefmw
- **oracle_oracle.group**: ofmwinstall
- **oracle_oracle.user_home**: /opt/oraclefmw

- **oracle_weblogic_oracle_home**: /opt/oraclefmw/product/oracle_home
- **oracle_weblogic_wls_home**: "{{ oracle_weblogic_oracle_home }}/wlserver"

- **oracle_weblogic_inventory_directory**: /opt/oraclefmw/inventory
- **oracle_weblogic_inventory_file**: /opt/oraclefmw/oraInst.loc

- **oracle_weblogic_response_file**: "{{ oracle_oracle.user_home }}/wls.rsp"

- **oracle_weblogic_already_installed**: false

Dependencies
------------

- java 8

The Oracle WebLogic Server 12.2.1 Quick Installer is a lightweight installer that contains all the necessary artifacts to develop and test applications on Oracle WebLogic Server 12.2.1.  The Quick Installer does not have a user interface and is run directly from command line. The Quick Installer is supported on Windows, Linux and Mac OS X systems. Installations performed with the Quick Installer can be patched using standard Oracle Patching tool, OPatch.



An optional supplemental quick installer (fmw_12.2.1.0.0_wls_supplemental_quick.jar) is available as a separate download and contains additional, non essential components such as the sample set, the Http Pub-Sub server and L10N console help files.

This version of Oracle WebLogic Server and the Quick Installer require the use of JDK 1.8.  Ensure that you have the proper JDK version installed and ready for use before starting.



Example Playbook
----------------

Go to tests/test.yml

License
-------

MIT

Author Information
------------------

Jorge Quilcate (jorge.quilcate@sysco.no)
