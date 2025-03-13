from time import sleep

from selenium.common import NoSuchElementException
from appium.webdriver import webelement
from appium.webdriver import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from ScrollIntoView import scroll_page_down
#from ScrollIntoView import scroll_page_down_with_driver
#from sessionHelperAppium import open_session
from sessionHelperAppium import get_current_session
from robot.api import logger

def search_element(selector, driver):
    logger.info('Search element')
    driver2 = get_current_session()
    element : webelement.WebElement
    element_found = False
    retry_count = 10
    while element_found is False:
        try:
            logger.info('new attempt to find element')
            element = driver2.find_element(AppiumBy.XPATH, selector)
            element_found = True
            logger.info(' => successfully found element')
        except NoSuchElementException:
            retry_count -= 1
            #scroll_page_down_with_driver(driver)
            scroll_page_down()
            #driver.close()
            #driver = open_session()
            sleep(0.25)
        if retry_count == -1:
            break
    logger.info('end of Search element')
    return element