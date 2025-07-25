# src

## Context

Scripts and utilities for configuration parsing, file operations, and automation tasks used throughout the homelab repository.

## Architecture

### Features

- Shell scripts for parsing configuration files and folders
- SQL execution helpers
- Utility functions for environment management

### File structure

- `scripts/`: Shell utilities and helper scripts
  - `execute-sql.sh`: Run SQL files against a specified database
  - `parse-file.sh`: Expand environment variables in a file and write the result elsewhere
  - `parse-folder.sh`: Recursively apply `parse-file.sh` to a directory
  - `lib/`: Shared shell functions
  - `utils/`: Utility scripts

## Usage

### Example: Run SQL file
```bash
./scripts/execute-sql.sh <path_to_db> [path_to_sql_script]
```

### Example: Parse file
```bash
./scripts/parse-file.sh <input-file> <output-file>
```

### Example: Parse folder
```bash
./scripts/parse-folder.sh <input-directory> <output-directory>
```
