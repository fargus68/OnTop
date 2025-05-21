"""
ScrollIntoView Module (Direct Appium Implementation)

This module provides functions for scrolling in a mobile application using the appium-python-client
library directly. It works with the Mobile_Mgmt_Direct module to access the Appium driver.

Usage:
    from Libraries.ScrollIntoView_Direct import scroll_to_top, scroll_page_down
"""

from time import sleep
#from Resources.Utils.Mobile_Mgmt_Direct import get_driver

import logging
# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def scroll_to_top(driver):
    logger.info("scroll_to_top")
    #driver = get_driver()
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    driver.execute_script("window.scrollTo(0, 0)")
    driver.switch_to.context(driver.contexts[0])
    sleep(0.25)

def scroll_page_down(driver):
    logger.info("scroll_page_down")
    #driver = get_driver()
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    driver.execute_script("window.scrollBy(0, 850)")
    driver.switch_to.context(driver.contexts[0])
    sleep(0.25)
