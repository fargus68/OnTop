from time import sleep

from sessionHelperAppium import get_appium_sessions
from sessionHelperAppium import open_session
from sessionHelperAppium import close_all_appium_sessions

print(get_appium_sessions())
open_session()
open_session()
open_session()
print(get_appium_sessions())
close_all_appium_sessions()
sleep(1)
print(get_appium_sessions())