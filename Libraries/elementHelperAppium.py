from time import sleep

from selenium.common import NoSuchElementException
from appium.webdriver import webelement
from appium.webdriver import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from ScrollIntoView import scroll_page_down
from ScrollIntoView import scroll_page_down_with_driver
from sessionHelperAppium import open_session

def search_element(selector, driver):
    element : webelement.WebElement
    element_found = False
    retry_count = 1
    while element_found is False:
        try:
            element = driver.find_element(AppiumBy.XPATH, selector)
            element_found = True
        except NoSuchElementException:
            retry_count -= 1
            #scroll_page_down("url not necessary!")
            scroll_page_down_with_driver(driver)
            #driver.close()
            #driver = open_session()
            sleep(0.5)
        if retry_count == -1:
            break
    return element