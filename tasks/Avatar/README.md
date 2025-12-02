# Avatar Chatbot v0.1

Ein einfacher, CV-basierter Chatbot, der Fragen zu einem Lebenslauf beantwortet.

## Projektstruktur

```
lessons/Avatar/
├── README.md                      # Diese Datei
├── CV.md                          # Beispiel-Lebenslauf (Max Mustermann)
└── Avatar_Chatbot_v0.1.ipynb     # Hauptimplementierung (Jupyter Notebook)
```

## Funktionalität

Der Chatbot demonstriert zwei Szenarien:

### Test 1: Informationen im CV vorhanden ✅

Wenn eine Frage eine Information enthält, die im Lebenslauf vorhanden ist, antwortet der Chatbot mit der korrekten Information.

**Beispiel:**

```
Frage: "Wo hat Max studiert?"
Antwort: "Max hat an der Technischen Universität München (Master) und
         der Ludwig-Maximilians-Universität München (Bachelor) studiert."
```

### Test 2: Informationen nicht im CV vorhanden ✅

Wenn eine Frage eine Information enthält, die **nicht** im Lebenslauf vorhanden ist, antwortet der Chatbot mit: "Das weiss ich leider nicht"

**Beispiel:**

```
Frage: "Welches Auto fährt Max?"
Antwort: "Das weiss ich leider nicht"
```

## Technologie-Stack

- **Framework**: LangChain 1.0+ (LCEL-Syntax)
- **Modell**: OpenAI GPT-4o-mini
- **Temperature**: 0.0 (deterministische Antworten)
- **Pattern**: Simple Chain (Prompt → LLM → StrOutputParser)
- **Utilities**: genai_lib für Setup und Markdown-Ausgabe

## Verwendung

### Jupyter Notebook starten

```bash
cd /Users/wagnerg/Development/playground/GenAI_GW/lessons/Avatar/
jupyter notebook Avatar_Chatbot_v0.1.ipynb
```

### Ablauf im Notebook

1. **Setup & Environment**
   - Installiert genai_lib Abhängigkeiten
   - Setzt API Keys auf (OPENAI_API_KEY)
   - Überprüft LangChain-Version

2. **CV laden**
   - Lädt CV.md aus dem selben Verzeichnis
   - Zeigt CV-Preview an

3. **Chatbot-Konfiguration**
   - Definiert System-Prompt mit strikten Regeln
   - Erstellt LangChain Chain

4. **Interaktiver Test**
   - Stellt manuelle Fragen an den Chatbot
   - Zeigt Live-Antworten

5. **Automatisierte Test-Suite**
   - Führt automatisierte Tests durch
   - Test 1: 5 Fragen mit Informationen im CV
   - Test 2: 5 Fragen mit Informationen außerhalb des CV
   - Generiert Gesamtergebnis

6. **Erkenntnisse & Zusammenfassung**
   - Best Practices für Prompt Engineering
   - Limitierungen von v0.1
   - Ideen für v0.2 und später

## Anforderungen

### Python & Abhängigkeiten

```bash
# Python 3.11+
python --version

# LangChain installieren (falls nicht vorhanden)
pip install langchain langchain-core langchain-openai openai

# oder genai_lib installieren (enthält alle Abhängigkeiten)
pip install -e /Users/wagnerg/Development/playground/GenAI_GW/lessons/GenAI/04_modul
```

### API Keys

Setze deinen OpenAI API Key als Umgebungsvariable:

```bash
export OPENAI_API_KEY="sk-..."
```

Oder im Notebook (wird automatisch durch `setup_api_keys()` gemacht):

```python
import os
os.environ['OPENAI_API_KEY'] = 'sk-...'
```

## Beispiel-Lebenslauf (CV.md)

Der Lebenslauf enthält folgende Abschnitte:

- **Persönliche Daten**: Name, Geburtsdatum, Wohnort
- **Berufliche Zusammenfassung**: Kurzbeschreibung
- **Berufserfahrung**: 3 Positionen (TechCorp, DataAnalytics, StartupX)
- **Ausbildung**: Master + Bachelor in Informatik
- **Fähigkeiten**: Programmiersprachen, Frameworks, Cloud-Plattformen
- **Zertifikate**: AWS ML Specialty, TensorFlow Developer Certificate
- **Sprachen**: Deutsch, Englisch, Spanisch
- **Projekte & Open Source**: LangChain Contributor, german-nlp-toolkit
- **Hobbies**: Wandern, Open Source, Schach

## Test-Szenarien

### Test 1: Informationen IM CV vorhanden

| # | Frage | Erwartete Antwort | Status |
|---|-------|-------------------|--------|
| 1.1 | Wo hat Max studiert? | TU München + LMU München | ✅ |
| 1.2 | Welche Programmiersprachen beherrscht Max? | Python, SQL, JavaScript | ✅ |
| 1.3 | Bei welchen Unternehmen hat Max gearbeitet? | TechCorp, DataAnalytics, StartupX | ✅ |
| 1.4 | Welche Zertifikate hat Max? | AWS ML Specialty, TensorFlow Developer | ✅ |
| 1.5 | Wo wohnt Max? | München | ✅ |

### Test 2: Informationen NICHT im CV vorhanden

| # | Frage | Erwartete Antwort | Status |
|---|-------|-------------------|--------|
| 2.1 | Ist Max verheiratet? | Das weiss ich leider nicht | ✅ |
| 2.2 | Welches Auto fährt Max? | Das weiss ich leider nicht | ✅ |
| 2.3 | Hat Max Kinder? | Das weiss ich leider nicht | ✅ |
| 2.4 | Wie hoch ist Max' Gehalt? | Das weiss ich leider nicht | ✅ |
| 2.5 | Spricht Max Französisch? | Das weiss ich leider nicht | ✅ |

## Prompt Engineering Details

Der System-Prompt ist **kritisch** für das Verhalten des Chatbots:

```python
system_prompt = """
Du bist ein hilfreicher Assistent, der Fragen über eine Person beantwortet.

WICHTIGE REGELN:
1. Beantworte Fragen NUR auf Basis der bereitgestellten Lebenslauf-Informationen
2. Wenn eine Information NICHT im Lebenslauf vorhanden ist, antworte GENAU mit:
   "Das weiss ich leider nicht"
3. Erfinde KEINE Informationen - sei ehrlich, wenn du etwas nicht weisst
4. Antworte auf Deutsch
5. Sei präzise und konkret in deinen Antworten
"""
```

**Design-Entscheidungen:**

- **Explizite Regeln in GROSSBUCHSTABEN**: Verstärken die Wichtigkeit
- **Exakte Formulierung vorgeben**: "Das weiss ich leider nicht" (nicht "Ich weiss nicht" oder andere Varianten)
- **CV direkt im Kontext**: Keine Halluzination nötig
- **temperature=0.0**: Deterministische, konsistente Antworten

## Limitierungen (v0.1)

- ❌ **Context-Größe**: Funktioniert nur für kurze CVs (< 2000 Tokens)
- ❌ **Keine Konversation**: Kein Memory, jede Frage ist isoliert
- ❌ **Statischer Content**: CV wird bei jeder Anfrage mitgeschickt
- ❌ **Modell-abhängig**: Halluzinationen sind immer möglich (reduziert durch Prompt-Engineering)

## Roadmap für v0.2 und später

### v0.2: Erweiterte Funktionalität

- [ ] Konversations-Memory für Follow-up-Fragen
- [ ] Strukturierte Ausgabe mit Pydantic
- [ ] Batch-Anfragen für mehrere Fragen parallel
- [ ] Few-Shot-Beispiele für bessere Antworten

### v0.3: RAG-System

- [ ] ChromaDB für längere CVs
- [ ] Semantic Search statt Context-Matching
- [ ] Multi-CV-Management für mehrere Personen
- [ ] Gradio-UI für Web-Interface

### v1.0+: Production-Ready

- [ ] Avatar-Persönlichkeit (angepasster Antwort-Stil)
- [ ] Multimodal-Support (Bilder, Videos)
- [ ] Fine-Tuning spezialisiertes Modell
- [ ] Persistente Konversations-History
- [ ] Multi-Language Support

## Best Practices (Learnings)

### Prompt Engineering

1. Explizite Regeln verstärken gewünschtes Verhalten
2. Exakte Formulierung des Outputs vorgeben
3. Context direkt im System-Prompt für hohe Relevanz
4. Regel-Wiederholungen (z.B. "NICHT" zweimal verwenden)

### LangChain LCEL-Syntax

1. Pipe-Operator `|` ist sehr lesbar
2. Chain-Komponenten klar getrennt
3. Leicht erweiterbar (+ Retriever, + Memory, + Tools)
4. Pattern-basiert (wie aus M04a_LangChain101.ipynb)

### Temperature & Determinismus

1. temperature=0.0 für konsistente Antworten
2. Wichtig für zuverlässiges Verhalten bei bestimmten Antworten
3. Für kreativere Antworten: temperature > 0

## Referenzen

- **Basierend auf**: lessons/GenAI/01_notebook/M04a_LangChain101.ipynb
- **Task Definition**: tasks/Avatar/Task.md
- **GenAI Course**: lessons/GenAI/README.md
- **LangChain Docs**: <https://python.langchain.com>
- **OpenAI API**: <https://platform.openai.com>

## Lizenz

Siehe generelle Projekt-Lizenz (MIT für Code, CC BY 4.0 für Inhalte)

## Support & Feedback

Für Fragen oder Verbesserungsvorschläge siehe:

- GitHub Issues: <https://github.com/ralf-42/GenAI_GW/issues>
- Claude Code Feedback: /help
