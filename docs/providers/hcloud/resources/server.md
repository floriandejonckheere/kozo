---
layout: home
title: Server
nav_order: 0
parent: HCloud
grand_parent: Providers
---

# Server

A Hetzner Cloud server resource.

## Usage

```ruby
resource "hcloud_server", "default" do |s|
  s.name = "default"
  s.location = "fsn1"
  s.image = "debian-11"
  s.server_type = "cx11"
  s.user_data = File.read("cloud-init.yml")

  s.labels = {
    primary: true,
  }
end
```

## Arguments

- `name` - Name of the SSH key (String)
- `image` - Name or ID of the bootstrap image (String)
- `server_type` - Name of the server type to use (String)
- `location` - Name of the datacenter location (String)
- `datacenter` - Name of the datacenter (String)
- `user_data` - Cloud init YAML (String)
- `ssh_keys` - List of IDs of SSH keys to initialize the server with (String)
- `labels` - User-defined labels (Hash)

## Attributes

- `id` - The unique ID of the SSH key (Integer)
- `name` - Name of the SSH key (String)
- `image` - Name or ID of the bootstrap image (String)
- `server_type` - Name of the server type to use (String)
- `location` - Name of the datacenter location (String)
- `datacenter` - Name of the datacenter (String)
- `user_data` - Cloud init YAML (String)
- `ssh_keys` - List of IDs of SSH keys to initialize the server with (String)
- `locked` - Whether server access is locked (Boolean)
- `labels` - User-defined labels (Hash)
- `created` - Timestamp of creation (Time)
