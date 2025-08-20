#!/bin/sh

# Prerequesites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

PROVIDER="virtualbox"
ACTION=""
while [ $# -gt 0 ]; do
  case "$1" in
    up|down|reload)
      ACTION="$1"
      ;;
    --provider|-p)
      shift
      PROVIDER="$1"
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: $0 up|down|reload [--provider|-p <virtualbox|hyperv|vmware>]"
      exit 1
      ;;
  esac
  shift
done

if [ -z "$ACTION" ]; then
  echo "Usage: $0 [up|down|reload] [--provider|-p <virtualbox|hyperv|vmware>]"
  exit 1
fi

cd "$SCRIPT_DIR/../vagrant"

case "$ACTION" in
  up)
    vagrant up --provider "$PROVIDER"
    ;;
  down)
    vagrant destroy -f
    ;;
  reload)
    vagrant reload
    ;;
esac
