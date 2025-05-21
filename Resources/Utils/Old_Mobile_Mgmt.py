from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from Libraries.ScrollIntoView import scroll_to_top

def wait_until_login_screen_is_ready():
    """Wait until the login screen is ready and handle any necessary actions."""
    appium_lib = BuiltIn().get_library_instance('AppiumLibrary')

    # Try to scroll to top (ignore errors)
    try:
        scroll_to_top()
    except:
        pass

    # Check for close button and click if present
    try:
        appium_lib.wait_until_element_is_visible('xpath=//android.widget.TextView[@text=""]', timeout='10s')
        appium_lib.click_element('xpath=//android.widget.TextView[@text=""]')
    except:
        pass

    # Check for login button
    try:
        appium_lib.wait_until_element_is_visible('xpath=//android.widget.Button[@text="Einloggen"]', timeout='10s')
    except:
        # If login button not found, restart the application
        restart_application()


def restart_application():
    """Restart the application and wait for the login screen."""
    appium_lib = BuiltIn().get_library_instance('AppiumLibrary')
    appium_lib.close_application()
    open_application_tt_planer_on_google_pixel_9()
    appium_lib.wait_until_element_is_visible('xpath=//android.widget.Button[@text="Einloggen"]', timeout='10s')

def open_application_tt_planer_on_google_pixel_9_with_reset():
    """Open the TT-Planer application with reset."""
    appium_lib = BuiltIn().get_library_instance('AppiumLibrary')
    app_id = appium_lib.open_application(
        "http://192.168.2.224:4723",
        platformName="Android",
        deviceName="emulator-5554",
        appPackage="org.chromium.webapk.a62c68cebaf69977d_v2",
        appActivity="org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity",
        automationName="UIAutomator2",
        noReset="false"
    )
    logger.info(app_id)

def open_application_tt_planer_on_google_pixel_9():
    """Open the TT-Planer application without reset."""
    appium_lib = BuiltIn().get_library_instance('AppiumLibrary')
    appium_lib.open_application(
        "http://192.168.2.224:4723",
        platformName="Android",
        deviceName="emulator-5554",
        appPackage="org.chromium.webapk.a62c68cebaf69977d_v2",
        appActivity="org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity",
        automationName="UIAutomator2",
        noReset="true"
    )