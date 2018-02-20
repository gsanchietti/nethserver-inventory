====================
nethserver-inventory
====================

This package collects and send server informations to a remote server.

The inventory uses the ``facter`` software, from puppet (https://docs.puppet.com/facter/).
Facter collects a standard set of informations (like CPU model, runing kernel, etc.) but the system
also gather some custom ``facts``.

Custom facts
============

Scripts for custom facts are inside ``/opt/puppetlabs/puppet/lib/ruby/2.1.0/facter/`` directory.
Each package can register a new custom fact, but this packages always provides the following:

- rpms: list of installed RPMs
- raid: RAID configuration
- templates_custom: list of configured template custom wihout content
- arp_macs: number of network devices
- users: list of configured users
- backup: info about backup status
- esmithdb: all esmith databases, password values are replaced with ``***``

Sending the inventory
=====================

The inventory will be sent every day using cron.
If you want to manually send the inventory, use the following command: ::

  nethserver-inventory -u <URL> -s <SystemId>  

Configuration
=============

The configuration is stored inside the ``configuration`` database under the ``subscription`` key.

Properties:

- ``InventoryUrl``: API endpoint where the data are sent

Make sure that ``SystemId`` property under ``subscription`` key is already set.

NethServer Enterprise subscrptions
----------------------------------

URL: https://my.nethserver.com/api/inventories

To configure execute: ::

  config setprop subscription InventoryUrl https://my.nethserver.com/api/inventories/store
  signal-event nethserver-inventory-update


Nethesis Enterprise subscriptions
---------------------------------

URL: https://my.nethesis.it/isa/inventory/store


To configure execute: ::

  config setprop subscription InventoryUrl https://my.nethesis.it/isa/inventory/store
  signal-event nethserver-inventory-update

