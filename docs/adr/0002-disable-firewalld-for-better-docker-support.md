# 2. Disable Firewalld for better Docker support

Date: 2020-10-26

## Status

Accepted

## Context

Docker has quite a few capabilities to manage firewall rules. Firewalld makes numerous assumptions about how the firewall is managed, one of these being that it (Firewalld) should be the only tool that manages the firewall. There are issues bootstrapping nodes at the moment because of firewalld and operational issues with docker managing the firewall while firewalld is operational.

## Decision

Stop the firewalld service. Disabling the firewalld service is not an option because it creates operational issues with docker. It flushes the iptables while Docker is running requiring a restart.

## Consequences

The rancher cluster setup will be more reliable and secure as we are still filtering with iptables and providing a mechanism to manage the firewall as opposed to disabling the firewall completely.
