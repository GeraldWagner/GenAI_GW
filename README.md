# GenAI_GW

**Generative KI. Verstehen. Anwenden. Gestalten.**

Ein deutschsprachiger, praxisorientierter Kurs zu Generativer KI mit Fokus auf:
- OpenAI GPT-Modelle (GPT-4o, GPT-4o-mini)
- LangChain & LangGraph für KI-Anwendungen
- Prompt Engineering & Few-Shot Learning
- RAG (Retrieval Augmented Generation)
- Multimodale Systeme (Text, Bilder, Audio, Video)
- AI Agents & Multi-Agent Workflows

## 📁 Struktur

```
GenAI_GW/
├── lessons/GenAI/01_notebook/     # ~30 Jupyter Notebooks (M00-M18)
├── lessons/GenAI/02_daten/        # Trainingsdaten & Beispiele
├── lessons/GenAI/03_skript/       # Dokumentation & Präsentationen
├── lessons/GenAI/04_modul/        # genai_lib Python-Paket (wiederverwendbar)
├── lessons/GenAI/05_prompt/       # Prompt-Templates & Patterns
├── tasks/                         # Übungsaufgaben
├── scripts/                       # Hilfsskripte
└── CLAUDE.md                      # Entwicklungsdokumentation
```

## 🚀 Quick Start

### 1. genai_lib installieren

```bash
pip install -e lessons/GenAI/04_modul
```

### 2. API-Keys setzen

Erstelle `.env` im Root-Verzeichnis:
```
OPENAI_API_KEY=sk-...
HUGGINGFACE_API_KEY=hf_...
```

### 3. Jupyter Notebooks starten

```bash
jupyter notebook lessons/GenAI/01_notebook/
```

## 🧹 Notebooks bereinigen

Um Outputs aus Notebooks im `tasks/` zu entfernen:

```bash
./scripts/clean_tasks.sh
```

Siehe `scripts/README.md` für Details.

## 📚 Module

| Modul | Inhalt |
|-------|--------|
| M01-M03 | Grundlagen GenAI, Prompting, KI-unterstütztes Programmieren |
| M04-M05 | LangChain 101, LLM & Transformer-Architektur |
| M06-M08 | Chat & Memory, Output Parser, RAG-Systeme |
| M09-M12 | Multimodale KI, Agents, Gradio UI, lokale Modelle |
| M13-M18 | Fortgeschrittene Themen: SQL-RAG, Multimodal, MCP, Fine-Tuning |

## 📝 Lizenz

- **Source Code**: MIT License
- **Kurs-Materialien**: CC BY 4.0
