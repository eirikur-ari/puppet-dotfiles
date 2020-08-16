# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.1.1] - 2020-08-16
### Fixed
- Issue with auto deployment fixed

## [v1.1.0] - 2020-08-16
### Added
- Ability to choose between cloning the dotfiles repository using ssh key or via https
- Acceptance tests using [Beaker](https://github.com/voxpupuli/beaker)
- Makefile for more plesant development experience
- Automatic Puppet Module publication via [Travis CI](https://travis-ci.com/)

### Changed
- Moved the package installation from the install manifest to a new package manifest
- Moved the dotfiles installation step from the config manifest to the install manifest

## [v1.0.0] - 2020-08-11
### Added
- Module created with the ability to prepare, clone and install [my dotfiles](https://github.com/eirikur-ari/dotfiles)

[v1.1.1]: https://github.com/eirikur-ari/puppet-dotfiles/compare/v1.0.0...v1.1.1
[v1.1.0]: https://github.com/eirikur-ari/puppet-dotfiles/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/eirikur-ari/puppet-dotfiles/releases/tag/v1.0.0