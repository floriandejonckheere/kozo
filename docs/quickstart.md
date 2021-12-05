---
layout: home
title: Quickstart
nav_order: 3
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

Kozo will look at any files with the extension `.kz` in the current directory and evaluate these in alphabetical order, except `main.kz` which is **always evaluated first**.
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

## Create a resource

First, generate a public/private keypair:

```sh
ssh-keygen -f id_rsa -b 4096 -C "SSH Key" -P ""
```

Append to `main.kz`:

```ruby
###
# Resources
#
resource "hcloud_ssh_key", "default" do |s|
  s.name = "default"
  s.public_key = File.read("id_rsa.pub")
end
```

The `resource` directive instructs Kozo to create a new resource of type `hcloud_ssh_key` with name `default`.
The latter two can be combined to form the resource's address: `hcloud_ssh_key.default`.
Subsequently, the resource can be configured by setting properties on the yielded object.
In this case, the name and contents of the public key can be set.

The first step of syncing configuration using Kozo is checking the execution plan:

```sh
$ kozo plan
Kozo analyzed the state and created the following execution plan. Actions are indicated by the following symbols:
 + create
 ~ update
 - destroy

Kozo will perform the following actions:
# hcloud_ssh_key.default:
+ resource "hcloud_ssh_key", "default" do |r|
     r.id         = (known after apply)
  +  r.name       = "default"
  +  r.public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/Zqnnfg24uLaKybQXEkhSs4rqqbKYLvPg..."
     r.labels     = (known after apply)
     r.created    = (known after apply)
end

```

You can see in the execution plan that Kozo will create one resource with the properties configured in the `main.kz` file.

Next, actually create the resource by applying the changes:

```sh
$ kozo apply
Kozo analyzed the state and created the following execution plan. Actions are indicated by the following symbols:
 + create
 ~ update
 - destroy

Kozo will perform the following actions:
# hcloud_ssh_key.default:
+ resource "hcloud_ssh_key", "default" do |r|
     r.id         = (known after apply)
  +  r.name       = "default"
  +  r.public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/Zqnnfg24uLaKybQXEkhSs4rqqbKYLvPg..."
     r.labels     = (known after apply)
     r.created    = (known after apply)
end

hcloud_ssh_key.default: creating resource
hcloud_ssh_key.default: created resource

```

And that's that, the SSH key was created successfully.

## Update a resource

Now change the name of the SSH key in the configuration file and run `kozo plan` again.
You'll see something similar to this:

```sh
$ kozo plan
...

# hcloud_ssh_key.default:
~ resource "hcloud_ssh_key", "default" do |r|
     r.id         = (known after apply)
  ~  r.name       = "new_default"
     r.public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/Zqnnfg24uLaKybQXEkhSs4rqqbKYLvPg..."
     r.labels     = (known after apply)
     r.created    = (known after apply)
end

...
```

Try changing the name of the SSH key in the Hetzner Cloud panel as well.
You'll see that Kozo tries to revert the name change.

## Destroy a resource

Instruct Kozo that the resource should be deleted simply by removing the relevant lines in the `main.kz` file.
Running `kozo plan` gives you the following:

```sh
$ kozo plan
...

# hcloud_ssh_key.default:
- resource "hcloud_ssh_key", "default" do |r|
  -  r.id         = "5025601"
  -  r.name       = "default"
  -  r.public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/Zqnnfg24uLaKybQXEkhSs4rqqbKYLvPg..."
  -  r.labels     = "{}"
  -  r.created    = "2021-12-02 20:50:34 UTC"
end

```

Indicating that the resource is to be deleted.

## Conclusion

This quickstart guide barely scratches the surface of what Kozo can do.
Check out the [introduction](introduction) to learn more about Infrastructure as Code, or browse the [provider documentation](providers) to get an idea of what resources can be manipulated by Kozo.
