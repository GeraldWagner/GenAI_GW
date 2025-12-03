# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GenAI_GW is a German-language, practice-oriented course on Generative AI technologies with a focus on OpenAI GPT models, LangChain, and practical applications. The repository contains course materials structured as Jupyter notebooks, training data, scripts, reusable Python modules, and prompt templates.

## Repository Structure

```
GenAI_GW/
├── lessons/GenAI/
│   ├── 01_notebook/     # Jupyter Notebooks (course materials) - ~30 modules M00-M18
│   ├── 02_daten/        # Training data and example files
│   ├── 03_skript/       # Course documentation and presentations
│   ├── 04_modul/        # genai_lib Python package (reusable modules)
│   └── 05_prompt/       # Prompt templates and examples
├── tasks/               # Task definitions and assignments (student solutions)
└── CLAUDE.md           # This file
```

## File Storage Guidelines

⚠️ **IMPORTANT:** When creating or modifying files:

- **✅ Save to `@tasks/`** - Exercise solutions, assignments, and student work (M0X_A1, M0X_A2, etc.)
- **❌ DO NOT save to `@lessons/`** - This directory contains original course materials only
- `lessons/GenAI/` is read-only for course content reference and development

This ensures course materials remain clean and separates student/exercise work from official course content.

## Core Technology Stack

### Primary Frameworks
- **OpenAI API** - GPT-4o-mini, embeddings, DALL-E integration
- **LangChain** (1.0+) - Orchestration, chains, agents, RAG systems
- **LangGraph** (0.2+) - State-based multi-agent workflows
- **Hugging Face** - Transformers and community models

### Key Libraries
- **ChromaDB** (0.5+) - Vector database for RAG systems
- **Sentence Transformers** (3.0+) - CLIP embeddings for multimodal tasks
- **Gradio** - UI development for AI applications
- **Ollama** - Local open-source models

See `lessons/GenAI/04_modul/requirements.txt` for complete dependency list.

## Key Components

### genai_lib Module (`lessons/GenAI/04_modul/genai_lib/`)

Reusable Python library optimized for Google Colab and Jupyter notebooks.

**utilities.py**
- `check_environment()` - Verify Python, LangChain, LangGraph versions
- `setup_api_keys()` - API key management
- `install_packages()` - Package installation
- `mprint()` - Markdown output formatting
- `get_ipinfo()` - IP and location info

**multimodal_rag.py**
- `init_rag_system()` - Initialize multimodal RAG
- `process_directory()` - Load files
- `search_texts()` - Text-to-text retrieval
- `search_images()` - Text-to-image retrieval
- `search_similar_images()` - Image-to-image similarity
- `search_text_by_image()` - Image-to-text retrieval
- `multimodal_search()` - Advanced combined search

**mcp_modul.py**
- `connect_to_server()` - Model Context Protocol server connection
- `get_available_tools()` - List available tools
- `setup_assistant_mcp_connection()` - OpenAI MCP integration

### Course Modules (lessons/GenAI/01_notebook/)

Jupyter notebooks organized by topic:

**Fundamentals (M00-M12)**
- M01: GenAI Intro - Basics of generative AI
- M02: Modellsteuerung - Prompting and context engineering
- M03: Codieren mit GenAI - AI-assisted programming
- M04: LangChain 101 - Framework basics
- M05: LLM & Transformer - Model architecture
- M06: Chat & Memory - Conversation management
- M07: Output Parser - Structured outputs
- M08: RAG - Retrieval Augmented Generation
- M09: Multimodal Bild - Image generation and processing
- M10: Agents - AI agents and multi-agent systems
- M11: Gradio - UI development
- M12: Lokale Modelle - Ollama and open source

**Advanced Topics (M13-M18)**
- M13: SQL RAG - Database integration
- M14: Multimodal RAG - Text and image combined
- M15: Multimodal Audio - Speech-to-text, TTS
- M16: Multimodal Video - Video analysis
- M17: MCP - Model Context Protocol
- M18: Fine-Tuning - Model adaptation

### Prompt Templates (lessons/GenAI/05_prompt/)

Python scripts demonstrating specific prompting patterns:
- `create_prompt.py` - Prompt creation strategies
- `text_zusammenfassung.py` - Summarization prompts
- `sql_prompt.py` - SQL generation prompts
- `rag_prompt.py` - RAG system prompts

## Development Commands

### Install genai_lib Package

```bash
# From the genai_lib directory
cd lessons/GenAI/04_modul
pip install -e .  # Install in editable mode for development

# Or install from git
pip install git+https://github.com/ralf-42/GenAI.git#subdirectory=04_modul

# Using uv (recommended for Colab)
uv pip install --system git+https://github.com/ralf-42/GenAI.git#subdirectory=04_modul
```

### Working with Jupyter Notebooks

```bash
# Start Jupyter
jupyter notebook lessons/GenAI/01_notebook/

# Run a specific notebook
jupyter nbconvert --to notebook --execute lessons/GenAI/01_notebook/M01_GenAI_Intro.ipynb
```

### Environment Setup

All notebooks expect the following environment variables to be set:
- `OPENAI_API_KEY` - OpenAI API key
- `HUGGINGFACE_API_KEY` - Hugging Face token (for model access)

The `genai_lib.utilities.setup_api_keys()` function handles this in Colab environments.

## Architecture Patterns

### RAG System Pattern

The course uses a multimodal RAG architecture:
1. Documents/images are loaded via `multimodal_rag.process_directory()`
2. Embeddings are generated using Sentence Transformers (CLIP for images, text for documents)
3. ChromaDB stores vector embeddings and metadata
4. Queries use `search_*()` functions for different retrieval types
5. Results are passed to LLM for context-aware responses

### Agent Pattern

Multi-agent workflows use LangGraph:
1. Define state schema
2. Create graph with nodes (agent steps) and edges (transitions)
3. Use `tools` parameter to bind available functions
4. Execute with `graph.invoke(initial_state)`

Agents chain together multiple tool calls to solve complex problems.

### Notebook-Centric Design

- All course materials are Jupyter notebooks optimized for Google Colab
- `genai_lib` utilities handle Colab-specific setup automatically
- Heavy use of Markdown cells for explanations and German language content
- Examples include both simple scripts and complex multi-module workflows

## Python Version & Dependencies

- **Python**: 3.11+ required
- **Package Management**: pip or uv
- **LangChain**: 1.0+ (major version matters for API compatibility)
- **LangGraph**: 0.2+ for state machines and multi-agent workflows

Key version constraints in `requirements.txt`:
- langchain>=1.0.0
- langchain-core>=1.0.0
- langchain-openai>=0.2.0
- chromadb>=0.5.0
- sentence-transformers>=3.0.0

## Important Notes for Development

1. **API Keys**: Always use environment variables, never hardcode credentials. The `.env` file is in `.gitignore`.

2. **Colab Compatibility**: Code in `genai_lib` must work in Google Colab. Use `genai_lib.utilities` for environment detection.

3. **German Language Content**: Notebooks, documentation, and variable names frequently use German. Comments and docstrings should match the existing style.

4. **Multimodal Operations**: CLIP embeddings (via Sentence Transformers) are used for images. ChromaDB stores both text and image vectors with metadata for retrieval.

5. **Module Dependencies**: The `genai_lib` package is self-contained and used across multiple notebooks. Changes must maintain backward compatibility with existing course modules.

6. **Testing**: Notebooks are primary execution format. Manual testing in Colab is the standard approach rather than unit tests.

## Useful References

- Full course script: `lessons/GenAI/03_skript/GenAI_all_in_one.pdf`
- Main course README: `lessons/GenAI/README.md`
- Module README: `lessons/GenAI/04_modul/README.md`
- Setup script: `lessons/GenAI/04_modul/setup.py`

## License

- Source code: MIT License
- Course materials (slides, text, graphics): CC BY 4.0
- Northwind database: Microsoft Public License (Ms-PL)