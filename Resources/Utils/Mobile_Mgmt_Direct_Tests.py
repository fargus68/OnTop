import unittest
import logging

# Import the module to test
from Resources.Utils.Mobile_Mgmt_Direct import (
    open_application_tt_planer_on_google_pixel_9,
    log_status,
    log_timeouts,
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

if __name__ == '__main__':
        unittest.main()