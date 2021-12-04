---
layout: home
title: SSH key
nav_order: 0
parent: HCloud
grand_parent: Providers
---

# SSH key

A Hetzner Cloud SSH key resource to manage server access.

## Usage

```ruby
resource "hcloud_ssh_key", "default" do |s|
  s.name = "default"
  s.public_key = File.read("#{Dir.home}/.ssh/id_rsa.pub")

  s.labels = {
    primary: true,
  }
end
```

## Arguments

- `name` - Name of the SSH key (String)
- `public_key` - RSA public key (String)
- `labels` - User-defined labels (Hash)

## Attributes

- `id` - Unique ID of the SSH key (Integer)
- `name` - Name of the SSH key (String)
- `public_key` - RSA public key (String)
- `labels` - User-defined labels (Hash)
- `created` - Timestamp of creation (Time)
