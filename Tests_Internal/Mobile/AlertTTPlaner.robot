*** Settings ***
Library    AppiumLibrary
Library    Collections
Library    ../../Libraries/PasswordSafe.py
#Library    SeleniumLibrary

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
Get alert error entries
    Open Application TT-Planer pn Google Pixel 9
    Wait Until Element Is Visible    xpath=//android.widget.ListView

    @{ActualErrorElements}=    AppiumLibrary.Get WebElements    xpath=//android.widget.ListView//android.view.View//android.widget.TextView
    ${CopyActualErrorElements}=    Create List    @{ActualErrorElements}
    ${CountActualErrorElements}=    Get Length    ${CopyActualErrorElements}

    FOR    ${element}    IN    @{ActualErrorElements}
        ${text}    Get Element Attribute    ${element}    text
        Log    Listeneintrag: ${text}
    END


