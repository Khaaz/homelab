#!/bin/sh

# prerequesites
. /scripts/lib/get-script-dir.sh
DIRNAME=$(get_script_dir)

# Import the OS detection function
. $DIRNAME/lib/is-command-installed.sh

# Import the OS detection function
. $DIRNAME/lib/get-os.sh

# Install the appropriate SQLite package
install_sqlite() {
  if is_command_installed sqlite3; then
    echo "SQLite is already installed."
    return
  fi

  # Get the OS ID
  OS=$(get_os)

  case "$OS" in
    alpine)
      echo "Detected Alpine Linux. Installing sqlite..."
      apk add --no-cache sqlite
      ;;
    debian|ubuntu)
      echo "Detected $OS. Installing sqlite3..."
      apt-get update && apt-get install -y sqlite3
      ;;
    *)
      echo "Unsupported OS: $OS"
      exit 1
      ;;
  esac
}

# Main script execution
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 <path_to_db> <path_to_sql_script>"
    exit 1
fi

DB_PATH="$1"
SQL_SCRIPT_PATH="${2:-/_setup/sql/init.sql}"

# Check if the database file exists
if [ ! -f "$DB_PATH" ]; then
    echo "Error: Database file does not exist: $DB_PATH"
    exit 1
fi

# Check if the SQL script file exists
if [ ! -f "$SQL_SCRIPT_PATH" ]; then
    echo "Error: SQL script file does not exist: $SQL_SCRIPT_PATH"
    exit 1
fi

install_sqlite

# Execute DB file
echo "Executing SQL script '$SQL_SCRIPT_PATH' against database '$DB_PATH'..."
sqlite3 "$DB_PATH" < "$SQL_SCRIPT_PATH"

if [ $? -eq 0 ]; then
    echo "Successfully executed SQL script."
else
    echo "Error: Failed to execute SQL script."
    exit 1
fi