#import appium
import appium.webdriver.webdriver
from appium import webdriver
#from selenium.webdriver.ie.webdriver import WebDriver
from appium.options.android import UiAutomator2Options
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
import AppiumLibrary
import requests

current_driver = None #: webdriver.webdriver.WebDriver

def initializeCurrentSession():
    global current_driver
    current_driver = None

def get_driver_from_appiumlibrary():
    appium_lib = BuiltIn().get_library_instance('AppiumLibrary')
    return appium_lib._current_application()

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
    global current_driver
    options = UiAutomator2Options()
    options.platformName = 'Android'
    options.deviceName = 'emulator-5554'
    options.appPackage = 'org.chromium.webapk.a62c68cebaf69977d_v2'
    options.appActivity = 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity'
    options.noReset = True  # Setze noReset explizit auf True
    driver = webdriver.Remote('http://192.168.2.224:4723', True, True, None, True, options)
    current_driver = driver
    print(current_driver.session_id)
    return driver

def get_current_session():
    logger.info('getting current session')
    global current_driver
    #logger.info('global var available')
    if current_driver is None:
        logger.info('current_driver is none, try to open session')
        #open_session()
        current_driver = get_driver_from_appiumlibrary()
        logger.info('success in open session')
    else:
        logger.info('session already open')
    logger.info('current session opened')
    return current_driver

def get_session_info():
    global current_driver
    print(current_driver.session_id)

def set_driver(driver):
    global current_driver
    current_driver = driver
