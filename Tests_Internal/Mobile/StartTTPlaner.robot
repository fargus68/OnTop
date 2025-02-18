*** Settings ***
Library    AppiumLibrary

#appium must be started with this command:
#appium —-base-path /wd/hub
#appium —-base-path /wd/hub --allow-insecure chromedriver_autodownload

*** Test Cases ***
Open TTPlaner On pixel 9 Emulator
    #start emulator by command "emulator -avd Pixel9Pro_API35"

    #Open Application    http://127.0.0.1:4723/wd/hub
    Open Application    http://192.168.2.224:4723/wd/hub
    ...                 platformName=Android
    ...                 deviceName=emulator-5554
    ...                 appPackage=org.chromium.webapk.a62c68cebaf69977d_v2
    ...                 appActivity=org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity
    ...                 automationName=UIAutomator2
    ...                 noReset=true

    #...                 appPackage=com.android.egg
    #...                 appActivity=com.android.egg.landroid.MainActivity
    #...                 automationName=UIAutomator2




    # http://127.0.0.1:4723/wd/hub
    # http://192.168.2.224:4723/wd/hub

    #TTPlaner - App activities
    #org.chromium.webapk.shell_apk.h2o.H2OTransparentLauncherActivity
    #org.chromium.webapk.shell_apk.ManageDataLauncherActivity - TT-Planer
    #org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity - TT-Planer
    #org.chromium.webapk.shell_apk.h2o.SplashActivity - TT-Planer
    #org.chromium.webapk.shell_apk.NotificationPermissionRequestActivity - TT-Planer
    #org.chromium.webapk.shell_apk.WebApkServiceFactory - TT-Planer
    #org.chromium.webapk.shell_apk.IdentityService - TT-Planer

    #Open Application    http://192.168.2.224:4723/wd/hub
    #...                 platformName=Android
    #...                 deviceName=emulator-5554
    #...                 appPackage=org.mozilla.firefox
    #...                 appActivity=org.mozilla.firefox.App
    #...                 automationName=UIAutomator2