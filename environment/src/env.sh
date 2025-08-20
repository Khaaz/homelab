#!/bin/sh

ACTION=""
while [ $# -gt 0 ]; do
  case "$1" in
    up|down)
      ACTION="$1"
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: $0 up|down"
      exit 1
      ;;
  esac
  shift
done

if [ -z "$ACTION" ]; then
  echo "Usage: $0 up|down"
  exit 1
fi

case "$ACTION" in
  up)
    docker compose run --rm --build environment
    ;;
  down)
    docker compose down environment
    ;;
esac
