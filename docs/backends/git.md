---
layout: home
title: Git
nav_order: 1
parent: Backends
---

# Git

The git backend stores the Kozo state in a YAML file, in a git repository.
A commit is made on the current branch (defaults to master) when the state file is written.
The repository will be initialized when initializing the state.

## Configuration

```ruby
backend "git" do |b|
  # Path to repository
  b.repository = "kozo.git"

  # Location of state file
  b.file = "kozo.kzstate"

  # Enable backup files
  b.backups = false

  # Push to remote
  b.remote = "git@github.com:floriandejonckheere/kzstate.git"
end
```

## Options

**repository**

Path to the repository, relative to the working directory.
Defaults to `kozo.git`.

**file**

Location of the state file, relative to the working directory.
Defaults to `kozo.kzstate`.

**backups**

When enabled, Kozo creates a backup of the previous state file every time a new state file is written.
Backup files are appended with the timestamp and `.kzbackup` suffix (e.g. `kozo.kzstate.1638641234.kzbackup`).
Defaults to `false`.

**remote**

Git URL to which Kozo should push every time the state file is written and committed.
If this attribute is present when initializing the local state, the remote is added to the git config as "origin".
Otherwise, it will have to be manually added.
Defaults to empty.
