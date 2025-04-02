import subprocess

# Virtuelle Umgebung erstellen
subprocess.run(["python", "-m", "venv", "venv"])

# Bibliotheken aus requirements.txt installieren
subprocess.run(["venv/bin/pip", "install", "-r", "requirements.txt"])