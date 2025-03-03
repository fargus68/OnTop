#ToDo das funktioniert nicht, vermutlich Versionsproblematiken
from robot.api.logger import console
from selenium.common import NoSuchElementException


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

    xpath = "//android.view.View[@text='Typ: Teilnahme am Training?']"
    element = driver.find_element(By.XPATH, xpath)
    print(element.location)

    xpath = "//android.view.View[@text='Typ: Terminumfrage für Spielverlegung']"
    element2 = driver.find_element(By.XPATH, xpath)
    print(element2.location)


    #element = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Speichern"));')
    try:
        element1 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Erinnerung an Spieltermin"));')
    except NoSuchElementException:
        print("Ominös!")

    try:
        element2 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Benachrichtigung bei Trainingsausfall"));')
    except NoSuchElementException:
        print("Ominös!")

    try:
        element3 = driver.find_element(AppiumBy.ANDROID_UIAUTOMATOR,'new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("Speichern"));')
        print(element3.location)
    except NoSuchElementException:
        print("Ominös!")
    except:
        print("Something else went wrong")

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