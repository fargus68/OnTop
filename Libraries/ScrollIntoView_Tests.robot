*** Settings ***
Library    AppiumLibrary
Library    Collections
Library    String
Library    ScrollIntoView.py

*** Keywords ***
Open Application TT-Planer pn Google Pixel 9
    Open Application    http://127.0.0.1:4723
    ...                 platformName=Android
    ...                 deviceName=emulator-5554
    ...                 appPackage=org.chromium.webapk.a62c68cebaf69977d_v2
    ...                 appActivity=org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity
    ...                 automationName=UIAutomator2
    ...                 noReset=true
    ...                 nativeWebScreenshot=true
    ...                 newCommandTimeout=3600
    #...                 connectHardwareKeyboard=true

*** Test Cases ***
Test scroll_into_view
    Open Application TT-Planer pn Google Pixel 9
    ${session-id}=    Get Appium SessionId
    ${full-url}=    Catenate    SEPARATOR=    http://127.0.0.1:4723/session/    ${session-id}
    ${xpath}=    Convert To String    //android.widget.Button[@text="Speichern"]
    scroll_into_view    ${full-url}    ${xpath}


