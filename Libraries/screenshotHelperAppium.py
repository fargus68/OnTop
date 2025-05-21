def take_screenshot():
    import time
    from datetime import datetime
    from Resources.Utils.DriverSingletonAdapter import get_current_session
    import os

    # Erstelle Screenshot-Verzeichnis, falls es nicht existiert
    screenshot_dir = os.path.join(os.getcwd(), 'screenshots')
    os.makedirs(screenshot_dir, exist_ok=True)

    # Generiere eindeutigen Dateinamen mit Zeitstempel
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    filename = os.path.join(screenshot_dir, f'screenshot_{timestamp}.png')

    driver = get_current_session()

    try:
        driver.get_screenshot_as_file(filename)
        print(f"Screenshot erfolgreich gespeichert: {filename}")
    except Exception as e:
        print(f"Fehler beim Erstellen des Screenshots: {str(e)}")
