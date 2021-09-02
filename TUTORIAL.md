# Tutorial

First, ensure your working directory is clean.
It's generally a good idea to keep your infrastructure code version controlled.

```sh
$ git init my_app
Initialized empty Git repository in /home/user/my_app/.git/
$ cd my_app
```

Create a `main.kz` file with the following content.
This file will contain the base configuration for your infrastructure.

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

Create a `.env` file with the Hetzner Cloud token:

```env
HCLOUD_TOKEN = my_token
```

Kozo will automatically load this file when it starts up.

Next, initialize the local state backend:

```sh
$ kozo init
Kozo initialized in /home/user/my_app
```
