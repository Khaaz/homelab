#!/bin/sh

set -e


# Check if USERS environment variable is set and not empty
if [ -z "$USERS" ] || [ "$USERS" = "[]" ]; then
	echo "USERS environment variable is not set or empty. No users to add."
	exit 0
fi

# Install dependencies
apk add jq openssl argon2

# Path to users database file
USERS_DB_FILE="/config/users_database.yml"

# Check if users database file exists
if [ ! -f "$USERS_DB_FILE" ]; then
	echo "ERROR: Users database file not found: $USERS_DB_FILE"
	exit 1
fi

# Get the number of users in the JSON array
USER_COUNT=$(echo "$USERS" | jq 'length')

if [ "$USER_COUNT" -eq 0 ]; then
	echo "No users to add."
	exit 0
fi

echo "LOG: Adding $USER_COUNT user(s) to users database..."

# Process each user in the JSON array
i=0
while [ $i -lt "$USER_COUNT" ]; do
	# Extract user data using jq
	USER_NAME=$(echo "$USERS" | jq -r ".[$i].name")
	USER_PASSWORD=$(echo "$USERS" | jq -r ".[$i].password")
	USER_GROUP=$(echo "$USERS" | jq -r ".[$i].group")
	
	# Capitalize first letter of displayname
	DISPLAYNAME=$(echo "$USER_NAME" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
	
	# Generate email
	USER_EMAIL="${USER_NAME}@${INTERNAL_DOMAIN}"
	
	# Encrypt password using argon2
	echo "Encrypting password for user: $USER_NAME"
	USER_ENCRYPTED_PASSWORD=$(echo -n "$USER_PASSWORD" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4)
	
	# Append user to the YAML file
	{
		echo ""
		echo "  ${USER_NAME}:"
		echo "    displayname: ${DISPLAYNAME}"
		echo "    password: ${USER_ENCRYPTED_PASSWORD}"
		echo "    email: ${USER_EMAIL}"
		echo "    groups: [${USER_GROUP}]"
	} >> "$USERS_DB_FILE"
	
	echo "LOG: Added user: $USER_NAME"
	
	i=$((i + 1))
done

echo "LOG: Added users to database"
