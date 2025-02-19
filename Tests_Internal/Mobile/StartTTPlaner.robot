*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem
Library    Process

#appium must be started with this command:
#appium —-base-path /wd/hub
#appium —-base-path /wd/hub --allow-insecure chromedriver_autodownload

*** Variables ***
${APPIUM_COMMAND}    appium --base-path /wd/hub
${COMMAND_PROMPT}    cmd
#${BATCH_FILE}    ../../Batch/Start_Appium_Server.bat
${BATCH_FILE_START_APPIUM_SERVER}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server.bat
${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server_NoBasePathArg.bat
${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Appium_Server_NoBasePathArg_AllowDwnload.bat
${BATCH_FILE_START_EMULATOR}    C:\\Users\\matth\\PycharmProjects\\OnTop\\Batch\\Start_Emulator.bat

*** Keywords ***
Appium_Start
    Run Process    ${BATCH_FILE_START_APPIUM_SERVER}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Appium Server gestartet

Emulator_Start
    [Arguments]    ${EmulatorName}
    Run Process    ${BATCH_FILE_START_EMULATOR}    ${EmulatorName}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Emulator gestartet

*** Test Cases ***
Open TTPlaner On pixel 9 Emulator
    #start emulator by command "emulator -avd Pixel9Pro_API35"
    Appium_Start
    Emulator_Start    Pixel9Pro_API35

    Sleep    5s

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

Only Appium Start
    Appium_Start

Only Emulator Start
    Emulator_Start    Pixel9Pro_API35

Appium_Start_NoBasePathArg
    Run Process    ${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Appium Server gestartet

Appium_Start_NoBasePathArg_AllowDownloadInsecureChromeDriver
    Run Process    ${BATCH_FILE_START_APPIUM_SERVER_NOBASEPATHARG_ALLOWDOWNLOADINSECURECHROMEDRIVER}    shell=True    stdout=stdout.txt    stderr=stderr.txt
    Log    Appium Server gestartet

