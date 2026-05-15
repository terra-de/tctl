# Shared helpers for tctl subcommands
# Source with: source "$(dirname "$0")/.helpers.sh"
#
# Provides:
#   TERRASHELL_BIN  — resolved terrashell binary path

# Resolve terrashell binary — dev dir override, else system PATH
if [[ -n "${TERRASHELL_PATH:-}" ]]; then
  TERRASHELL_BIN="$TERRASHELL_PATH/terrashell"
else
  TERRASHELL_BIN="terrashell"
fi
