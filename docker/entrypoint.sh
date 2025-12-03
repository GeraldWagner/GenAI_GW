#!/bin/bash
set -e

echo "========================================"
echo "GenAI_GW Docker Environment"
echo "========================================"

echo "Checking genai_lib installation..."
python -c "import genai_lib; print(f'✅ genai_lib version: {genai_lib.__version__ if hasattr(genai_lib, \"__version__\") else \"unknown\"}')" || echo "⚠️ genai_lib not found"

echo "Checking API keys..."
if [ -z "$OPENAI_API_KEY" ]; then
    echo "⚠️ WARNING: OPENAI_API_KEY not set"
else
    echo "✅ OPENAI_API_KEY found"
fi

if [ -z "$HF_TOKEN" ]; then
    echo "⚠️ WARNING: HF_TOKEN not set"
else
    echo "✅ HF_TOKEN found"
fi

echo ""
echo "Environment Details:"
python --version
echo ""
echo "Key Packages:"
pip list | grep -E "langchain|jupyter" || true

echo ""
echo "========================================"
echo "Starting JupyterLab..."
echo "Access at: http://localhost:8888"
echo "========================================"
echo ""

exec "$@"
