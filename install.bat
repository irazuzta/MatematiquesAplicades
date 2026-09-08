@echo off
setlocal

echo ============================================
echo  Instal.lacio dels apunts de Matematica Aplicada
echo ============================================
echo.

where python >nul 2>&1
if errorlevel 1 (
    echo [ERROR] No s'ha trobat Python al sistema.
    echo Instal.la Python 3.10 o superior des de https://www.python.org/downloads/
    echo i marca l'opcio "Add Python to PATH" durant la instal.lacio.
    exit /b 1
)

echo [1/3] Creant l'entorn virtual a .venv...
if exist .venv (
    echo       Ja existeix un .venv; es reaprofita.
) else (
    python -m venv .venv
    if errorlevel 1 (
        echo [ERROR] No s'ha pogut crear l'entorn virtual.
        exit /b 1
    )
)

echo [2/3] Actualitzant pip...
.venv\Scripts\python -m pip install --upgrade pip
if errorlevel 1 (
    echo [ERROR] No s'ha pogut actualitzar pip.
    exit /b 1
)

echo [3/3] Instal.lant les dependencies de requirements.txt...
.venv\Scripts\python -m pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] No s'han pogut instal.lar les dependencies.
    exit /b 1
)

echo.
echo Instal.lacio acabada.
echo.
echo Per arrencar el servidor local:
echo.
echo     .venv\Scripts\zensical serve
echo.
echo I obre http://127.0.0.1:8000 al navegador.

endlocal
