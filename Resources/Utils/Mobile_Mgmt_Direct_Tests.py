import unittest
import logging
from time import sleep

# Import the module to test
from Resources.Utils.Mobile_Mgmt_Direct import (
    open_application_tt_planer_on_google_pixel_9,
    log_status,
    log_timeouts,
    get_sessions,
    open_session,
    close_all_appium_sessions,
    get_driver,
    has_active_appium_sessions,
    get_driver_for_first_session,
)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class TestMobileMgmt(unittest.TestCase):
    """Test cases for Mobile_Mgmt.py functions."""

    def test1(self):
        open_application_tt_planer_on_google_pixel_9()
        log_status()
        log_timeouts()
        logger.info("Test1 passed")

    def test2(self):
        #open_application_tt_planer_on_google_pixel_9()
        log_status()
        log_timeouts()
        logger.info("Test2 passed")

    def test_get_driver(self):
        logger.info(get_driver())


    def test_session_management(self):
        """Test session management functions."""
        # Get initial sessions
        logger.info(get_sessions())

        # Open multiple sessions
        open_session()
        open_session()
        open_session()

        # Check sessions after opening
        logger.info(f"Appium-Sessions = {get_sessions()}")

        # Close all sessions
        close_all_appium_sessions()
        sleep(1)

        # Check sessions after closing
        logger.info(f"Appium-Sessions = {get_sessions()}")

        # Wait and check again
        sleep(10)
        logger.info(f"Appium-Sessions = {get_sessions()}")

    def test_has_active_sessions(self):
        """Test the has_active_appium_sessions function."""
        # Close all sessions to start with a clean state
        close_all_appium_sessions()
        sleep(1)

        # Check if there are any active sessions (should be False)
        has_sessions_before = has_active_appium_sessions()
        logger.info(f"Has active sessions before opening: {has_sessions_before}")
        self.assertFalse(has_sessions_before, "Expected no active sessions before opening")

        # Open a session
        open_session()
        sleep(1)

        # Check if there are any active sessions (should be True)
        has_sessions_after = has_active_appium_sessions()
        logger.info(f"Has active sessions after opening: {has_sessions_after}")
        self.assertTrue(has_sessions_after, "Expected active sessions after opening")

        # Clean up
        close_all_appium_sessions()

    def test_get_driver_for_first_session(self):
        """Test the get_driver_for_first_session function."""
        # Close all sessions to start with a clean state
        close_all_appium_sessions()
        sleep(1)

        # Make sure there's at least one active session
        open_session()
        sleep(1)

        # Get driver for first session
        driver = get_driver_for_first_session()

        # Verify driver is not None and has a session ID
        self.assertIsNotNone(driver, "Expected a valid driver object")
        self.assertIsNotNone(driver.session_id, "Expected driver to have a session ID")
        logger.info(f"Got driver for first session with session ID: {driver.session_id}")

        # Verify driver can perform basic operations
        try:
            status = driver.get_status()
            logger.info(f"Driver status: {status}")
            self.assertIsNotNone(status, "Expected driver to return status")
        except Exception as e:
            self.fail(f"Driver failed to perform basic operation: {e}")

        # Clean up
        close_all_appium_sessions()

    def test_get_sessions(self):
        get_sessions()

if __name__ == '__main__':
        unittest.main()
