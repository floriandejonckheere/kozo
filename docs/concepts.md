---
layout: home
title: Concepts
nav_order: 2
---

# Concepts

## Configuration

Configuration is the collection of providers, backends and resources defined in your local `*.kz` files.
These files lay down how you want your cloud infrastructure to look like.

Kozo recursively evaluates all `*.kz` files in the working directory in alphabetical order, with the exception of `main.kz` which is always evaluated first, if it exists.
It is good practice to define base configuration (such as backend and providers) in `main.kz`.

## State

Kozo keeps a local representation of how your cloud infrastructure looks like.
It does this to enable keeping track of changes in remote infrastructure, save metadata and improve performance in general.
This local state is updated every time you plan changes to your configuration or apply them.

Kozo stores the state using a [backend](#backend).

## Provider

A provider is a software library that Kozo uses to interface with cloud providers and external APIs.
They are written alongside and built into the main application, but need to be configured with correct credentials before you can use them.

Please refer to the section on [Providers](providers) for more information on how to use them.

## Resource

A resource represents an entity in the remote cloud infrastructure.
It can represent a server, a storage volume, a firewall and much more.
Abstract entities such as assignments (volume is attached to server) are also modeled as resources.

Please refer to the documentation of specific [providers](providers) for more information on the available resources and how to use them.

## Backend

Backends are ways that Kozo stores its local state.
The most simple backend is the [local backend](backends/local), that stores the state in the `kozo.kzstate` file.
This can get you started quickly, but has several drawbacks:
- It does not allow you to collaborate on infrastructure
- It puts you in charge of backups in case of data loss

More advanced backends provide error resiliency, backups and the ability to work in parallel with collaborators.

Please refer to the section on [Backends](backends) for more information on how to use them.
