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
from time import sleep
from time import localtime

from appium import webdriver
from appium.options.android import UiAutomator2Options
from appium.webdriver.client_config import AppiumClientConfig

from selenium.common import WebDriverException, InvalidSessionIdException, NoSuchElementException

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, InvalidArgumentException

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

    LOGIN_BUTTON_XPATH = '//android.widget.Button[@text="Einloggen"]'
    WAIT_TIMEOUT = 10
    SERVER_URL_BASE = 'http://127.0.0.1:4723'
    TTPLANER_APP_PACKAGE = 'org.chromium.webapk.a62c68cebaf69977d_v2'
    TTPLANER_APP_ACTIVITY = 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity'
    APPIUM_PORT = '4723'
    APPIUM_HOST = '127.0.0.1'

    # Class variable to hold the singleton instance
    _instance = None

    # Class variable to hold the driver instance
    _driver: webdriver.Remote = None

    def __new__(cls):
        """
        Ensure only one instance of DriverSingleton is created.
        """
        if cls._instance is None:
            cls._instance = super(DriverSingleton, cls).__new__(cls)
            logger.info("DriverSingleton instance created at" + str(localtime()))
        return cls._instance

    def get_driver(self) -> webdriver.Remote:
        """
        Get the current driver instance or create a new one if none exists.

        Returns:
            webdriver.Remote: The current driver instance.
        """
        if DriverSingleton._driver is None:
            logger.info("(get_driver) Driver is None!")

            if self.has_active_appium_sessions():
                logger.info("(get_driver) Session found, driver instance created and existing session attached to it.")
                DriverSingleton._driver = self.get_driver_for_first_session()
                if DriverSingleton._driver is None:
                    logger.info("(get_driver) Multiple sessions found, delete them all and create a new one")
                    DriverSingleton._driver = self.open_application_tt_planer_on_google_pixel_9()
            else:
                logger.info("(get_driver) No session found, creating a new one")
                DriverSingleton._driver = self.open_application_tt_planer_on_google_pixel_9()

        logger.info("(get_driver) Returning driver instance with session-id = " + DriverSingleton._driver.session_id)
        return DriverSingleton._driver

    def set_driver(self, driver: webdriver.Remote) -> None:
        DriverSingleton._driver = driver

    def open_application_tt_planer_on_google_pixel_9(self):
        """
        Open the TT-Planer application without the reset.
        New format of 5.0 appium-python-client.

        Returns:
            webdriver.Remote: The driver instance for the opened application.
        """

        desired_caps = {
            'platformName': 'Android',
            'deviceName': 'emulator-5554',
            'appPackage': self.TTPLANER_APP_PACKAGE,
            'appActivity': self.TTPLANER_APP_ACTIVITY,
            'automationName': 'UIAutomator2',
            'noReset': True,
            'autoGrantPermissions': True,
            'newCommandTimeout': 300,       # Erhöhen auf 300 Sekunden oder mehr
            'adbExecTimeout': 120000,        # 60 Sekunden in Millisekunden
            'waitForIdleTimeout': 30000,    # 30 Sekunden in Millisekunden
            'uiautomator2ServerLaunchTimeout': 60000,  # Add this capability
            'uiautomator2ServerInstallTimeout': 60000,  # Add this capability
            'printPageSourceOnFindFailure': True,
        }

        client_config = AppiumClientConfig(
            remote_server_addr = self.SERVER_URL_BASE,
            direct_connection = True,
            keep_alive = True, #False,
            ignore_certificates = True,
        )
        driver = webdriver.Remote(
            options = UiAutomator2Options().load_capabilities(desired_caps),
            client_config = client_config
        )

        logger.info(f"(open_application) Application opened with session ID: {driver.session_id}")
        self.set_driver(driver)
        return driver

    def restart_tt_planer_application(self):
        """
        Restart the TT-Planer application and ensure the login screen is displayed.
        """
        logger.info("Initiating TT-Planer application restart")

        self._cleanup_existing_driver()
        self._initialize_new_driver()
        self._wait_for_login_screen()

    def _cleanup_existing_driver(self):
        """Clean up the existing driver instance if it exists."""
        if DriverSingleton._driver is None:
            logger.info("No existing driver instance to clean up")
            return

        logger.info("Cleaning up existing driver instance")
        DriverSingleton._driver.quit()
        DriverSingleton._driver = None

    def _initialize_new_driver(self):
        """Initialize a new driver instance for the application."""
        logger.info("Initializing new driver instance")
        DriverSingleton._driver = self.open_application_tt_planer_on_google_pixel_9()

    def _wait_for_login_screen(self):
        """Wait for the login screen to become visible."""
        logger.info("Waiting for login screen to appear")
        try:
            WebDriverWait(DriverSingleton._driver, self.WAIT_TIMEOUT).until(
                EC.visibility_of_element_located((By.XPATH, self.LOGIN_BUTTON_XPATH))
            )
            logger.info("Login screen successfully loaded")
        except TimeoutException:
            logger.error("Login screen did not appear within expected timeout")
            raise

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

        # Wait for the login button
        WebDriverWait(DriverSingleton._driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, '//android.widget.Button[@text="Einloggen"]'))
        )

    def check_app_state_and_restart_app_if_appropriate(self):
        driver: webdriver.Remote = self.get_driver()
        logger.info("(check app state) Session-ID = " + driver.session_id)

        if not self.check_uiautomator2_server_status():
            self.restart_uiautomator2_server()

        app_id = self.TTPLANER_APP_PACKAGE
        app_state = driver.query_app_state(app_id)
        logger.info("(check app state) app-state = " + str(app_state))
        if app_state != 4:
            logger.warning("(check app state) App is not running, restarting app!")
            driver.terminate_app(app_id, force=True)
            sleep(10)
            driver.activate_app(app_id)
            sleep(10)
            return

    def wait_until_login_screen_is_ready(self):
        login_dialog_available: bool = False

        driver: webdriver.Remote = self.get_driver()
        logger.info("(wait login) Session-ID = " + driver.session_id)

        if not self.check_uiautomator2_server_status():
            self.restart_uiautomator2_server()

        app_id = self.TTPLANER_APP_PACKAGE
        app_state = driver.query_app_state(app_id)
        logger.info("(wait login) app-state = " + str(app_state))
        if app_state != 4:
            logger.warning("(wait login) App is not running, restarting app!")
            driver.terminate_app(app_id, force=True)
            sleep(10)
            driver.activate_app(app_id)
            sleep(10)

        try:
            WebDriverWait(driver, 1).until(
                EC.visibility_of_element_located((By.XPATH, "//android.widget.Button[@text='Einloggen']"))
            )
            logger.info("(wait login) Login button found!")
            login_dialog_available = True
            return login_dialog_available
        except TimeoutException:
            logger.info("(wait login) Login button not found in the first place, now examining app situation ... ")
            if not self.check_uiautomator2_server_status():
                self.restart_uiautomator2_server()
            pass
        except WebDriverException as e:
            logger.info(f"(wait login) Error first search einloggen button: {e}")
            if not self.check_uiautomator2_server_status():
                self.restart_uiautomator2_server()
            pass

        # Try to scroll to the top (ignore errors)
        try:
            # Import locally to avoid circular import
            #from ScrollIntoView import scroll_to_top
            self.scroll_to_top()
        except Exception as e:
            logger.debug(f"(wait login) Error scrolling to top: {e}")
            pass

        logger.info("(wait login) Scrolled to top!")

        if not self.check_uiautomator2_server_status():
            self.restart_uiautomator2_server()

        #driver.switch_to.context(driver.contexts[1])
        #print(driver.current_context)

        # Check for the close button and click if present
        try:
            #close_button = WebDriverWait(driver, 10).until(
            #    EC.visibility_of_element_located((By.XPATH, '//android.widget.TextView[@text=""]')))

            xpath_close_button = "//android.view.View[@resource-id='navbar-collapse'][2]/android.widget.ListView/android.view.View[3]/android.view.View/android.widget.TextView"
            close_button = WebDriverWait(driver, 1).until(
                EC.visibility_of_element_located((By.XPATH, xpath_close_button)))

            close_button.click()
            logger.info("(wait login) Close button found and clicked!")
        except TimeoutException:
            logger.info("(wait login) Close button not found or not visible")
            pass
        except Exception as e:
            logger.error(f"(wait login) Error handling close button: {e}")
            pass

        logger.info("(wait login) Close-button handled!")

        #driver.switch_to.context(driver.contexts[0])
        #print(driver.current_context)

        if not self.check_uiautomator2_server_status():
            logger.info("(wait login) UiAutomator2 server not running, restarting server!")
            self.restart_uiautomator2_server()
            sleep(15)

        original_settings = driver.get_settings()
        logger.info("(wait login) original_settings = "  + str(original_settings))
        #original_settings = self.perform_critical_operation(self.get_settings_wrapper())
        logger.info("(wait login) getting settings for saving purpose!")
        driver.update_settings({"shouldUseCompactResponses": False})
        logger.info("(wait login) update single setting to exclude caching!")

        # Check for the login button
        exception_found = False
        try:
            WebDriverWait(driver, 1).until(
                EC.visibility_of_element_located((By.XPATH, "//android.widget.Button[@text='Einloggen']"))
            )
            logger.info("(wait login)Login button found!")
            login_dialog_available = True
            #return True
        except TimeoutException:
            # If login button not found, restart the application
            logger.info("(wait login)Login button not found, restarting application")
            self.restart_application()
        except InvalidSessionIdException as e:
            logger.info("(wait login)Login button not found (InvalidSessionIdException)")
            exception_found = True
        except NoSuchElementException as e:
            logger.info("(wait login)Login button not found (NoSuchElementException)")
            exception_found = True
        except Exception as e:
            print("(wait login)Exception = " + str(e))
            exception_found = True
            #pass

        if exception_found:
            logger.error(f"(wait login) Exception when try to find Einloggen button")

        # Restore original settings
        logger.info("(wait login)Restoring original settings")
        driver.update_settings({"shouldUseCompactResponses": original_settings.get("shouldUseCompactResponses", True)})
        logger.info("(wait login) driver = " + str(driver))

        return login_dialog_available

    def get_open_sessions_count(self):
        sessions = self.get_sessions()
        anzahl_sessions = len(sessions)
        logger.info(f"(get open session count) Anzahl der offenen Sessions: {anzahl_sessions}")
        return anzahl_sessions

    def get_sessions(self):
        """
        Get all Appium sessions.

        Returns:
            list: A list of active Appium sessions.
        """
        logger.info("(get sessions) Getting sessions")
        #response = requests.get("http://192.168.2.224:4723/sessions")

        try:
            response = requests.get(self.SERVER_URL_BASE + "/sessions")
            if response.status_code == 200:
                sessions = response.json().get('value', [])
                logger.info(f"get sessions) Number of sessions: {len(sessions)}")
                return sessions
            else:
                logger.error(f"get sessions) Error retrieving sessions: {response.status_code}")
                return []
        except ConnectionError as e:
            logger.debug(f"get sessions) Connection error: {e}")
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
            logger.info("(get driver first session) No active sessions found")
            return None

        if len(sessions) > 1:
            logger.warning(f"(get driver first session) Multiple active sessions found: {len(sessions)}")
            self.close_all_appium_sessions()
            return None

        # Get the first session
        first_session = sessions[0]
        session_id = first_session['id']
        logger.info(f"(get driver first session) Connecting to existing session with ID: {session_id}")

        try:
            driver: webdriver.Remote = self.connect_to_existing_session(session_id, self.SERVER_URL_BASE)
            logger.info("(get driver first session) driver connected to existing session - now testing if session is working")

            # Test if the session is actually working
            try:
                # Simple command to test if the session is responsive
                #driver.get_page_source()
                print(driver.current_context)
                return driver
            except Exception as e:
                logger.error(f"(get driver first session) Session exists but is not responsive: {e}")
                # Close the broken session
                self.close_all_appium_sessions()
                # Create a new session
                return self.open_application_tt_planer_on_google_pixel_9()

        except Exception as e:
            logger.error(f"(get driver first session) Failed to connect to existing session: {e}")
            return None

        #return self.connect_to_existing_session(session_id, self.SERVER_URL_BASE)

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
                response_delete_request = requests.delete(f"{self.SERVER_URL_BASE}/session/{session_id}")
                logger.info(f"(close all appium sessions) Closing session {session_id} status code: {response_delete_request.status_code}")
                if response_delete_request.status_code != 200:
                    logger.fatal(f"(close all appium sessions) Error closing session {session_id}: {response_delete_request.status_code}")

            #bis zu 15 Sekunden warten bis alle Sessions gelöscht wurden
            Retries = 0
            while self.get_open_sessions_count() > 0:
                Retries += 1
                if Retries > 15:
                    break
                sleep(1)

            if Retries > 15:
                logger.error(f"(close all appium sessions) Error closing sessions: {response.status_code}")
            else:
                logger.info(f"(close all appium sessions) All sessions closed: {len(sessions)} closed")
        else:
            logger.error(f"(close all appium sessions) Error retrieving sessions: {response.status_code}")

    def log_status(self):
        """
        Log the status of the current session.
        """
        driver: webdriver.Remote = self.get_driver()
        logger.info(f"(log status) Session status: {driver.get_status()}")

    def log_timeouts(self):
        """
        Log the timeouts of the current session.
        """
        driver: webdriver.Remote = self.get_driver()
        logger.info(f"(log timeout) Timeouts: {driver.get_settings()}")

    def get_session_info(self):
        """
        Get information about the current session.
        """
        driver: webdriver.Remote = self.get_driver()
        logger.info(f"(get session info) Session ID: {driver.session_id}")

    def connect_to_existing_session(self, session_id, server_url) -> webdriver.Remote:
        """
        Connect to an existing appium session.

        Args:
            session_id (str): The ID of the session to connect to.
            server_url (str): The URL of the Appium server.

        Returns:
            webdriver.Remote: A driver object connected to the specified session.
        """

        # Create client config with the base server URL (not including session ID)
        client_config = AppiumClientConfig(
            remote_server_addr=server_url,
            direct_connection=True,
            keep_alive=True,
            ignore_certificates=True,
        )

        # Create minimal capabilities
        options = UiAutomator2Options()
        options.set_capability('platformName', 'Android')

        # Create the driver with empty options
        driver = webdriver.Remote(
            options=options,
            client_config=client_config
        )

        # Set the session ID directly
        original_session_id = driver.session_id
        driver.session_id = session_id

        logger.info(
            f"(connect to existing session) Successfully connected to existing session with ID: {session_id} (replaced {original_session_id})")

        requests.delete(f"{self.SERVER_URL_BASE}/session/{original_session_id}")
        logger.info(f"(connect to existing session) Temporarily added session with session id {original_session_id} deleted!")

        return driver

    def wait_for_page_fully_loaded(self) -> None:
        # Warten bis WebView verfügbar ist
        driver: webdriver.Remote = self.get_driver()

        wait = WebDriverWait(driver, 30)
        #logger.info("Waiting for WebView to be available")
        logger.info("(wait for page) Waiting for WebView to be available")

        # Auf WebView-Kontexte warten
        #wait.until(lambda driver: len(driver.contexts) > 1)
        wait.until(lambda driver: len(driver.contexts) > 1)

        # Zum WebView-Kontext wechseln
        webview_context = [context for context in self._driver.contexts if 'WEBVIEW' in context][0]
        driver.switch_to.context(webview_context)

        # Jetzt können wir JavaScript ausführen
        logger.info("wait for page) Waiting for page fully loaded")
        wait.until(lambda driver: driver.execute_script("return document.readyState") == "complete")

        # Zurück zum nativen Kontext wechseln (optional)
        driver.switch_to.context("NATIVE_APP")

    def take_screenshot(self) -> None:
        driver: webdriver.Remote = self.get_driver()
        driver.save_screenshot("screenshot.png")

    def get_session_id(self):
        driver: webdriver.Remote = self.get_driver()
        return driver.session_id

    def check_uiautomator2_server_status(self):
        driver: webdriver.Remote = self.get_driver()
        try:
            # Test page_source
            print("Source = " + driver.page_source)
            logger.info("(check uiautomator2) UiAutomator2 server is responding")

            # Testing settings endpoint
            try:
                driver.get_settings()
                logger.info("(check uiautomator2) UiAutomator2 server is fully functional (including settings API)")
                return True
            except Exception as e:
                logger.error(f"(check uiautomator2) UiAutomator2 server settings API not working: {e}")
                return False

        except Exception as e:
            logger.error(f"(check uiautomator2) UiAutomator2 server is not responding: {e}")
            return False

    def monitor_uiautomator2_server(self, interval=30):
        """
        Periodically monitor the UiAutomator2 server status.

        Args:
            interval (int): Check interval in seconds
        """

        def _monitor():
            while True:
                status = self.check_uiautomator2_server_status()
                if not status:
                    logger.warning("UiAutomator2 server is down, attempting recovery...")
                    self.restart_uiautomator2_server()
                import time
                time.sleep(interval)

        # Start monitoring in a background thread
        import threading
        monitor_thread = threading.Thread(target=_monitor, daemon=True)
        monitor_thread.start()
        logger.info(f"UiAutomator2 server monitoring started (interval: {interval}s)")

    def restart_uiautomator2_server(self):
        """
        Restart the UiAutomator2 server if it's not responding.
        """
        driver: webdriver.Remote = self.get_driver()
        session_id = driver.session_id

        try:
            # Stop the UiAutomator2 server
            logger.info("Stopping UiAutomator2 server...")
            driver.execute_script('mobile: shell', {
                'command': 'am force-stop io.appium.uiautomator2.server'
            })
            driver.execute_script('mobile: shell', {
                'command': 'am force-stop io.appium.uiautomator2.server.test'
            })

            # Restart the UiAutomator2 server
            logger.info("Restarting UiAutomator2 server...")
            driver.execute_script('mobile: shell', {
                'command': 'am instrument -w io.appium.uiautomator2.server.test/androidx.test.runner.AndroidJUnitRunner'
            })

            # Wait for the server to be ready - increase wait time
            sleep(10)  # Increase from 5 to 10 seconds

            # Test if the server is responsive
            print("Source = " + driver.page_source)

            # Also test if settings API is working
            try:
                driver.get_settings()
                logger.info("UiAutomator2 server successfully restarted with working settings API")
            except Exception as e:
                logger.error(f"Settings API not working after restart: {e}")
                # Try one more restart with longer wait
                sleep(5)
                driver.execute_script('mobile: shell', {
                    'command': 'am instrument -w io.appium.uiautomator2.server.test/androidx.test.runner.AndroidJUnitRunner'
                })
                sleep(15)  # Longer wait time
        except Exception as e:
            logger.error(f"Failed to restart UiAutomator2 server: {e}")
            # If restart fails, create a new session
            self.close_all_appium_sessions()
            self.open_application_tt_planer_on_google_pixel_9()

    def get_settings_wrapper(self):
        driver: webdriver.Remote = self.get_driver()
        return driver.get_settings()

    def monitor_appium_logs(self, log_file_path="appium.log"):
        """
        Monitor Appium logs for UiAutomator2 server issues.
        """
        import re
        #from pathlib import Path

        def _tail_file(file_path):
            with open(file_path, 'r') as f:
                f.seek(0, 2)  # Go to the end of the file
                while True:
                    line = f.readline()
                    if not line:
                        import time
                        time.sleep(0.1)
                        continue
                    yield line

        def _log_monitor():
            error_patterns = [
                r"cannot be proxied to UiAutomator2 server because the instrumentation process is not running",
                r"UiAutomator2 server crashed",
                r"Failed to start instrumentation"
            ]

            for line in _tail_file(log_file_path):
                for pattern in error_patterns:
                    if re.search(pattern, line):
                        logger.warning(f"UiAutomator2 server issue detected: {line.strip()}")
                        self.restart_uiautomator2_server()
                        break

        # Start monitoring in a background thread
        import threading
        log_thread = threading.Thread(target=_log_monitor, daemon=True)
        log_thread.start()
        logger.info(f"Appium log monitoring started (file: {log_file_path})")

    def perform_critical_operation(self, operation_func, *args, **kwargs):
        """
        Perform a critical operation with UiAutomator2 server status check.

        Args:
            operation_func: The function to execute
            *args, **kwargs: Arguments to pass to the function

        Returns:
            The result of the operation function
        """
        if not self.check_uiautomator2_server_status():
            logger.warning("UiAutomator2 server is not responsive, restarting...")
            self.restart_uiautomator2_server()

        return operation_func(*args, **kwargs)

    def check_uiautomator2_process(self):
        """
        Check if the UiAutomator2 server process is running using ADB.

        Returns:
            bool: True if the process is running, False otherwise
        """
        driver = self.get_driver()
        try:
            # Use ADB to check if the UiAutomator2 server process is running
            result = driver.execute_script('mobile: shell', {
                'command': 'ps -A | grep uiautomator'
            })

            if 'io.appium.uiautomator2.server' in result:
                logger.info("UiAutomator2 server process is running")
                return True
            else:
                logger.warning("UiAutomator2 server process is not running")
                return False
        except Exception as e:
            logger.error(f"Error checking UiAutomator2 process: {e}")
            return False


    def start_monitoring_dashboard(self, port=8080):
        """
        Start a simple web server to monitor UiAutomator2 server status.

        Args:
            port (int): Port for the monitoring dashboard

        Returns:
            threading.Thread: The server thread
        """
        from Resources.Utils.UiAutomator2MonitoringDashboard import start_monitoring_dashboard
        return start_monitoring_dashboard(self, port)

    def scroll_to_top(self):
        logger.info("scroll_to_top")
        self.wait_for_page_fully_loaded()
        driver: webdriver.Remote = self.get_driver()

        driver.switch_to.context(driver.contexts[1])
        print(driver.current_context)
        driver.execute_script("window.scrollTo(0, 0)")
        driver.switch_to.context(driver.contexts[0])
        sleep(0.25)

    def scroll_page_down(self):
        logger.info("scroll_page_down")
        self.wait_for_page_fully_loaded()
        driver: webdriver.Remote = self.get_driver()

        driver.switch_to.context(driver.contexts[1])
        print(driver.current_context)
        driver.execute_script("window.scrollBy(0, 850)")
        driver.switch_to.context(driver.contexts[0])
        sleep(0.25)
