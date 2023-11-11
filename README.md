# dotfiles

An minimal ansible project for installing dotfiles designed to be compatible with [dev-bootstrap](https://github.com/lucastheisen/dev-bootstrap) as an _External Repository_.

## Installing

The primary use case is for this project to be configured as an [External Repository](https://github.com/lucastheisen/dev-bootstrap#external-repositories) in `dev-bootstrap`.
The configuration for this would look like:

```yaml
---
external:
  repos:
  - ref: master
    roles:
      dotfiles:
    uri: https://github.com/lucastheisen/dotfiles.git
```

However, there are times when you may want to install directly without `dev-bootstrap`.
This case is common for servers where you dont want any additional installations but do want some of the standard dotfile setup.
To install use the following idiom:

```bash
(
  dir="$(mktemp --directory)"
  trap "rm --recursive --force '${dir:?}'" EXIT
  curl --location https://github.com/lucastheisen/dotfiles/tarball/master \
    | tar --extract --gunzip --directory "${dir}" --strip-components 1
  "${dir}/install.sh"
)
```
