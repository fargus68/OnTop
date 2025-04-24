import datetime
from time import sleep
from sessionHelperAppium import open_session
from sessionHelperAppium import get_current_session
from elementHelperAppium import search_element
from robot.api import logger

def get_checkbox_state(selector):
    logger.info('getting checkbox state')
    driver = get_current_session()
    logger.info('session opened')
    #sleep(1)

    theCheckbox = search_element(selector)
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

def old_get_checkbox_state(selector):
    logger.info('old getting checkbox state')
    driver = open_session()
    logger.info('old session opened')
    sleep(1)

    #theCheckbox = driver.find_element(AppiumBy.XPATH, selector)
    theCheckbox = search_element(selector)
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