#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Gunicorn on port 80..."
exec gunicorn -c gunicorn-config.py app:app
