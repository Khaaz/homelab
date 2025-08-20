# src

## Context

Scripts and utilities for configuration parsing, file operations, and automation tasks used throughout the homelab repository.

## Architecture

### Features

- Shell scripts for parsing configuration files and folders
- SQL execution helpers
- Utility functions for environment management

### File structure

- `app-bootstrap/`: Shell utilities and helper scripts that can be bundled in deployed app to easy initialisation
  - `execute_sql.sh`: Run SQL files against a specified database
  - `parse_file.sh`: Expand environment variables in a file and write the result elsewhere
  - `parse_folder.sh`: Recursively apply `parse_file.sh` to a directory
  - `lib/`: Shared shell functions
- `utils/`: Utility scripts (generate password etc)
- `environment/`: Initialise and setup environment variables and other necessay tooling

## Usage

### Example: Run SQL file
```bash
./scripts/execute_sql.sh <path_to_db> [path_to_sql_script]
```

### Example: Parse file
```bash
./scripts/parse_file.sh <input-file> <output-file>
```

### Example: Parse folder
```bash
./scripts/parse_folder.sh <input-directory> <output-directory>
```
