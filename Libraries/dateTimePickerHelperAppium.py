import calendar
import string
import datetime
from time import sleep
from appium import webdriver
from appium.webdriver import webelement
from appium.webdriver.common.appiumby import AppiumBy
from appium.options.android import UiAutomator2Options
from selenium.common import NoSuchElementException
from sessionHelperAppium import open_session
from elementHelperAppium import search_element

def set_value(value):
    driver = open_session()
    sleep(1)

    theDatePicker = search_element("//android.widget.DatePicker[@resource-id='android:id/datePicker']", driver)
    theClearButton = search_element("//android.widget.Button[@text='Clear']", driver)
    theCancelButton = search_element("//android.widget.Button[@text='Cancel']", driver)
    theSetButton = search_element("//android.widget.Button[@text='Set']", driver)
    theMonthView = search_element("//android.view.View[@resource-id='android:id/month_view']", driver)
    previousMonthArrow = search_element("//android.widget.ImageButton[@content-desc='Previous month']", driver)
    nextMonthArrow = search_element("//android.widget.ImageButton[@content-desc='Next month']", driver)

    #/parent::*/parent::*/parent::*
    tag , monat , jahr = map(int, value.split("."))
    print("Tag:", tag)
    print("Monat:", monat)
    print("Jahr:", jahr)

    eingestellterMonatserster = theMonthView.find_element(AppiumBy.XPATH, "//android.view.View[@text='1']")
    eingestellterMonatsersterWert = eingestellterMonatserster.get_attribute("content-desc")
    print(eingestellterMonatsersterWert)
    irrelevantertag1, monatsname, eingestelltesjahralsstring = eingestellterMonatsersterWert.split(" ")
    print(irrelevantertag1)
    print(monatsname)
    print(eingestelltesjahralsstring)

    eingestelltesjahr = int(eingestelltesjahralsstring)
    print(type(eingestelltesjahr))
    #eingestelltermonat = get_month_as_number(monatsname)
    eingestelltermonat : int = monat_als_zahl(monatsname)
    print(eingestelltermonat)

    diff_jahre_in_monate = (jahr - eingestelltesjahr) * 12
    print(diff_jahre_in_monate)
    diff_monate = monat - eingestelltermonat
    print(diff_monate)
    diff_monate_gesamt = diff_jahre_in_monate + diff_monate
    print(diff_monate_gesamt)

    if diff_monate_gesamt > 0:
        for i in range(1, diff_monate_gesamt + 1):
            nextMonthArrow.click()

    if diff_monate_gesamt < 0:
        for i in range(1, (diff_monate_gesamt * - 1) + 1):
            previousMonthArrow.click()

    #Element muss neu eingelesen werden
    theMonthView = search_element("//android.view.View[@resource-id='android:id/month_view']", driver)
    theMonthView.find_element(AppiumBy.XPATH, "//android.view.View[@text='" + str(tag) + "']").click()
    theSetButton.click()

def monat_als_zahl(monatsname):
    monate = {monat.lower(): index for index, monat in enumerate(calendar.month_name) if monat}
    return monate.get(monatsname.lower(), "Ungültiger Monat")



