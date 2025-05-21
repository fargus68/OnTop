from Resources.Utils.DriverSingletonAdapter import open_session
import uiautomator2 as u2
from appium.webdriver.common.appiumby import AppiumBy

#d = u2.connect('emulator-5554') # alias for u2.connect_usb('123456f')
#print(d.info)
#d.stop_uiautomator()

driver = open_session()

#driver.execute_script("mobile: scroll", {'direction': 'down'})

#print(driver.execute_script('mobile:getDeviceInfo'))

element_id = driver.find_element(AppiumBy.XPATH, "//android.webkit.WebView[@text='Benachrichtigungen | TT-Planer']").id
print(element_id)

result = driver.execute_script('mobile: scroll', {
    'elementId': element_id,
    'strategy': '-android uiautomator',
    'selector': 'new UiSelector().resourceId("select2-training_ids-container")',
    'maxSwipes': 5
})

print(result)
