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

Get Web Element
    [Arguments]    ${Selector}


*** Test Cases ***
Checking attributes
    Open Application TT-Planer pn Google Pixel 9
    Get Contexts
    Switch To Context    WEBVIEW_chrome
    #AppiumLibrary.Get Webelement    xpath=//android.view.View[@content-desc=" Profil"]
    ${Element}=    AppiumLibrary.Get Webelement    xpath=//*    #xpath=//android.view.View[@content-desc=" Profil"]
    AppiumLibrary.Get Element Attribute    ${Element}    elementId
    AppiumLibrary.Get Element Attribute    ${Element}    accessibility id
    @{ListOfWebElements}=    AppiumLibrary.Get Webelements    xpath=//*
    ${theListOfWebElements}=    Create List    @{ListOfWebElements}    
    Log Many    ${theListOfWebElements}
    FOR    ${Element}    IN    @{ListOfWebElements}
        #AppiumLibrary.Get Element Attribute    ${Element}    accessibility id
        ${AttrValue}=    AppiumLibrary.Get Element Attribute    ${Element}    text
        IF    ${AttrValue} != None
            Fail
        END
    END

Check xpath
    Open Application TT-Planer pn Google Pixel 9
    Get Text    //android.view.View[@content-desc=" Profil"]/android.widget.TextView[@text="Profil"]
    Get Text    //android.widget.TextView[@text="Benachrichtigungen"]
    Get Text    //android.view.View[@content-desc=" Benachrichtigungen"]
    Get Text    //android.view.View[@content-desc=" Benachrichtigungen"]
    Get Text    //android.view.View[@content-desc=" Benachrichtigungen"]/android.widget.TextView[@text="Benachrichtigungen"]
    Get Text    //android.view.View[@content-desc=" Abwesenheiten"]/android.widget.TextView[@text="Abwesenheiten"]
    
Check xpath2
    Open Application TT-Planer pn Google Pixel 9
    Get Element Attribute    //android.view.View[@text="Typ: Teilnahme am Training?"]/parent::*/android.view.View[@text="📱 App:"]/android.widget.CheckBox    checked
    #Scroll Element Into View
    Capture Page Screenshot

Click Benachrichtigungen
    Open Application TT-Planer pn Google Pixel 9
    #Click Element    //android.view.View[@content-desc=" Benachrichtigungen"]/android.widget.TextView[@text="Benachrichtigungen"]
    #AppiumLibrary.Scroll Element Into View   //android.widget.ListView[@resource-id="select2-training_ids-container"]
    #Get Text    //android.widget.ListView[@resource-id="select2-training_ids-container"]
    Scroll Element Into View    //android.webkit.WebView[@text="Benachrichtigungen | TT-Planer"]/android.view.View/android.view.View/android.view.View[1]/android.view.View[3]
    Element Should Be Visible    //android.widget.Button[@text="Speichern"]
    Click Element    //android.widget.Button[@text="Speichern"]
    Scroll Element Into View    //android.widget.Button[@text="Speichern"]

