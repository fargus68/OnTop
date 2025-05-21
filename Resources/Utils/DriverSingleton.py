"""
Driver Singleton Module

This module provides a Singleton implementation for managing the Appium driver instance.
It ensures that only one driver instance is created and shared across all imports of this module.

Usage:
    from Resources.Utils.DriverSingleton import DriverSingleton

    # Get the driver instance
    driver = DriverSingleton().get_driver()

    # Set a new driver instance
    DriverSingleton().set_driver(new_driver)
"""

import logging
import requests
from appium import webdriver
from appium.options.android import UiAutomator2Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException

from selenium.webdriver.remote.remote_connection import RemoteConnection
from selenium.webdriver.remote.webdriver import WebDriver
from selenium.webdriver.common.options import ArgOptions

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class DriverSingleton:
    """
    Singleton class for managing the Appium driver instance.
    
    This class ensures that only one driver instance is created and shared across all imports.
    It provides methods to access and manipulate the driver instance, similar to the functions
    in Mobile_Mgmt_Direct.py.
    """

    SERVER_URL_BASE = 'http://127.0.0.1:4723'

    # Class variable to hold the singleton instance
    _instance = None
    
    # Class variable to hold the driver instance
    _driver = None

    def __new__(cls):
        """
        Ensure only one instance of DriverSingleton is created.
        """
        if cls._instance is None:
            cls._instance = super(DriverSingleton, cls).__new__(cls)
        return cls._instance

    def get_driver(self) -> webdriver.Remote:
        """
        Get the current driver instance or create a new one if none exists.
        
        Returns:
            webdriver.Remote: The current driver instance.
        """
        if DriverSingleton._driver is None:
            logger.info("Driver is None!")
            
            if self.has_active_appium_sessions():
                logger.info("Session found, driver instance created and existing session attached to it.")
                DriverSingleton._driver = self.get_driver_for_first_session()
            else:
                logger.info("No driver instance found, creating a new one")
                DriverSingleton._driver = self.open_application_tt_planer_on_google_pixel_9()
        
        logger.info("Returning driver instance with session-id = " + DriverSingleton._driver.session_id)
        return DriverSingleton._driver
    
    @staticmethod
    def set_driver(driver):
        """
        Set the driver instance.
        
        Args:
            driver (webdriver.Remote): The driver instance to set.
        """
        DriverSingleton._driver = driver
    
    def open_application_tt_planer_on_google_pixel_9(self):
        """
        Open the TT-Planer application without reset.
        New format of 5.0 appium-python-client.

        Returns:
            webdriver.Remote: The driver instance for the opened application.
        """

        desired_caps = {
            'platformName': 'Android',
            'deviceName': 'emulator-5554',
            'appPackage': 'org.chromium.webapk.a62c68cebaf69977d_v2',
            'appActivity': 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity',
            'automationName': 'UIAutomator2',
            'noReset': True,
            'autoGrantPermissions': True,
            'newCommandTimeout': 180,       # Erhöhen auf 180 Sekunden oder mehr
            'adbExecTimeout': 60000,        # 60 Sekunden in Millisekunden
            'waitForIdleTimeout': 30000,    # 30 Sekunden in Millisekunden
            'printPageSourceOnFindFailure': True,
        }

        from appium.webdriver.client_config import AppiumClientConfig
        client_config = AppiumClientConfig(
            remote_server_addr = self.SERVER_URL_BASE,
            direct_connection = True,
            keep_alive = False,
            ignore_certificates = True,
        )
        driver = webdriver.Remote(
            options = UiAutomator2Options().load_capabilities(desired_caps),
            client_config = client_config
        )

        '''
        options = UiAutomator2Options()
        options.set_capability('platformName', 'Android')
        options.set_capability('deviceName', 'emulator-5554')
        options.set_capability('appPackage', 'org.chromium.webapk.a62c68cebaf69977d_v2')
        options.set_capability('appActivity', 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity')
        options.set_capability('automationName', 'UIAutomator2')
        options.set_capability('noReset', True)
        options.set_capability('autoGrantPermissions', True)
        options.set_capability('newCommandTimeout', 180)  # Erhöhen auf 180 Sekunden oder mehr
        options.set_capability('adbExecTimeout', 60000)  # 60 Sekunden in Millisekunden
        options.set_capability('waitForIdleTimeout', 30000)  # 30 Sekunden in Millisekunden

        # Create driver instance
        driver = webdriver.Remote('http://192.168.2.224:4723', options=options)
        logger.info(f"Application opened with session ID: {driver.session_id}")
        '''

        logger.info(f"Application opened with session ID: {driver.session_id}")
        return driver

    def restart_application(self):
        """
        Restart the application and wait for the login screen.
        """
        logger.info("Restarting application")

        if DriverSingleton._driver is None:
            logger.info("Driver is None!")
        else:
            logger.info("Driver is not None!")
            DriverSingleton._driver.quit()
            DriverSingleton._driver = None
        
        DriverSingleton._driver = self.open_application_tt_planer_on_google_pixel_9()
        
        # Wait for login button
        WebDriverWait(DriverSingleton._driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, '//android.widget.Button[@text="Einloggen"]'))
        )
    
    def wait_until_login_screen_is_ready(self):
        """
        Wait until the login screen is ready and handle any necessary actions.
        """
        driver = self.get_driver()
        logger.info("Session-ID = " + driver.session_id)
        
        # Try to scroll to top (ignore errors)
        try:
            # Import locally to avoid circular import
            from ScrollIntoView_Direct import scroll_to_top
            scroll_to_top(driver)
        except Exception as e:
            logger.debug(f"Error scrolling to top: {e}")
            pass
        
        logger.info("Scrolled to top!")
        
        # Check for close button and click if present
        try:
            close_button = WebDriverWait(driver, 10).until(
                EC.visibility_of_element_located((By.XPATH, '//android.widget.TextView[@text=""]'))
            )
            close_button.click()
            logger.info("Close button found and clicked!")
        except TimeoutException:
            logger.info("Close button not found or not visible")
            pass
        
        # Check for login button
        original_settings = driver.get_settings()
        driver.update_settings({"shouldUseCompactResponses": False})
        
        try:
            WebDriverWait(driver, 10).until(
                EC.visibility_of_element_located((By.XPATH, "//android.widget.Button[@text='Einloggen']"))
            )
            logger.info("Login button found!")
            return
        except TimeoutException:
            # If login button not found, restart the application
            logger.info("Login button not found, restarting application")
            self.restart_application()
        finally:
            # Restore original settings
            logger.info("Restoring original settings")
            driver.update_settings({"shouldUseCompactResponses": original_settings.get("shouldUseCompactResponses", True)})
            logger.info(driver)
    
    def get_sessions(self):
        """
        Get all Appium sessions.
        
        Returns:
            list: A list of active Appium sessions.
        """
        logger.info("Getting sessions")
        #response = requests.get("http://192.168.2.224:4723/sessions")

        try:
            response = requests.get(self.SERVER_URL_BASE + "/sessions")
            if response.status_code == 200:
                sessions = response.json().get('value', [])
                logger.info(f"Number of sessions: {len(sessions)}")
                return sessions
            else:
                logger.error(f"Error retrieving sessions: {response.status_code}")
                return []
        except ConnectionError as e:
            logger.debug(f"Connection error: {e}")
            return []


    
    def has_active_appium_sessions(self):
        """
        Check if there are any active Appium driver sessions.
        
        Returns:
            bool: True if there are active sessions, False otherwise.
        """
        sessions = self.get_sessions()
        return len(sessions) > 0
    
    def get_driver_for_first_session(self):
        """
        Get a driver object for the first found Appium session.
        
        This function retrieves all active Appium sessions, connects to the first one found,
        and returns a driver object for that session.
        
        Returns:
            webdriver.Remote: A driver object connected to the first found session,
                             or None if no sessions are found.
        """
        sessions = self.get_sessions()
        
        if not sessions:
            logger.info("No active sessions found")
            return None
        
        # Get the first session
        first_session = sessions[0]
        session_id = first_session['id']
        logger.info(f"Connecting to existing session with ID: {session_id}")

        return self.connect_to_existing_session(session_id, self.SERVER_URL_BASE)

    def close_all_appium_sessions(self):
        """
        Close all Appium sessions.
        """
        # Get current sessions
        response = requests.get(self.SERVER_URL_BASE + "/sessions")
        if response.status_code == 200:
            sessions = response.json().get('value', [])
            # Close all sessions
            for session in sessions:
                session_id = session['id']
                requests.delete(f"{self.SERVER_URL_BASE}/sessions/{session_id}")
            logger.info(f"All sessions closed: {len(sessions)} closed")
        else:
            logger.error(f"Error retrieving sessions: {response.status_code}")
    
    def log_status(self):
        """
        Log the status of the current session.
        """
        driver = self.get_driver()
        logger.info(f"Session status: {driver.get_status()}")
    
    def log_timeouts(self):
        """
        Log the timeouts of the current session.
        """
        driver = self.get_driver()
        logger.info(f"Timeouts: {driver.get_settings()}")
    
    def get_session_info(self):
        """
        Get information about the current session.
        """
        driver = self.get_driver()
        logger.info(f"Session ID: {driver.session_id}")

    @staticmethod
    def connect_to_existing_session(session_id, server_url) -> WebDriver:
        # Erstellen Sie eine Verbindung zum Server
        executor = RemoteConnection(server_url, keep_alive=True)

        # Erstellen Sie einen WebDriver mit der bestehenden Session-ID
        # Verwenden Sie options statt desired_capabilities
        options = ArgOptions()
        options.set_capability('platformName', 'Android')
        options.set_capability('appium:automationName', 'UIAutomator2')
        driver = WebDriver(command_executor=executor, options=options)

        # Überschreiben Sie die automatisch erstellte Session-ID mit der bestehenden
        driver.session_id = session_id

        return driver

    def old_wait_for_page_fully_loaded(self) -> None:
        # Warten bis document.readyState "complete" ist
        wait = WebDriverWait(self._driver, 30)
        logger.info("Waiting for page fully loaded")
        wait.until(lambda driver: self._driver.execute_script("return document.readyState") == "complete")


    def wait_for_page_fully_loaded(self) -> None:
        # Warten bis WebView verfügbar ist
        wait = WebDriverWait(self._driver, 30)
        logger.info("Waiting for WebView to be available")

        # Auf WebView-Kontexte warten
        wait.until(lambda driver: len(driver.contexts) > 1)

        # Zum WebView-Kontext wechseln
        webview_context = [context for context in self._driver.contexts if 'WEBVIEW' in context][0]
        self._driver.switch_to.context(webview_context)

        # Jetzt können wir JavaScript ausführen
        logger.info("Waiting for page fully loaded")
        wait.until(lambda driver: driver.execute_script("return document.readyState") == "complete")

        # Zurück zum nativen Kontext wechseln (optional)
        self._driver.switch_to.context("NATIVE_APP")

    def take_screenshot(self) -> None:
        self._driver.save_screenshot("screenshot.png")