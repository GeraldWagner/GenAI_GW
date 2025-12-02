#!/bin/bash

# 🧹 Notebook-Outputs bereinigen für tasks/ Verzeichnis
# Aufruf: ./scripts/clean_tasks.sh

cd "$(dirname "$0")/../tasks"
for notebook in *.ipynb; do
    [ -f "$notebook" ] && nbstripout "$notebook"
done
echo "✅ Notebook-Outputs bereinigt"
