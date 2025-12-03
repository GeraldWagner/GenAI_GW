FROM python:3.11-slim

# Minimal system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/build

# Install minimal Python packages
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    ipykernel \
    ipywidgets \
    python-dotenv \
    langchain>=1.0.0 \
    langchain-core>=1.0.0 \
    langchain-openai>=0.2.0 \
    openai

# Copy and install genai_lib (utilities only, no RAG modules)
COPY lessons/GenAI/04_modul /tmp/build/
WORKDIR /tmp/build
RUN pip install --no-cache-dir .

# Setup workspace
WORKDIR /workspace
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY docker/jupyter_config.py /root/.jupyter/jupyter_lab_config.py

EXPOSE 8888

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8888/api || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
