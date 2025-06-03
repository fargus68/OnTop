"""
Driver Singleton Adapter Module

This module provides a compatibility layer for the DriverSingleton class.
It exposes functions with the same names and signatures as those in Mobile_Mgmt_Direct.py,
but internally uses the DriverSingleton class to ensure a single driver instance is shared
across all imports.

Usage:
    # Instead of importing from Mobile_Mgmt_Direct.py
    from Resources.Utils.DriverSingletonAdapter import get_driver, get_current_session

    # Use the functions as before
    driver = get_current_session()
"""

from DriverSingleton import DriverSingleton
from appium import webdriver

# Create a singleton instance
_singleton = DriverSingleton()

def get_driver() -> webdriver.Remote:
    """
    Get the current driver instance or create a new one if none exists.

    Returns:
        webdriver.Remote: The current driver instance.
    """
    return _singleton.get_driver()

def set_driver(driver: webdriver.Remote):
    """
    Set the global driver instance.

    Args:
        driver (webdriver.Remote): The driver instance to set.
    """
    _singleton.set_driver(driver)

def get_current_session():
    """
    Get the current driver session.

    Returns:
        webdriver.Remote: The current driver instance.
    """
    return _singleton.get_driver()

def open_application_tt_planer_on_google_pixel_9():
    """
    Open the TT-Planer application without reset.

    Returns:
        webdriver.Remote: The driver instance for the opened application.
    """
    return _singleton.open_application_tt_planer_on_google_pixel_9()

def restart_application():
    """
    Restart the application and wait for the login screen.
    """
    _singleton.restart_application()

def check_app_state_and_restart_app_if_appropriate():
    _singleton.check_app_state_and_restart_app_if_appropriate()

def wait_until_login_screen_is_ready():
    """
    Wait until the login screen is ready and handle any necessary actions.
    """
    _singleton.wait_until_login_screen_is_ready()

def get_sessions():
    """
    Get all Appium sessions.

    Returns:
        list: A list of active Appium sessions.
    """
    return _singleton.get_sessions()

def has_active_appium_sessions():
    """
    Check if there are any active Appium driver sessions.

    Returns:
        bool: True if there are active sessions, False otherwise.
    """
    return _singleton.has_active_appium_sessions()

def get_driver_for_first_session():
    """
    Get a driver object for the first found Appium session.

    Returns:
        webdriver.Remote: A driver object connected to the first found session,
                         or None if no sessions are found.
    """
    return _singleton.get_driver_for_first_session()

def close_all_appium_sessions():
    """
    Close all Appium sessions.
    """
    _singleton.close_all_appium_sessions()

def log_status():
    """
    Log the status of the current session.
    """
    _singleton.log_status()

def log_timeouts():
    """
    Log the timeouts of the current session.
    """
    _singleton.log_timeouts()

def get_session_info():
    """
    Get information about the current session.
    """
    return _singleton.get_session_info()

def open_session():
    """
    Open a new session (only use in pure python tests).

    Returns:
        webdriver.Remote: The driver instance for the opened application.
    """
    return _singleton.open_application_tt_planer_on_google_pixel_9()

def get_timeouts():
    """
    Get the timeouts of the current session.

    Returns:
        dict: The current timeout settings.
    """
    driver: webdriver.Remote = get_driver()
    return driver.get_settings()

def connect_to_existing_session(session_id, server_url):
    """
    Connect to an existing Appium session.

    Args:
        session_id (str): The ID of the session to connect to.
        server_url (str): The URL of the Appium server.

    Returns:
        webdriver.Remote: A driver object connected to the specified session.
    """

    #old:
    #return _singleton.connect_to_existing_session(session_id, server_url)

    driver: webdriver.Remote = _singleton.connect_to_existing_session(session_id, server_url)
    _singleton.set_driver(driver)  # Set the driver in the singleton
    return driver

def wait_for_page_fully_loaded():
    """
    Wait until the page is fully loaded.
    """
    _singleton.wait_for_page_fully_loaded()

def take_screenshot():
    """
    Take a screenshot of the current screen.

    Returns:
        None
    """
    _singleton.take_screenshot()

def get_session_id():
    """
    Get the session ID of the current driver.

    Returns:
        str: The session ID of the current driver.
    """
    return _singleton.get_session_id()

def start_monitoring_dashboard(port=8080):
    """
    Start a simple web server to monitor UiAutomator2 server status.

    Args:
        port (int): Port for the monitoring dashboard

    Returns:
        threading.Thread: The server thread
    """
    return _singleton.start_monitoring_dashboard(port)

def check_uiautomator2_server_status():
    """
    Check if the UiAutomator2 server is running properly.

    Returns:
        bool: True if the server is running, False otherwise
    """
    return _singleton.check_uiautomator2_server_status()

def restart_uiautomator2_server():
    """
    Restart the UiAutomator2 server if it's not responding.
    """
    _singleton.restart_uiautomator2_server()

def monitor_uiautomator2_server(interval=30):
    """
    Periodically monitor the UiAutomator2 server status.

    Args:
        interval (int): Check interval in seconds
    """
    return _singleton.monitor_uiautomator2_server(interval)

def monitor_appium_logs(log_file_path="appium.log"):
    """
    Monitor Appium logs for UiAutomator2 server issues.

    Args:
        log_file_path (str): Path to the Appium log file
    """
    return _singleton.monitor_appium_logs(log_file_path)

def perform_critical_operation(operation_func, *args, **kwargs):
    """
    Perform a critical operation with automatic recovery if it fails.

    Args:
        operation_func (callable): The function to execute
        *args: Arguments to pass to the function
        **kwargs: Keyword arguments to pass to the function

    Returns:
        The result of the operation function
    """
    return _singleton.perform_critical_operation(operation_func, *args, **kwargs)

def check_uiautomator2_process():
    """
    Check if the UiAutomator2 process is running on the device.

    Returns:
        bool: True if the process is running, False otherwise
    """
    return _singleton.check_uiautomator2_process()

def restart_tt_planer_application():
    """
    Restart the TT-Planer application.
    """
    _singleton.restart_tt_planer_application()

def scroll_to_top():
    """
    Scroll to the top of the current page.
    """
    _singleton.scroll_to_top()

def scroll_page_down():
    """
    Scroll down the current page.
    """
    _singleton.scroll_page_down()
