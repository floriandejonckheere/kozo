---
layout: home
title: Introduction
nav_order: 1
---

# Introduction

Kozo is an Infrastructure as Code (IaC) tool that allows you to declaratively create, change and version your cloud infrastructure.
Infrastructure includes low-level components such as firewall rules and storage volumes, and high-level components like load balancers and servers.

Infrastructure as Code is a paradigm that lets you manage your cloud infrastructure through documented configuration files, rather than pushing commands over SSH or configuring using a GUI.
This ensures that all cloud resources are configured the same way, and do not deviate.
Changes are easily picked up and reverted or incorporated in the configuration.

It is recommended to version control your Kozo configuration as well.
It enables you to track changes over time, and makes it easy to see who applied changes.

Some advantages of Kozo:

- Written in the language you already know and love: [Ruby](https://www.ruby-lang.org/)
- Provides a consistent, repeated and easy provisioning of resources
- Allows you to manage many types of resources on multiple cloud platforms

## Further reading

- Install Kozo and try your hand at managing cloud resources using the [quickstart guide](quickstart)
- Browse the supported [providers](providers) and see the resources you can manage
