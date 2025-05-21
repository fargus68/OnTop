"""
Mobile Management Module (Direct Appium Implementation)

This module provides functions for managing mobile application sessions using the appium-python-client
library directly instead of the RobotFramework AppiumLibrary. It offers the same functionality as
Mobile_Mgmt.py but with direct Appium control.

Usage:
    from Resources.Utils.Mobile_Mgmt_Direct import wait_until_login_screen_is_ready, open_application_tt_planer_on_google_pixel_9

Key differences from Mobile_Mgmt.py:
    - Uses appium-python-client directly instead of AppiumLibrary
    - Maintains a global driver instance
    - Uses WebDriverWait and expected_conditions for element waiting
    - Provides better error handling and logging

Notes on Appium Logging:
    - Appium automatically captures Android logcat logs during test execution
    - The message "Stopping logcat capture" in the Appium logs indicates that Appium is stopping
      the capture of Android system logs (logcat) when a session ends or is terminated
    - This is normal behavior and not an error condition
    - Logcat capture is a built-in feature of Appium for Android and helps with debugging
"""
from PIL.TiffTags import UNDEFINED
from appium.webdriver.webdriver import WebDriver

#from appium.webdriver.webdriver import WebDriver  # Not needed as attach_to_session method is not used

"""
Actual driver settings:
{'ignoreUnimportantViews': False, 
'allowInvisibleElements': False, 
'elementResponseAttributes': 'name,text', 
'snapshotMaxDepth': 70, 
'includeA11yActionsInPageSource': False, 
'mjpegBilinearFiltering': False, 
'waitForSelectorTimeout': 10000, 
'serverPort': 6790, 
'simpleBoundsCalculation': False, 
'enableNotificationListener': True, 
'limitXPathContextScope': True, 
'includeExtrasInPageSource': False, 
'normalizeTagNames': False, 
'trackScrollEvents': True, 
'scrollAcknowledgmentTimeout': 200, 
'enableTopmostWindowFromActivePackage': False, 
'enableMultiWindows': False, 
'useResourcesForOrientationDetection': False, 
'currentDisplayId': 0, 
'shouldUseCompactResponses': True, 
'wakeLockTimeout': 86398558, 
'shutdownOnPowerDisconnect': True, 
'mjpegServerPort': 7810, 
'mjpegScalingFactor': 50, 
'disableIdLocatorAutocompletion': False, 
'enforceXPath1': False, 
'actionAcknowledgmentTimeout': 3000, 
'mjpegServerScreenshotQuality': 50, 
'keyInjectionDelay': 0, 
'waitForIdleTimeout': 10000, 
'mjpegServerFramerate': 10}
"""

import logging
import requests

from appium import webdriver
#from appium.webdriver.webdriver import WebDriver

from appium.options.android import UiAutomator2Options
from selenium.webdriver.common.by import By

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, NoSuchElementException
#from time import sleep
#from Libraries.ScrollIntoView_Direct import scroll_to_top

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Global driver instance
_driver: webdriver.Remote = None

def get_driver()-> webdriver.Remote:
    """Get the current driver instance or create a new one if none exists."""
    global _driver

    if _driver is None:
        logger.info("_driver is None!")

        if has_active_appium_sessions():
            logger.info("Session found, driver instance created and existing session attached to it.")
            _driver = get_driver_for_first_session()
        else:
            logger.info("No driver instance found, creating a new one")
            _driver = open_application_tt_planer_on_google_pixel_9()

    logger.info("Returning driver instance with session-id = " + _driver.session_id)
    return _driver

def wait_until_login_screen_is_ready():
    global _driver
    """Wait until the login screen is ready and handle any necessary actions."""
    _driver = get_driver()
    logger.info("Session-ID = " + _driver.session_id)

    # Try to scroll to top (ignore errors)
    try:
        # Import locally to avoid circular import
        from ScrollIntoView_Direct import scroll_to_top
        scroll_to_top(_driver)
    except Exception as e:
        logger.debug(f"Error scrolling to top: {e}")
        pass

    logger.info("Scrolled to top!")

    # Check for close button and click if present
    try:
        close_button = WebDriverWait(_driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, '//android.widget.TextView[@text=""]'))
        )
        close_button.click()
        logger.info("Close button found and clicked!")
    except TimeoutException:
        #logger.debug("Close button not found or not visible")
        logger.info("Close button not found or not visible")
        pass

    # Check for login button
    original_settings = _driver.get_settings()
    _driver.update_settings({"shouldUseCompactResponses": False})

    try:
        WebDriverWait(_driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//android.widget.Button[@text='Einloggen']"))
        )
        logger.info("Login button found!")
        return
    except TimeoutException:
        # If login button not found, restart the application
        logger.info("Login button not found, restarting application")
        restart_application()
    finally:
        # Stelle die ursprünglichen Einstellungen wieder her
        logger.info("Restoring original settings")
        _driver.update_settings({"shouldUseCompactResponses": original_settings.get("shouldUseCompactResponses", True)})
        logger.info(_driver)

def restart_application():
    """Restart the application and wait for the login screen."""
    logger.info("Restarting application")
    global _driver

    if _driver:
        _driver.quit()
        _driver = None

    _driver = open_application_tt_planer_on_google_pixel_9()

    # Wait for login button
    WebDriverWait(_driver, 10).until(
        EC.visibility_of_element_located((By.XPATH, '//android.widget.Button[@text="Einloggen"]'))
    )

def open_application_tt_planer_on_google_pixel_9():
    """Open the TT-Planer application without reset."""
    #global _driver

    options = UiAutomator2Options()
    options.set_capability('platformName', 'Android')
    options.set_capability('deviceName', 'emulator-5554')
    options.set_capability('appPackage', 'org.chromium.webapk.a62c68cebaf69977d_v2')
    options.set_capability('appActivity', 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity')
    options.set_capability('automationName', 'UIAutomator2')
    options.set_capability('noReset', True)
    options.set_capability('autoGrantPermissions', True)
    options.set_capability('newCommandTimeout', 60)  # Erhöhen auf 60 Sekunden oder mehr
    options.set_capability('adbExecTimeout', 60000)  # 60 Sekunden in Millisekunden
    options.set_capability('waitForIdleTimeout', 30000)  # 30 Sekunden in Millisekunden

    # Create driver instance
    driver = webdriver.Remote('http://192.168.2.224:4723', options=options)
    logger.info(f"Application opened with session ID: {driver.session_id}")

    return driver

def get_timeouts():
    global _driver

def log_status():
    global _driver
    logger.info(f"Session status: {_driver.get_status()}")
    #_driver.get_status()

def log_timeouts():
    global _driver
    #timeouts = _driver.get_timeouts()
    logger.info(f"Timeouts: {_driver.get_settings()}")

def get_sessions():
    """Get all Appium sessions."""
    logger.info("Getting sessions")
    response = requests.get("http://192.168.2.224:4723/sessions")
    if response.status_code == 200:
        sessions = response.json().get('value', [])
        logger.info(f"Number of sessions: {len(sessions)}")
        return sessions
    else:
        logger.error(f"Error retrieving sessions: {response.status_code}")
        return []

def close_all_appium_sessions():
    """Close all Appium sessions."""
    # Get current sessions
    response = requests.get("http://192.168.2.224:4723/sessions")
    if response.status_code == 200:
        sessions = response.json().get('value', [])
        # Close all sessions
        for session in sessions:
            session_id = session['id']
            requests.delete(f"http://192.168.2.224:4723/sessions/{session_id}")
        logger.info(f"All sessions closed: {len(sessions)} closed")
    else:
        logger.error(f"Error retrieving sessions: {response.status_code}")

def open_session():
    """Open a new session (only use in pure python tests)."""
    #global _driver
    return open_application_tt_planer_on_google_pixel_9()

def get_current_session():
    """Get the current driver session."""
    #global _driver
    return get_driver()
    #return _driver

def get_session_info():
    """Get information about the current session."""
    logger.info(f"Session ID: {get_driver().session_id}")

def set_driver(driver):
    """Set the global driver instance."""
    global _driver
    _driver = driver

def has_active_appium_sessions():
    """
    Check if there are any active Appium driver sessions.

    Returns:
        bool: True if there are active sessions, False otherwise.
    """
    sessions = get_sessions()
    return len(sessions) > 0

def get_driver_for_first_session():
    """
    Get a driver object for the first found Appium session.

    This function retrieves all active Appium sessions, connects to the first one found,
    and returns a driver object for that session.

    Returns:
        webdriver.Remote: A driver object connected to the first found session,
                         or None if no sessions are found.
    """
    #global _driver
    sessions = get_sessions()

    if not sessions:
        logger.info("No active sessions found")
        return None

    # Get the first session
    first_session = sessions[0]
    session_id = first_session['id']
    logger.info(f"Connecting to existing session with ID: {session_id}")

    # Create a driver instance connected to the existing session
    options = UiAutomator2Options()
    options.set_capability('platformName', 'Android')

    # Create a new driver instance that attaches to the existing session
    #driver = webdriver.Remote('http://192.168.2.224:4723', options=options, session_id=session_id)
    driver = webdriver.Remote('http://192.168.2.224:4723', options=options)
    driver.session_id = session_id

    # Update the global driver reference
    #_driver = driver

    return driver
