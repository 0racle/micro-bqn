# BQN support for Micro

[BQN](https://mlochbaum.github.io/BQN/) support for the [Micro](https://micro-editor.github.io/) editor.

This plugin provides a syntax file for BQN, as well as supporting the Backslash-prefix key mappings. 

## Installation

This plugin is not in the official micro plugin channel.
Until that is done, you can either clone the repo, or update your repository settings and install with micro.

### Clone

Simply clone this repo into `~/.config/micro/plug` and restart micro.

### Repository

Add this repo to the `pluginrepos` in `~/.config/micro/settings.json` and restart micro.

```json
{
  "pluginrepos": [
      "https://raw.githubusercontent.com/0racle/micro-bqn/main/repo.json"
  ]
}
```

In the micro editor press `Ctrl-e` and run command:

```
> plugin install bqn
```

or run in your shell

```sh
micro -plugin install bqn
```
