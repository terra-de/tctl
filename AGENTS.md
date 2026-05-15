# tctl — Terra DE CLI

Multi-purpose CLI for the Terra desktop environment. Started as a collection of shell
scripts. May graduate to Rust when complexity warrants it.

## Dev Path Resolution

The `TCTL_PATH` env var controls where the dispatcher finds subcommands:

```bash
TCTL_PATH=~/dev/terra-de/tctl tctl <subcommand>
```

Subcommands that call `terrashell` IPC source `.helpers.sh`, which resolves
`TERRASHELL_BIN` from the `TERRASHELL_PATH` env var (falling back to system PATH).

## All Commands

| Subcommand | Actions | Description |
|------------|---------|-------------|
| `appdrawer` | `toggle`, `open`, `close` | App drawer |
| `bitwarden` | `password`, `totp`, `username`, `lock`, `logout` | Bitwarden vault pickers |
| `brightness` | `up [step]`, `down [step]`, `set <0-100>` | Screen backlight |
| `clipboard` | `toggle`, `open`, `close` | Clipboard history picker |
| `config` | `reload` | Reload shell + compositor config |
| `controlcenter` | `toggle`, `open`, `close` | Control center |
| `dump` | `keys` | Dump configuration files |
| `emoji` | `toggle`, `open`, `close` | Emoji picker |
| `gesture` | `left`, `right`, `up`, `down` | Shell touchpad gestures |
| `keys` | `show <submap>`, `dismiss`, (no arg: toggle leader) | Which-key shortcuts overlay |
| `nerdfont` | `toggle`, `open`, `close` | Nerd Font icon picker |
| `osk` | `toggle`, `show`, `hide` | On-screen keyboard (wvkbd) |

## Usage

```bash
tctl brightness up 5
tctl brightness down 10
tctl brightness set 50
tctl osk toggle
tctl appdrawer toggle
tctl bitwarden password
tctl config reload
tctl keys show leader
```

## Adding a new subcommand

1. Create an executable script at `subcommands/<name>`
2. Support `--describe` (prints a one-line description for `tctl` help)
3. If it calls terrashell IPC, source `subcommands/.helpers.sh` to resolve `TERRASHELL_BIN`
4. Register the description in the table above
