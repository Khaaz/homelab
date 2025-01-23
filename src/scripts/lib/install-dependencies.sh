# prerequesites
. /scripts/lib/get-script-dir.sh
DIRNAME=$(get_script_dir)

# Import the OS detection function
. $DIRNAME/lib/is-command-installed.sh

# Import the OS detection function
. $DIRNAME/lib/get-os.sh

# Install the appropriate packages: (sqlite, gettext)
install_dependencies() {
  if is_command_installed sqlite3 && is_command_installed gettext; then
    echo "SQLite and gettext are already installed."
    return
  fi

  # Get the OS ID
  OS=$(get_os)

  case "$OS" in
    alpine)
      echo "Detected Alpine Linux. Installing sqlite..."
      apk add --no-cache sqlite gettext
      ;;
    debian|ubuntu)
      echo "Detected $OS. Installing sqlite3..."
      apt-get update && apt-get install -y sqlite3 gettext
      ;;
    *)
      echo "Unsupported OS: $OS"
      exit 1
      ;;
  esac
}