---
layout: home
title: Local
nav_order: 0
parent: Backends
---

# Local

The local backend stores the Kozo state in a YAML file.

State files are only written if the state changed.

## Configuration

Minimal configuration:

```ruby
backend "local"
```

Custom configuration:

```ruby
backend "local" do |b|
  # Location of state file
  b.file = "kozo.kzstate"

  # Enable backup files
  b.backups = false
end
```

## Options

**file**

Location of the state file, relative to the working directory.
Defaults to `kozo.kzstate`.

**backups**

When enabled, Kozo creates a backup of the previous state file every time a new state file is written.
Backup files are appended with the timestamp and `.kzbackup` suffix (e.g. `kozo.kzstate.1638641234.kzbackup`).
Defaults to `false`.
