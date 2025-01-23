#!/bin/sh

is_command_installed() {
  command -v "$1" >/dev/null 2>&1
}