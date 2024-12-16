#!/bin/sh

# Install SQLite3 using apk
apk add --no-cache sqlite3

# Define the SQLite database file and SQL script file
DB_FILE="/tmp/example.db"
SQL_FILE="/tmp/script.sql"

# Ensure the SQL file exists
if [ ! -f "$SQL_FILE" ]; then
  echo "SQL file $SQL_FILE not found!"
  exit 1
fi

# Execute the SQL script
sqlite3 "$DB_FILE" < "$SQL_FILE"

# Output the database file location
echo "SQLite operations completed. Database file: $DB_FILE"