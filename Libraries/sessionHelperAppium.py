from appium import webdriver

def open_session():
    #from appium import webdriver
    from appium.options.android import UiAutomator2Options
    options = UiAutomator2Options()
    options.platformName = 'Android'
    options.deviceName = 'emulator-5554'
    options.appPackage = 'org.chromium.webapk.a62c68cebaf69977d_v2'
    options.appActivity = 'org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity'
    options.noReset = True  # Setze noReset explizit auf True
    driver = webdriver.Remote('http://192.168.2.224:4723', True, True, None, True, options)
    #set current_driver = driver
    return driver

#glob current_driver : webdriver

#def get_current_session():
#    return current_driver


