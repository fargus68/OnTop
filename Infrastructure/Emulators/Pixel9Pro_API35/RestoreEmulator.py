import os
import subprocess

# Zielverzeichnis für AVDs
avd_dir = os.path.expanduser("~/.android/avd")

# Konfigurationsdateien kopieren
os.makedirs(avd_dir, exist_ok=True)
subprocess.run(["cp", "Pixel9Pro_API35.ini", avd_dir])
subprocess.run(["cp", "config.ini", f"{avd_dir}/Pixel9Pro_API35.avd/"])