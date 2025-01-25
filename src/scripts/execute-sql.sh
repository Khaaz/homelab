#!/bin/sh

# prerequesites
. /scripts/lib/get-script-dir.sh
DIRNAME=$(get_script_dir)

# Import the dependencies function
. $DIRNAME/lib/install-dependencies.sh

# Import the parse file function
. $DIRNAME/lib/parse-file.sh

preprocess_sql_script() {
  local input_file="$1"

  local parsed_file=$(parse_file $input_file)

  echo "$parsed_file" | sed -e "s/\\\\'/''/g"
}

## Usage
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 <path_to_db> [path_to_sql_script]"
  exit 1
fi

## Variables
DB_PATH="$1"
SQL_SCRIPT_PATH="${2:-/_setup/sql/init.sql}"

## Input verification
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

## Core
install_dependencies sqlite gettext

PREPROCESSED_SQL=$(preprocess_sql_script "$SQL_SCRIPT_PATH")

# Execute DB file
echo "INIT: Executing SQL script '$SQL_SCRIPT_PATH' against database '$DB_PATH'..."
echo "$PREPROCESSED_SQL" | sqlite3 "$DB_PATH"

if [ $? -eq 0 ]; then
  echo "INIT: Success => Successfully executed SQL script."
else
  echo "INIT: Error => Failed to execute SQL script."
  exit 1
fi