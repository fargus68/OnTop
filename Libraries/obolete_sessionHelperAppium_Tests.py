from time import sleep

from sessionHelperAppium import get_appium_sessions
from sessionHelperAppium import open_session
from sessionHelperAppium import close_all_appium_sessions

#import Mobile_Mgmt_Direct


print(get_appium_sessions())
open_session()
open_session()
open_session()
print("Appium-Sessions = " + str(get_appium_sessions()))
close_all_appium_sessions()
sleep(1)
print("Appium-Sessions = " + str(get_appium_sessions()))
sleep(10)
print("Appium-Sessions = " + str(get_appium_sessions()))