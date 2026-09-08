#!/usr/bin/env bash
set -euo pipefail

echo "============================================"
echo " Instal·lació dels apunts de Matemàtica Aplicada"
echo "============================================"
echo

if command -v python3 >/dev/null 2>&1; then
    PYTHON=python3
elif command -v python >/dev/null 2>&1; then
    PYTHON=python
else
    echo "[ERROR] No s'ha trobat Python al sistema."
    echo "Instal·la Python 3.10 o superior i torna-ho a provar."
    exit 1
fi

echo "[1/3] Creant l'entorn virtual a .venv..."
if [ -d .venv ]; then
    echo "      Ja existeix un .venv; es reaprofita."
else
    "$PYTHON" -m venv .venv
fi

echo "[2/3] Actualitzant pip..."
.venv/bin/python -m pip install --upgrade pip

echo "[3/3] Instal·lant les dependències de requirements.txt..."
.venv/bin/python -m pip install -r requirements.txt

echo
echo "Instal·lació acabada."
echo
echo "Per arrencar el servidor local:"
echo
echo "    .venv/bin/zensical serve"
echo
echo "I obre http://127.0.0.1:8000 al navegador."
