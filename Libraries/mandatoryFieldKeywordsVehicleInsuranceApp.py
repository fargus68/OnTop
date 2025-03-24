#from sessionHelperAppium import get_current_session
from time import sleep

from robot.api import logger

from playwright import *
from playwright.sync_api import sync_playwright

def process_mandatory_field_keyword(selector, keyword):
    logger.info('process_mandatory_field_keyword')

    #p = sync_playwright()
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        page = browser.new_page()
        page.goto("https://sampleapp.tricentis.com/101/index.php")
        print(page.title())  # Output: Example Domain
        sleep(1)
        button = page.locator("button#submit")  # Beispiel: Button mit ID "submit"
        page.locator("xpath=//*[@class='main-navigation']//*[@id='nav_automobile']").click()
        sleep(1)
        #browser.close()

        #page_title = context.evaluate("document.title")  # Beispiel: Hole den Seitentitel
        #print(f"Page title is: {page_title}")
        #driver = get_current_session()

        #theElement = search_element(selector, driver)

        selMake = page.locator("xpath=//*[@id='make']")

        #druckt den Listeninhalt
        #print(page.locator("xpath=//*[@id='make']").inner_text())
        print(selMake.inner_text())

        selMake.select_option("Audi")
        sleep(1)


        icoMandatoryField = selMake.locator("xpath=//parent::*/*[@class='icon']")
        icoMandatoryField.screenshot(path="C:/temp/hallo.png")

        keywordProcesses = False
        if keyword == "<NoMandatoryField>":
            print("Keyword = '<NoMandatoryField>'")
            keywordProcesses = True
        elif keyword == "<MissingMandatoryField>":
            print("Keyword = '<MissingMandatoryField>'")
            keywordProcesses = True
        elif keyword == "<FilledMandatoryField>":
            print("Keyword = '<FilledMandatoryField>'")
            keywordProcesses = True
        else:
            print("Keyword not found")

        browser.close()

    return keywordProcesses
