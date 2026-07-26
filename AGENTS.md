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
| `binds` | `list` | List Hyprland binds in JSON format |
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
| `osk` | `toggle`, `show`, `hide`, `status` | On-screen keyboard (wvkbd, direct management) |
| `power` | `lock`, `suspend`, `hibernate`, `logout`, `reboot`, `shutdown` | System power actions |
| `cursor` | `set <theme> [size]`, `info` | Set hyprcursor theme for Wayland; no terratheme knowledge |
| `wallpaper` | `set <path> [--mode dark\|light]` | Set wallpaper and generate palette via terratheme |
| `workspace` | `activate <id>`, `rename <id> <name>` | Workspace operations |

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
tctl workspace activate 3
tctl workspace rename 3 "dev"
tctl power logout
tctl power shutdown
tctl binds list

# Cursor
tctl cursor set oreo_terra_abc123 32
tctl cursor info

# Wallpaper
tctl wallpaper set ~/Pictures/wallpapers/wallhaven-3q5g5v.jpg --mode dark
```

## Hyprland Dispatch Format

Since Terra DE uses a Lua Hyprland config (`terra-hyprland`), all `hyprctl dispatch` calls
must pass literal Lua dispatcher strings. Keyword-style dispatches do NOT work.

```bash
# Correct — Lua string format:
hyprctl dispatch 'hl.dsp.focus({ workspace = 1 })'
hyprctl dispatch 'hl.dsp.exit()'
hyprctl dispatch 'hl.dsp.workspace.rename({ workspace_id = 1, name = "work" })'
hyprctl dispatch 'hl.dsp.exec_cmd("wvkbd-deskintl --hidden")'
hyprctl dispatch 'hl.dsp.submap("reset")'
hyprctl dispatch 'hl.dsp.focus({ direction = "left" })'

# Wrong — keyword-style does NOT work with Lua config:
# hyprctl dispatch workspace 1
# hyprctl dispatch exit
```

Non-dispatch `hyprctl` commands (reload, binds -j, layers, etc.) still work as normal.

## Adding a new subcommand

1. Create an executable script at `subcommands/<name>`
2. Support `--describe` (prints a one-line description for `tctl` help)
3. If calling Hyprland dispatchers, use the Lua string format: `hyprctl dispatch 'hl.dsp.<name>(<args>)'`
4. If it calls terrashell IPC, source `subcommands/.helpers.sh` to resolve `TERRASHELL_BIN`
5. Register the description in the table above
