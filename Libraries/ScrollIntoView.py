#ToDo das funktioniert nicht, vermutlich Versionsproblematiken
from robot.api.logger import console
from selenium.common import NoSuchElementException
from selenium.webdriver import Keys
from appium.webdriver.common.appiumby import AppiumBy
from appium.webdriver.common.touch_action import TouchAction
from win32api import mouse_event
from PIL import Image

def checkbox_experiments(url):
    driver = open_session(url)

    #webelement = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,"new UiSelector().className('android.widget.CheckBox').instance(0)")
    #webelement.click()

    #RowTeilnahmeAmTraining = driver.find_element(AppiumBy.CLASS_NAME, "android.widget.CheckBox")
    RowTeilnahmeAmTraining = driver.find_element(AppiumBy.XPATH,
                                     "//android.view.View[@text='Typ: Teilnahme am Training?']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox")
    RowTeilnahmeAmTraining.click()
    print(RowTeilnahmeAmTraining.get_dom_attribute("checked"))
    print(RowTeilnahmeAmTraining.get_dom_attribute("displayed"))

    RowTeilnahmeAmTraining.screenshot("checkboxStateActual.png")
    checkboxStateChecked =  Image.open("checkboxStateChecked_57_57.png")
    checkboxStateActual = Image.open("checkboxStateActual.png")

    if checkboxStateChecked == checkboxStateActual:
        print("Checkbox checked")
    else:
        print("Checkbox unchecked")

    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)

    #driver.execute_script("window.scrollBy(0, 850)")
    #driver.execute_script("window.scrollTo(0, 0)")
    #webelement = driver.find_element(AppiumBy.XPATH, "//android.view.View[@text='Typ: Teilnahme am Training?']/parent::*/android.view.View[@text='📱 App:']/android.widget.CheckBox")
    #webelement = driver.find_element(AppiumBy.XPATH, "//android.widget.CheckBox")
    #webelement = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, "new UiSelector().className('android.widget.CheckBox').instance(0)")
    #webelement.click()
    #RowTeilnahmeAmTraining = driver.find_element(AppiumBy.XPATH, "//android.view.View[@text='Typ: Teilnahme am Training?']")
    #RowTeilnahmeAmTraining = driver.find_element(AppiumBy.CLASS_NAME, "android.widget.CheckBox")
    #print(RowTeilnahmeAmTraining.text)

    driver.switch_to.context(driver.contexts[0])


def scroll_into_view(url="http://192.168.2.224:4723", session_id="111", xpath="//android.widget.Button[@text='Speichern']"):
    print("url = " + url, flush=True)
    print("session_id = " + session_id)
    print("xpath = " + xpath)
    #from appium import webdriver
    from selenium.webdriver.common.by import By
    from appium.webdriver.common.appiumby import AppiumBy
    from appium.webdriver.common.touch_action import TouchAction

    #driver = attach_to_session(url, session_id)
    driver = open_session(url)

    print(driver.session_id)
    print(driver.contexts)
    print(driver.context)

    #xpath = "//android.view.View[@text='Typ: Teilnahme am Training?']"
    #element = driver.find_element(By.XPATH, xpath)
    #print(element.location)

    #xpath = "//android.view.View[@text='Typ: Terminumfrage für Spielverlegung']"
    #element2 = driver.find_element(By.XPATH, xpath)
    #print(element2.location)

    #driver.execute_script('window.scrollTo(0,1000)')

    # not working
    from appium.webdriver.common.touch_action import TouchAction
    # Assuming 'driver' is your Appium driver instance
    action = TouchAction(driver)
    action.press(x=0, y=500).move_to(x=0, y=3000)
    action.move_to(x=500, y=3000)

    #element = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Speichern"));')
    try:
        #element1 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Erinnerung an Spieltermin"));')
        print("element1 übersprungen")
    except NoSuchElementException:
        print("element1 - ominös!")

    try:
        #element2 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Benachrichtigung bei Trainingsausfall"));')
        print("element2 übersprungen")
    except NoSuchElementException:
        print("element2 - ominös!")


    butElement = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,
                                     'new UiScrollable(new UiSelector().text("Benachrichtigungen | TT-Planer").scrollable(true)).setMaxSearchSwipes(50).scrollIntoView(new UiSelector().text("Speichern"));')
    print(butElement.location)


    # Definiere den UiScrollable für den WebView
    #scrollable = driver.find_element_by_android_uiautomator(
    #    'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().className("android.webkit.WebView"))'
    #)

    # Wechsel in den Kontext des WebView
    #driver.switch_to.context('WEBVIEW_chrome')
    # Suche nach dem Button in der nicht scrollbaren Ansicht
    #button = driver.find_element(AppiumBy.XPATH, '//android.widget.Button[@text="Speichern"]')
    # Aktion auf dem gefundenen Button durchführen, z.B. klicken
    #button.click()


    try:
        #element3 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().xpath("//android.widget.EditText[@resource-id="reminder_games_hours"]"))')
        element3 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).setAsVerticalList().scrollIntoView(new UiSelector().resourceId("reminder_games_hours"))')
        print(element3.location)
    except NoSuchElementException:
        print("element3 - ominös!")
    except Exception as inst:
        print(type(inst))  # the exception type
        print(inst.args)  # arguments stored in .args
        print(inst)  # __str__ allows args to be printed directly,
        # but may be overridden in exception subclasses
        x, y = inst.args  # unpack args
        print('x =', x)
        print('y =', y)
    finally:
        print(element3.location)
        element3.click()

    try:
        element4 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).setMaxSearchSwipes(10).scrollIntoView(new UiSelector().text("Benachrichtigung bei Trainingsausfall"));')
        print(element4.location)
    except NoSuchElementException:
        print("element4 - ominös!")
    except:
        print("Something else went wrong")
    finally:
        print(element4.location)
        element4.click()

    try:
        element5 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).setMaxSearchSwipes(10).scrollIntoView(new UiSelector().text("Speichern"));')
        print(element5.location)
    except NoSuchElementException:
        print("element5 - ominös!")
    except:
        print("Something else went wrong")
    finally:
        print(element5.location)
        element5.click()

    #theButton = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().text("Speichern");')
    #theButton.click()

    #driver.execute_script('window.scrollTo(0,1000)')


def using_keys(url):
    from appium.webdriver.common.appiumby import AppiumBy

    driver = open_session(url)

    dieApp = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,
                                 'new UiScrollable(new UiSelector().scrollable(true)).setAsVerticalList().scrollIntoView(new UiSelector().text("Benachrichtigungen | TT-Planer"))')
    print(dieApp.location)
    print(dieApp.get_attribute("bounds"))
    print(dieApp.text)
    #print(dieApp.accessible_name)
    print(dieApp.id)

    #dieApp.click()
    #dieApp.send_keys(Keys.ARROW_RIGHT)
    dieApp.send_keys(Keys.ARROW_DOWN)
    dieApp.send_keys(Keys.ARROW_DOWN)

    control_found = False
    retryCount = 1
    max_retry = 5
    while not control_found:
        try:
            derButton = dieApp.find_element(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().text("Speichern")')
        except NoSuchElementException:
            print("Element not found yet");
            #print(derButton)
            dieApp.click()
            dieApp.send_keys(Keys.ARROW_DOWN)
            #if derButton == n
        retryCount += 1
        if retryCount > max_retry:
            break

    #dieApp.send_keys(Keys.ARROW_RIGHT)
    dieApp.send_keys(Keys.ARROW_DOWN)
    dieApp.send_keys(Keys.ARROW_DOWN)

    derButton = dieApp.find_element(AppiumBy.ANDROID_UIAUTOMATOR, 'new UiSelector().text("Speichern")')
    print(derButton.location)

def tap_experiments(url):
    driver = open_session(url)
    from appium.webdriver.common.touch_action import TouchAction
    # Assuming 'driver' is your Appium driver instance
    action = TouchAction(driver)
    action.press(x=0, y=500).move_to(x=0, y=3000)
    action.move_to(x=500, y=3000)

def scroll_experiments(url):
    driver = open_session(url)
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    #driver.execute_script("window.scrollBy(0, 850)")
    driver.execute_script("window.scrollTo(0, 0)")
    #driver.get_screenshot_as_png()
    #driver.execute_script("window.scrollBy(0, 1200)")
    #driver.get_screenshot_as_png()
    driver.switch_to.context(driver.contexts[0])

def scroll_to_top(url):
    driver = open_session(url)
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    #driver.execute_script("window.scrollBy(0, 850)")
    driver.execute_script("window.scrollTo(0, 0)")
    #driver.get_screenshot_as_png()
    #driver.execute_script("window.scrollBy(0, 1200)")
    #driver.get_screenshot_as_png()
    driver.switch_to.context(driver.contexts[0])

def scroll_page_down(url):
    driver = open_session(url)
    driver.switch_to.context(driver.contexts[1])
    print(driver.current_context)
    driver.execute_script("window.scrollBy(0, 850)")
    #driver.execute_script("window.scrollTo(0, 0)")
    #driver.get_screenshot_as_png()
    #driver.execute_script("window.scrollBy(0, 1200)")
    #driver.get_screenshot_as_png()
    driver.switch_to.context(driver.contexts[0])

def open_session(executor_url):
    from appium import webdriver
    from appium.options.android import UiAutomator2Options

    options = UiAutomator2Options()
    options.platformName = 'Android'
    options.deviceName = 'emulator-5554'
    options.appPackage = 'org.chromium.webapk.a62c68cebaf69977d_v2'
    options.appActivity = 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity'
    options.noReset = True  # Setze noReset explizit auf True

    #driver = webdriver.Remote('http://192.168.2.224:4723/wd/hub', True, True, None, True, options)
    #driver = webdriver.Remote('http://192.168.2.224:4723', True, True, None, True, options)
    driver = webdriver.Remote('http://192.168.2.224:4723', True, True, None, True, options)

    return driver

def attach_to_session(executor_url, session_id):
    from selenium.webdriver.remote.webdriver import WebDriver
    from selenium.webdriver.remote.command import Command
    from selenium.webdriver.remote.remote_connection import RemoteConnection

    # Erstellen Sie den Befehlsausführer
    command_executor = RemoteConnection(executor_url, keep_alive=True)

    # Erstellen Sie eine WebDriver-Instanz
    driver = WebDriver(command_executor, {})

    # Zuweisen der Sitzung-ID
    driver.session_id = session_id

    def get_existing_session(self):
        return self.execute(Command.STATUS)

    # Weisen Sie die Methode get_existing_session der WebDriver-Instanz zu
    driver.get_existing_session = get_existing_session.__get__(driver, WebDriver)

    return driver

def old3_attach_to_session(executor_url, session_id):
    from appium.webdriver.webdriver import WebDriver
    from selenium.webdriver.remote.remote_connection import RemoteConnection

    # Create the command executor
    command_executor = RemoteConnection(executor_url, keep_alive=True)

    # Create a WebDriver instance without desired capabilities
    driver = WebDriver(command_executor, None)

    # Attach to an existing session
    driver.session_id = session_id

    return driver


def old2_attach_to_session(executor_url, session_id):
    from appium.webdriver.webdriver import WebDriver
    from selenium.webdriver.remote.remote_connection import RemoteConnection

    # Create the command executor
    command_executor = RemoteConnection(executor_url, keep_alive=True)

    # Define a new instance of WebDriver without desired capabilities
    driver = WebDriver(command_executor, {})

    # Attach to an existing session
    driver.session_id = session_id

    return driver

def old_attach_to_session(url, session_id):
    from appium.webdriver.webdriver import WebDriver
    from selenium.webdriver.remote.remote_connection import RemoteConnection

    original_execute = WebDriver.execute
    command_executor = RemoteConnection(url, keep_alive=True)

    def new_command_execute(self, command, params=None):
        if command == "newSession":
            return {'status': 0, 'value': None, 'sessionId': session_id}
        else:
            return original_execute(self, command, params)

    WebDriver.execute = new_command_execute
    driver = WebDriver(command_executor=command_executor, desired_capabilities={})
    driver.session_id = session_id
    WebDriver.execute = original_execute
    return driver