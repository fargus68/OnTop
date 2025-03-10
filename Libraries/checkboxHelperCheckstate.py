import datetime
from time import sleep
from appium import webdriver
from appium.webdriver import webelement
from appium.webdriver.common.appiumby import AppiumBy
from appium.options.android import UiAutomator2Options
from selenium.common import NoSuchElementException
from win32con import NULLREGION
from ScrollIntoView import scroll_page_down
from sessionHelperAppium import open_session
from elementHelperAppium import search_element
import PIL

def get_checkbox_state(selector):
    driver = open_session()
    sleep(1)

    #theCheckbox = driver.find_element(AppiumBy.XPATH, selector)
    theCheckbox = search_element(selector, driver)
    now = datetime.datetime.now()
    # String im gewünschten Format erstellen
    formatted_string = now.strftime("%Y%m%d_%H%M%S")

    filename = "checkboxStateActual_" + formatted_string + ".png"
    theCheckbox.screenshot(filename)
    diff = simple_image_compare(filename)
    if diff > 0.5:
        return True
    else:
        return False

def to_delete_search_checkbox(selector, driver):
    element : webelement.WebElement
    element_found = False
    retry_count = 1
    while element_found is False:
        try:
            element = driver.find_element(AppiumBy.XPATH, selector)
            element_found = True
        except NoSuchElementException:
            retry_count -= 1
            scroll_page_down("url not necessary!")
            #driver.close()
            driver = open_session()
        if retry_count == -1:
            break
    return element

def simple_image_compare(filename):
    import cv2
    #import numpy as np

    from PIL import Image
    img = Image.open(filename)
    print(img.size)
    print(img.size[0])
    print(img.size[1])

    # Lade die Bilder
    if img.size[0] == 54:
        first_image = cv2.imread('Resources/Images/checkboxStateChecked_54_57.png')
    else:
        first_image = cv2.imread('Resources/Images/checkboxStateChecked_57_57.png')
    second_image = cv2.imread(filename)
    #second_image = cv2.imread('checkboxStateActual.png')

    # Konvertiere die Bilder in Graustufen
    first_image_gray = cv2.cvtColor(first_image, cv2.COLOR_BGR2GRAY)
    second_image_gray = cv2.cvtColor(second_image, cv2.COLOR_BGR2GRAY)

    # Berechne den strukturellen Ähnlichkeitsindex (SSIM)
    from skimage.metrics import structural_similarity
    score, diff = structural_similarity(first_image_gray, second_image_gray, full=True)
    diff = (diff * 255).astype("uint8")

    print(f"Ähnlichkeitswert: {score}")
    return score