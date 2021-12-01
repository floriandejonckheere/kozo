# Kozo

![Continuous Integration](https://github.com/floriandejonckheere/kozo/workflows/Continuous%20Integration/badge.svg)
![Release](https://img.shields.io/github/v/release/floriandejonckheere/kozo?label=Latest%20release)

_Kōzō_ (構造) is an open-source tool to manage your cloud resources based on the [infrastructure as code](https://en.wikipedia.org/wiki/Infrastructure_as_code) principle.
It leverages the power of [Ruby](https://www.ruby-lang.org/en/) to allow you to declare your infrastructure in your favourite language.

## Installation

Install the gem using your operating system's package manager, or using RubyGems:

```sh
gem install kozo
```

## Usage

Execute `kozo --help` to see all available commands and their arguments.

See the [documentation site](https://www.kozo.dev/) or the [quickstart guide](https://www.kozo.dev/quickstart) for a more detailed description on how to work with Kozo.

## Documentation

A documentation site is provided at `docs/`.
Run `bundle exec jekyll serve` to build and serve the site locally.
Once pushed to Github, the [documentation site](https://www.kozo.dev/) is automatically built and published.

## Release

Update the changelog and bump the version using the `bin/version` tool.
Run `bin/version --help` to see all parameters.
Create a git tag for the version and push it to Github.
A Ruby gem will automatically be built and pushed to the [RubyGems](https://www.rubygems.org/).

```sh
bin/version version 1.0.0
git add lib/kozo/version.rb
git commit -m "Bump version to v1.0.0"
git tag v1.0.0
git push origin master
git push origin v1.0.0
```

## Contributing

1. Fork the repository (<https://github.com/floriandejonckheere/kozo/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

See [LICENSE.md](LICENSE.md).
