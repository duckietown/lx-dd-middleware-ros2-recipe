#!/bin/bash
set -euo pipefail

# open README.md at startup and enable Jupyter widget sources
VSCODE_USER_SETTINGS=/home/duckie/.local/share/code-server/User/settings.json
OUT=$(jq '. + {"workbench.startupEditor": "readme", "jupyter.widgetScriptSources": ["jsdelivr.com", "unpkg.com"]}' "${VSCODE_USER_SETTINGS}")
echo "${OUT}" > "${VSCODE_USER_SETTINGS}"

install -d -o duckie -g duckie \
	"${COLCON_WS}/build" \
	"${COLCON_WS}/install" \
	"${COLCON_WS}/log"

cat >> /etc/bash.bashrc <<'EOF'

source "/opt/ros/${ROS2_DISTRO}/setup.bash"
if [[ -f "${COLCON_WS}/install/setup.bash" ]]; then
	source "${COLCON_WS}/install/setup.bash"
fi
EOF
