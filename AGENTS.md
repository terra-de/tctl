# tctl — Terra DE CLI

Multi-purpose CLI for the Terra desktop environment. Started as a collection of shell
scripts. May graduate to Rust when complexity warrants it.

## Commands

| Subcommand | Description |
|------------|-------------|
| `brightness` | Adjust screen backlight via brightnessctl |
| `gesture` | Handle shell gestures (left, right, up, down) |
| `keys` | Toggle which-key shortcuts overlay, or dump keys config with `dump` |
| `keys dump` | Output effective keys config (user file or shipped defaults) |

## Usage

```bash
tctl brightness up 5
tctl brightness down 10
tctl brightness set 50
```

## Adding a new subcommand

Create an executable script at `subcommands/<name>`. If it supports `--describe`,
return a one-line description for the help output.
