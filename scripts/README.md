# 🧹 clean_tasks.sh

Einfaches Script zum Bereinigen von Notebook-Outputs im `tasks/` Verzeichnis.

## Verwendung

```bash
./scripts/clean_tasks.sh
```

Das Script:
- Geht in das `tasks/` Verzeichnis
- Entfernt alle Outputs aus `*.ipynb` Dateien mit `nbstripout`
- Gibt Status-Meldung aus

## Workflow

```bash
# 1. Notebooks bereinigen
./scripts/clean_tasks.sh

# 2. In tasks/ wechseln und Status prüfen
cd tasks/
git status

# 3. Bereinigte Notebooks hinzufügen
git add *.ipynb

# 4. Commit erstellen
git commit -m "Clean notebook outputs"
```

## Warum?

Jupyter Notebook-Outputs werden in Git gespeichert und:

- Machen Diffs unleserlich
- Vergrössern das Repository unnötig
- Führen zu Git-Konflikten

`nbstripout` entfernt nur die Outputs - der Code bleibt erhalten!
