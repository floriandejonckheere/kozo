---
layout: home
title: HCloud
nav_order: 0
parent: Providers
has_children: true
---

# HCloud

The HCloud provider implements the [Hetzner Cloud API](https://docs.hetzner.cloud/).

## Configuration

Generate a Hetzner Cloud API token for your project, and set it in `.env`:

```sh
HCLOUD_TOKEN=mytoken
```

Then configure the provider in `main.kz`:

```ruby
provider "hcloud" do |p|
  p.key = ENV.fetch("HCLOUD_TOKEN")
end
```

`ENV` is automatically populated with the values in `.env`.
