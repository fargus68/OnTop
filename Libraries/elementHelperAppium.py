from time import sleep
from selenium.common import TimeoutException
from selenium.common import StaleElementReferenceException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
from ScrollIntoView_Direct import scroll_page_down
#from Resources.Utils.Mobile_Mgmt_Direct import get_current_session
#from Resources.Utils.Mobile_Mgmt_Direct import *
import  Resources.Utils.Mobile_Mgmt_Direct  as mgmt_direct
from robot.api import logger
from appium import webdriver

def search_element(selector, retry_count = 10):
    logger.info('Search element with selector: ' + selector)
    if selector.startswith('xpath='):
        selector = selector[6:]

    driver: webdriver.Remote = mgmt_direct.get_current_session()

    logger.info("Session-id = " + driver.session_id)
    element = None
    element_found = False
    #retry_count = 10
    while element_found is False:
        try:
            logger.info('new attempt to find element')

            wait = WebDriverWait(driver, 10)  # Warte bis zu 10 Sekunden
            element = wait.until(ec.presence_of_element_located((By.XPATH, selector)))

            #element = driver.find_element(By.XPATH, selector)

            element_found = True
            logger.info(' => successfully found element')
        except TimeoutException:    #NoSuchElementException:
            retry_count -= 1
            scroll_page_down(driver)
            sleep(0.25)
        if retry_count == -1:
            break
    logger.info('end of Search element')
    return element

def search_sub_elements(selector):
    logger.info('Search sub elements with selector: ' + selector)
    if selector.startswith('xpath='):
        selector = selector[6:]
    driver: webdriver.Remote = mgmt_direct.get_current_session()
    logger.info("Session-id = " + driver.session_id)
    list_of_elements = driver.find_elements(By.XPATH, selector)
    return list_of_elements

def wait_until_element_exists_and_text_correct(selector, expected_text):
    logger.info('wait until element exists and text is correct')
    element = search_element(selector)
    if element is None:
        logger.info(' => element not found')
        return False

    driver: webdriver.Remote = mgmt_direct.get_current_session()
    element_text: str
    try:
        wait = WebDriverWait(driver, 10)  # Warte bis zu 10 Sekunden
        element_text = wait.until(ec.presence_of_element_located((By.XPATH, selector))).text
    except StaleElementReferenceException:
        logger.info(' => StaleElementReferenceException')
        return False

    if element_text == expected_text:
        logger.info(' => element text is correct')
        return True
    else:
        logger.info(' => element text is not correct')
        return False

def check_if_element_exists(selector):
    logger.info('check_if_element_exists')
    element = search_element(selector)
    if element is None:
        logger.info(' => element not found')
        return False
    else:
        logger.info(' => element found')
        return True


def search_element_without_cache(selector):
    driver: webdriver.Remote = mgmt_direct.get_current_session()

    # Wenn der Selektor mit xpath= beginnt, entferne diesen Präfix
    if selector.startswith('xpath='):
        selector = selector[6:]

    # Setze die Cache-Einstellung temporär auf false
    original_settings = driver.get_settings()
    driver.update_settings({"shouldUseCompactResponses": False})

    try:
        # Suche das Element direkt ohne Cache
        element = driver.find_element(By.XPATH, selector)
        return element
    finally:
        # Stelle die ursprünglichen Einstellungen wieder her
        driver.update_settings({"shouldUseCompactResponses": original_settings.get("shouldUseCompactResponses", True)})
