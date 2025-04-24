from time import sleep

from selenium.common import NoSuchElementException
from appium.webdriver import webelement
from appium.webdriver import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from ScrollIntoView_Direct import scroll_page_down
#from ScrollIntoView import scroll_page_down_with_driver
#from sessionHelperAppium import open_session
from sessionHelperAppium import get_current_session
from robot.api import logger

def search_element(selector, retry_count = 10):
    logger.info('Search element with selector: ' + selector)
    if selector.startswith('xpath='):
        selector = selector[6:]
    driver = get_current_session()
    logger.info("Session-id = " + driver.session_id)
    element : webelement.WebElement
    element_found = False
    #retry_count = 10
    while element_found is False:
        try:
            logger.info('new attempt to find element')
            element = driver.find_element(AppiumBy.XPATH, selector)
            element_found = True
            logger.info(' => successfully found element')
        except NoSuchElementException:
            retry_count -= 1
            #scroll_page_down_with_driver(driver)
            scroll_page_down(driver)
            #driver.close()
            #driver = open_session()
            sleep(0.25)
        if retry_count == -1:
            break
    logger.info('end of Search element')
    return element

def wait_until_element_exists_and_text_correct(selector, expected_text):
    logger.info('wait until element exists and text is correct')
    element = search_element(selector)
    if element.text == expected_text:
        logger.info(' => element text is correct')
        return True
    else:
        logger.info(' => element text is not correct')
        return False