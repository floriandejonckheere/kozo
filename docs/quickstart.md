---
layout: home
title: Quickstart
nav_order: 1
---

# Quickstart

## Installation

Make sure your operating system has Ruby 3.0 or later installed.

Install the application using your operating system's package manager, or using [RubyGems](https://www.rubygems.org):

```sh
$ gem install kozo
$ kozo version
kozo 0.2.0
```

## Set up directory

Create a directory that will hold your infrastructure files.
It is generally a good idea to keep your code under version control.

```sh
$ mkdir my_app
$ cd my_app
$ git init
Initialized empty Git repository in /home/user/my_app/.git/
```

Add some useful exceptions to `.gitignore`:

```
### Kozo ###
*.kzstate
*.kzbackup
```

## Set up backend

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
```

Kozo will look at any files with the extension `.kz` in the current directory and evaluate these in alphabetic order, except `main.kz` which is **always evaluated first**.
You are free to structure your code however you see fit: multiple files, subdirectories, ...
If you wish Kozo to ignore certain files or patterns, create a `.kzignore` file and add them to it:

```
/tmp/
*.bak.kz
```

The `kozo { ... }` block sets up the basic configuration of Kozo, such as the storage backend where the infrastructure state will be kept.
Please refer to [Backends](backends.md) to see a list of all supported backends.

Next, initialize the local state backend:

```sh
$ kozo init
Kozo initialized in /home/user/my_app
```

This creates the data structures for the infrastructure state as configured in the `kozo { ... }` block.
For the local state, this is merely an empty `kozo.kzstate` file.

## Set up provider

Append to `main.kz`:

```ruby
##
# Providers
#
provider "hcloud" do |p|
  # Kozo automatically loads `.env`
  p.key = ENV.fetch("HCLOUD_TOKEN")
end
```

The `provider` directive instructs Kozo to register a new [provider](providers.md) with the name `hcloud`.
Passed to the block is the provider instance, which can be configured with the right credentials.

Create an `.env` file with the Hetzner Cloud token:

```env
HCLOUD_TOKEN = my_token
```

Kozo will automatically load this file before evaluating your code, and is available under the Ruby `ENV` variable.
