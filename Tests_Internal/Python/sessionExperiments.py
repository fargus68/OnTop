import appium.webdriver.appium_service

import Resources.Utils.DriverSingletonAdapter
import uiautomator2 as u2
from appium.webdriver.common.appiumby import AppiumBy

from appium.common.helper import appium_version

from DriverSingleton import DriverSingleton

d = u2.connect('emulator-5554') # alias for u2.connect_usb('123456f')
print("info = " + str(d.info))
print("app_current = " + d.app_current()['package'])
package_name = str(d.app_current()['package'])
print("app_info = " + str(d.app_info(package_name)))
#d.stop_uiautomator()
print("adb_device.info = " + str(d.adb_device.info))
#d.reset_uiautomator()

#print("Appium status = " + appium.webdriver.appium_service.STATUS_URL)

# Create a singleton instance
_singleton = DriverSingleton()

#driver = _singleton.get_driver_for_first_session()
driver = _singleton.get_driver()
print("driver = " + str(driver))

if driver is None:
    try:
        driver = _singleton.open_application_tt_planer_on_google_pixel_9()
    except Exception as e:
        print("Error opening application: " + str(e))
        #d.reset_uiautomator()
        d.start_uiautomator()
        d.adb_device.reboot()
        driver = _singleton.open_application_tt_planer_on_google_pixel_9()
