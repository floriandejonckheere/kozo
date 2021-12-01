---
layout: home
title: Quickstart
nav_order: 1
---

# Quickstart

## Installation

Please make sure your operating system has Ruby 3.0 or later installed.

Install the application using your operating system's package manager, or using [RubyGems](https://www.rubygems.org)`:

```sh
$ gem install kozo
$ kozo version
kozo 0.2.0
```

## Set up

Create a directory that will hold your infrastructure files.
It is generally a good idea to keep your code version controlled.

```sh
$ mkdir my_app
$ cd my_app
```

Create a `main.kz` file with the following contents:

```ruby
##
# Kozo configuration
#
kozo do
  backend "local" do |b|
    # Defaults to kozo.kzstate
    b.file = "kozo.kzstate"
  end
end

##
# Providers
#
provider "hcloud" do |p|
  # Kozo automatically loads `.env`
  p.key = ENV.fetch("HCLOUD_TOKEN")
end
```

Kozo will look at any files with the extension `.kz` in the current directory and evaluate these in alphabetic order, but `main.kz` is **always evaluated first**.
You are free to structure your code how you want: multiple files, subdirectories, ...
If you wish for Kozo to ignore certain files, create a `.kzignore` file and add them to it.

The `kozo { ... }` block sets up the basic configuration of Kozo, such as the storage backend where the infrastructure state will be kept.
Please refer to [Backends](#backends.md) to see a list of all supported backends.

Create an `.env` file with the Hetzner Cloud token:

```env
HCLOUD_TOKEN = my_token
```

Kozo will automatically load this file before evaluating your code, and is available under the Ruby `ENV` variable.

Next, initialize the local state backend:

```sh
$ kozo init
Kozo initialized in /home/user/my_app
```

This creates the data structures for the infrastructure state as configured in the `kozo { ... }` block.
For the local state, this is merely an empty YAML file at `kozo.kzstate`:

```yaml
---
version: 1
kozo_version: 0.1.0
resources: []
```
