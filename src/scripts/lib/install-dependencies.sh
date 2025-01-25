# prerequesites
. /scripts/lib/get-script-dir.sh
DIRNAME=$(get_script_dir)

# Import the OS detection function
. $DIRNAME/lib/is-command-installed.sh

# Import the OS detection function
. $DIRNAME/lib/get-os.sh

# Install the appropriate packages: (sqlite, gettext)
install_dependencies() {
  # Accept a space-separated list of dependencies
  dependencies="$@"
  missing_dependencies=""

  # Get the OS ID
  OS=$(get_os)

  # Check if each dependency is installed
  for dep in $dependencies; do
    if ! is_command_installed "$dep"; then

      if [ "$dep" = "sqlite" ]; then
        # Mark the appropriate package name for installation
        if [ "$OS" = "debian" ] || [ "$OS" = "ubuntu" ]; then
          dep="sqlite3"
        fi
      fi

      missing_dependencies="$missing_dependencies $dep"
    fi
  done

  if [ -z "$missing_dependencies" ]; then
    echo "All dependencies ($dependencies) are already installed."
    return
  fi

  case "$OS" in
    alpine)
      echo "Detected Alpine Linux. Installing $missing_dependencies..."
      apk add --no-cache $missing_dependencies
      ;;
    debian|ubuntu)
      echo "Detected $OS. Installing $missing_dependencies..."
      apt-get update && apt-get install -y $missing_dependencies
      ;;
    *)
      echo "Unsupported OS: $OS"
      exit 1
      ;;
  esac
}