import calendar
#import string
#import datetime
from time import sleep
from appium.webdriver.common.appiumby import AppiumBy
#from sessionHelperAppium import open_session
from Resources.Utils.DriverSingletonAdapter import get_current_session
from elementHelperAppium import search_element
from robot.api import logger

def set_value(value):
    logger.info("set value")
    #driver = open_session()
    driver = get_current_session()
    sleep(0.25)

    logger.info("driver assigned to current session")

    theDatePicker = search_element("//android.widget.DatePicker[@resource-id='android:id/datePicker']")
    logger.info("theDatePicker identified")

    theClearButton = search_element("//android.widget.Button[@text='Clear']")
    theCancelButton = search_element("//android.widget.Button[@text='Cancel']")
    theSetButton = search_element("//android.widget.Button[@text='Set']")
    logger.info("buttons identified")

    theMonthView = search_element("//android.view.View[@resource-id='android:id/month_view']")
    previousMonthArrow = search_element("//android.widget.ImageButton[@content-desc='Previous month']")
    nextMonthArrow = search_element("//android.widget.ImageButton[@content-desc='Next month']")

    logger.info("some other elements identified")

    tag , monat , jahr = map(int, value.split("."))
    print("Tag:", tag, " Monat:", monat, " Jahr:", jahr)

    eingestellterMonatserster = theMonthView.find_element(AppiumBy.XPATH, "//android.view.View[@text='1']")
    eingestellterMonatsersterWert = eingestellterMonatserster.get_attribute("content-desc")
    print(eingestellterMonatsersterWert)
    irrelevantertag1, monatsname, eingestelltesjahralsstring = eingestellterMonatsersterWert.split(" ")
    print(irrelevantertag1, monatsname, eingestelltesjahralsstring)

    eingestelltesjahr = int(eingestelltesjahralsstring)
    #print(type(eingestelltesjahr))
    eingestelltermonat : int = monat_als_zahl(monatsname)
    #print(eingestelltermonat)

    diff_jahre_in_monate = (jahr - eingestelltesjahr) * 12
    #print(diff_jahre_in_monate)
    diff_monate = monat - eingestelltermonat
    #print(diff_monate)
    diff_monate_gesamt = diff_jahre_in_monate + diff_monate
    #print(diff_monate_gesamt)

    if diff_monate_gesamt > 0:
        for i in range(1, diff_monate_gesamt + 1):
            nextMonthArrow.click()

    if diff_monate_gesamt < 0:
        for i in range(1, (diff_monate_gesamt * - 1) + 1):
            previousMonthArrow.click()

    #Element muss neu eingelesen werden
    theMonthView = search_element("//android.view.View[@resource-id='android:id/month_view']")
    theMonthView.find_element(AppiumBy.XPATH, "//android.view.View[@text='" + str(tag) + "']").click()
    theSetButton.click()

def monat_als_zahl(monatsname):
    monate = {monat.lower(): index for index, monat in enumerate(calendar.month_name) if monat}
    return monate.get(monatsname.lower(), "Ungültiger Monat")
