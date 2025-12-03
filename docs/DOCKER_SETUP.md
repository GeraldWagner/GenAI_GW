# Docker Setup für GenAI_GW

## Quick Start

### 1. Build Docker Image

```bash
cd /Users/wagnerg/Development/playground/GenAI_GW
docker-compose build
```

**Erste Build:** ~2-3 Minuten (minimal dependencies)

### 2. Start JupyterLab

```bash
docker-compose up
```

**Access:** http://localhost:8888

### 3. Stop Container

```bash
docker-compose down
```

Deine Arbeit ist automatisch gespeichert (Notebooks sind volume-mounted).

---

## Workflows

### Avatar_Chatbot_v0.1.ipynb ausführen

1. Container starten: `docker-compose up`
2. Browser öffnen: http://localhost:8888
3. Navigieren zu: `tasks/Avatar/Avatar_Chatbot_v0.1.ipynb`
4. Cells ausführen - genai_lib ist bereits installiert!

### Live Code Editing

- Editiere Notebooks oder Python-Dateien in deinem Editor (VS Code, etc.)
- Änderungen sind sofort im JupyterLab sichtbar (Browser refresh ggf. nötig)
- **Kein Container-Rebuild nötig!**

### Upgrade zu v0.3 (RAG/Multimodal)

Wenn später RAG-Funktionalität benötigt wird:

```bash
# Im JupyterLab Terminal:
pip install chromadb sentence-transformers pillow markitdown
```

Alternative: Vollständige Docker-Image mit allen Features bauen.

### Rebuild nach Dependency-Änderungen

Falls du `lessons/GenAI/04_modul/requirements.txt` änderst:

```bash
docker-compose down
docker-compose build --no-cache
docker-compose up
```

---

## Troubleshooting

### "OPENAI_API_KEY not found" Warning

**Prüfe:** `.env` Datei existiert im Projekt-Root?

```bash
cat .env
```

**Sollte enthalten:**
```
OPENAI_API_KEY="sk-..."
HF_TOKEN="hf_..."
```

**Wenn nicht:** `.env` erstellen mit deinen API Keys.

### Port 8888 bereits belegt

**Fehler:** `Address already in use`

**Lösung:** Port in `docker-compose.yml` ändern:

```yaml
ports:
  - "8889:8888"  # Nutze Port 8889 statt 8888
```

Dann über http://localhost:8889 zugreifen.

### Container startet nicht

**Logs prüfen:**
```bash
docker-compose logs jupyter
```

**Häufige Probleme:**
- `.env` Datei nicht lesbar (Berechtigungen prüfen)
- Docker Daemon läuft nicht (Docker Desktop starten)
- Build-Fehler (siehe Logs)

### JupyterLab lädt sehr langsam

**Normal:** Erste Startup kann 10-15 Sekunden dauern.

**Falls länger:**
- Container-Logs prüfen: `docker-compose logs -f jupyter`
- Machine startet neu: `docker-compose restart jupyter`

### Packages nachinstallieren (on-demand)

Falls du zusätzliche Packages brauchst:

```bash
# Option 1: Im Terminal des Containers
docker-compose exec jupyter bash
pip install chromadb

# Option 2: Im JupyterLab Terminal (im Browser)
# Cell mit: !pip install chromadb
```

---

## Erweiterte Verwendung

### Container Shell direkt

```bash
docker-compose exec jupyter bash
```

Hier kannst du:
- Python-Packages nachinstallieren
- Notebooks mit Jupyter CLI ausführen
- System-Kommandos testen

### genai_lib in Entwicklungsmodus

Falls du an genai_lib selbst entwickelst:

```bash
# Im JupyterLab Terminal:
pip install -e /workspace/lessons/GenAI/04_modul
```

**Dann:** Kernel im Notebook neustarten für Änderungen.

### Container-Status prüfen

```bash
docker-compose ps
```

Zeigt Container-Status, Ports, etc.

### Logs verfolgen (live)

```bash
docker-compose logs -f jupyter
```

Zeigt Live-Logs. Mit Ctrl+C stoppen.

---

## File-Verzeichnisse

### Im Container

- **Projekt:** `/workspace`
- **Notebooks:** `/workspace/lessons/GenAI/01_notebook`, `/workspace/tasks`
- **Daten:** `/workspace/lessons/GenAI/02_daten`
- **.env:** `/workspace/.env` (read-only)

### Auf deinem MacBook

- **Alles:** `/Users/wagnerg/Development/playground/GenAI_GW/`
- **Docker-Config:** `Dockerfile`, `docker-compose.yml`, `docker/`
- **Dokumentation:** `docs/DOCKER_SETUP.md`

---

## Performance-Metriken

### Startup-Zeiten

| Metrik | Zeit | Details |
|--------|------|---------|
| Docker Build (erste) | ~2-3 Min | Minimal dependencies |
| Docker Build (folge) | ~20-30 Sek | Layer caching |
| Container Start | ~3-5 Sek | Minimal footprint |
| JupyterLab Ready | ~5-10 Sek | Browser-Loading |

### Ressourcen-Nutzung

| Ressource | Wert | Details |
|-----------|------|---------|
| Image-Größe | ~500 MB | Ohne PyTorch/Transformers |
| Memory (idle) | ~500-800 MB | Minimal |
| Memory (notebook running) | ~1-1.5 GB | Workload-abhängig |

---

## Umgebungsvariablen

Diese Variablen werden automatisch in den Container geladen:

```yaml
OPENAI_API_KEY    # Aus .env
HF_TOKEN          # Aus .env
JUPYTER_ENABLE_LAB=yes
JUPYTER_TOKEN=    # Leer = Kein Password nötig
```

**Lokale Entwicklung:** Kein Token nötig (nur localhost).

---

## Best Practices

### 1. .env File schützen
- `.env` ist read-only im Container (schreibgeschützt)
- Änderungen im Container funktionieren nicht
- Edit `.env` auf deinem MacBook

### 2. Notebooks speichern
- JupyterLab speichert automatisch (Autosave: 60 Sek)
- Notebook-Datei ist im bind-mounted Verzeichnis
- Änderungen sind sofort auf deinem MacBook

### 3. Container Cleanup
Nach längerer Verwendung:

```bash
# Alte Container/Images entfernen
docker system prune

# Nur Dangling Images (ungenutzte)
docker image prune
```

### 4. Logs rotieren
Falls Logs zu groß werden:

```bash
docker-compose logs --tail 100
```

---

## Häufig gestellte Fragen

### F: Warum nicht die größere genai_lib mit RAG?
**A:** Minimal-Image ist schneller (2-3 Min Build statt 8-10). RAG-Features können später on-demand installiert werden.

### F: Kann ich andere Ports nutzen?
**A:** Ja! Ändere in `docker-compose.yml`:
```yaml
ports:
  - "9999:8888"  # Host Port : Container Port
```

### F: Wie kann ich ChromaDB-Daten speichern?
**A:** Für v0.3 mit RAG: Nutze benannte Volumes in `docker-compose.yml`.

### F: Funktioniert das auf arm64 (M1/M2)?
**A:** Ja! Python 3.11-slim hat gute ARM64-Unterstützung. Falls Probleme: `platform: linux/amd64` in docker-compose.yml.

### F: Kann ich GPU unterstützung aktivieren?
**A:** Für Zukunft möglich, aber nicht für v0.1/v0.2 nötig (nur CPU-basierte LLM).

---

## Upgrade-Pfad

### v0.1 → v0.2 (aktuell)
- Kein Rebuild nötig
- Update Notebooks, genai_lib works

### v0.2 → v0.3 (RAG)
Option 1 - On-Demand:
```bash
pip install chromadb sentence-transformers pillow
```

Option 2 - Full-Image:
- Neues Dockerfile mit allen Dependencies
- Rebuild: `docker-compose build`

---

## Support & Debugging

### Debug-Modus aktivieren

In `docker/jupyter_config.py`:
```python
c.Application.log_level = 'DEBUG'
```

Dann Container rebuild.

### Python-Version prüfen

```bash
docker-compose exec jupyter python --version
```

### Packages auflisten

```bash
docker-compose exec jupyter pip list
```

---

## Weitere Ressourcen

- **Hauptprojekt:** `/Users/wagnerg/Development/playground/GenAI_GW/README.md`
- **CLAUDE.md:** Projekt-Übersicht und Setup-Anleitung
- **Avatar Task:** `tasks/Avatar/README.md`
- **Docker Docs:** https://docs.docker.com/compose/
- **JupyterLab Docs:** https://jupyterlab.readthedocs.io/
