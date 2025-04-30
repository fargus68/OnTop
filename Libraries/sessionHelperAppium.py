from appium.options.android import UiAutomator2Options
from appium import webdriver
import requests

import Mobile_Mgmt_Direct

def get_appium_sessions():
        response = requests.get("http://192.168.2.224:4723/sessions")
        if response.status_code == 200:
            sessions = response.json().get('value', [])

            print("Anzahl Sessions = " + str(len(sessions)))
            return sessions
        else:
            print(f"Fehler beim Abrufen der Sitzungen: {response.status_code}")
            return []

def close_all_appium_sessions():
    # Abrufen der aktuellen Sessions
    response = requests.get("http://192.168.2.224:4723/sessions")
    if response.status_code == 200:
        sessions = response.json().get('value', [])
        # Schließen aller Sessions
        for session in sessions:
            session_id = session['id']
            requests.delete(f"http://192.168.2.224:4723/sessions/{session_id}")
        print(f"Alle Sessions geschlossen: {len(sessions)} geschlossen")
    else:
        print(f"Fehler beim Abrufen der Sessions: {response.status_code}")

#only use in pure python tests
def open_session():
    options = UiAutomator2Options()
    options.set_capability('platformName', 'Android')
    options.set_capability('deviceName', 'emulator-5554')
    options.set_capability('appPackage', 'org.chromium.webapk.a62c68cebaf69977d_v2')
    options.set_capability('appActivity', 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity')
    options.set_capability('noReset', True)  # Setze noReset explizit auf True
    driver = webdriver.Remote('http://192.168.2.224:4723', options=options)
    set_driver(driver)
    get_session_info()
    return driver

def get_current_session():
    return Mobile_Mgmt_Direct.get_driver()

def get_session_info():
    print(Mobile_Mgmt_Direct.get_driver().session_id)

def set_driver(driver):
    Mobile_Mgmt_Direct._driver = driver