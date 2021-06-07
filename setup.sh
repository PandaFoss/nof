#!/usr/bin/env bash

INSTALL_DIR='/usr/bin'
SYSTEMD_USER_DIR="${HOME}/.config/systemd/user"
SERVICE_NAME='backup.service'
TIMER_NAME='backup.timer'

# Def: Uninstall nof script, service and timer
uninstall() {
	echo "Disabling timer..."
	systemctl --user disable "${TIMER_NAME}"
	echo "Stopping timer..."
	systemctl --user stop "${TIMER_NAME}"
	echo "Reloading daemons..."
	systemctl --user daemon-reload
	echo "Removing nof script..."
	sudo rm "${INSTALL_DIR}/nof"
}

# Def: Install nof script, service and timer
install() {
	[ ! -f "${PWD}/nof" ] && echo "Missing nof script (possibly moved)" && exit 2
	sudo cp "${PWD}/nof" "${INSTALL_DIR}"
	
	# Create systemd service and timer
	[ ! -d "${SYSTEMD_USER_DIR}" ] && echo "${SYSTEMD_USER_DIR} not found: Creating..." && mkdir -p "${SYSTEMD_USER_DIR}"
cat <<EOF>"${SYSTEMD_USER_DIR}/${SERVICE_NAME}"
[Unit]
Description=Backup service

[Service]
Type=simple
ExecStart=${INSTALL_DIR}/nof
EOF
cat <<EOF>"${SYSTEMD_USER_DIR}/${TIMER_NAME}"
[Unit]
Description=Backup timer

[Timer]
Unit=backup.service
OnCalendar=weekly
Persistent=true

[Install]
WantedBy=timers.target
EOF
	echo "Reload daemons..."
	systemctl --user daemon-reload
	echo "Enabling ${TIMER_NAME}"
	systemctl --user enable "${TIMER_NAME}"
	echo "Starting ${TIMER_NAME}"
	systemctl --user start "${TIMER_NAME}"
}

# Def: Show script opions
usage() {
cat <<END
Usage: $0 [options]
Options:
  -i, --install		Install nof script, service and timer.
  -u, --uninstall	Remove nof script, service and timer.
  -h, --help		Display this help message and exit.
END
}

# Parse options

GETOPT=$(getopt -o iuh --long install,uninstall,help -- "$@")
eval set -- "${GETOPT}"

while true; do
	case "$1" in
		-i | --install)
			install
			exit 0
			;;
		-u | --uninstall)
			uninstall
			exit 0
			;;
		-h | --help)
			usage
			exit 0
			;;
		*)
			echo "Unknown option"
			usage
			exit 1
			;;
	esac
done
