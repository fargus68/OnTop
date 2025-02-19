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

Choose Person to chat with
    [Arguments]    ${NameOfPerson}
    Open Application TT-Planer pn Google Pixel 9
    Click Element    xpath=//android.widget.Spinner
    Wait Until Element Is Visible    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    Click Element    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    Input Text Into Current Element    ${NameOfPerson}
    Sleep    1s
    Long Press Keycode    66    #${KEYCODE_ENTER}
    Click Element    xpath=//android.widget.Spinner

*** Test Cases ***
Open Personal Chat Menu
    Open Application TT-Planer pn Google Pixel 9
    Click Element    xpath=//android.widget.TextView[@text=""]
    Open Application TT-Planer pn Google Pixel 9
    #Click Element    xpath=//android.webkit.WebView[@text="Übersicht | TT-Planer"]/android.view.View[1]/android.widget.ListView/android.view.View[3]
    Click Element    xpath=//android.view.View[@content-desc=" Chat 0"]
    Open Application TT-Planer pn Google Pixel 9
    #Click Element    xpath=//android.webkit.WebView[@text="Übersicht | TT-Planer"]/android.view.View[1]/android.widget.ListView/android.view.View[3]/android.widget.ListView/android.view.View[@content-desc="Persönlich 0"]
    Click Element    xpath=//android.view.View[@content-desc="Persönlich 0"]

Choose Mitglied to chat with
    Choose Person to chat with    Testaccount-Mitglied

Choose Person to chat with
    Open Application TT-Planer pn Google Pixel 9
    Click Element    xpath=//android.widget.Spinner
    Wait Until Element Is Visible    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    Input Text    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText    Testaccount-Mitglied
    Sleep    1s
    Press Keycode    66    #${KEYCODE_ENTER}
    
Choose Gast to chat with
    Open Application TT-Planer pn Google Pixel 9
    Click Element    xpath=//android.widget.Spinner
    Wait Until Element Is Visible    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    Click Element    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    #Input Text    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText    Testaccount-Gast
    Input Text Into Current Element    Testaccount-Gast
    Sleep    1s
    Long Press Keycode    66    #${KEYCODE_ENTER}
    Click Element    xpath=//android.widget.Spinner

Choose Marc Zander to chat with
    Open Application TT-Planer pn Google Pixel 9
    #${CurrentContext}    Get Current Context
    #Log    ${CurrentContext}
    Click Element    xpath=//android.widget.Spinner
    Wait Until Element Is Visible    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    Click Element    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    #Input Text    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText    Marc Zander
    Input Text Into Current Element    Marc Zander
    Sleep    1s
    #Click Element    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]/android.widget.EditText
    Long Press Keycode    66    #${KEYCODE_ENTER}
    #Long Press Keycode    61    #${KEYCODE_TAB}
    Click Element    xpath=//android.widget.Spinner

Check Accessability name
    Open Application TT-Planer pn Google Pixel 9
    ${Liste}=    AppiumLibrary.Get Webelement   //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]
    Log    ${Liste}.accessible_name

    #${ELEMENTS}    AppiumLibrary.Get WebElements    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View/android.view.View[4]
    ${ELEMENTS}    AppiumLibrary.Get WebElements    //android.webkit.WebView[@text="Chat - Persönlich | TT-Planer"]/android.view.View
    ${ELEMENT}    Get From List    ${ELEMENTS}    0    #${INDEX}
    #Log    Get Text    ${ELEMENT}
    #Log    ${ELEMENT}

    ${CONTEXTS}    Get Contexts
    Log    Available contexts: ${CONTEXTS}

    Open Application TT-Planer pn Google Pixel 9
    #Sleep    10s
    Switch To Context    WEBVIEW_chrome    #_org.chromium.webapk.a62c68cebaf69977d_v2
    Sleep    10s

    Execute JavaScript    return document.readyState
    Log    Document ready state: ${DOCUMENT_READY_STATE}

    #Execute JavaScript    document.querySelectorAll('._highlighter-box_88g86_381').forEach(element => element.style.display = 'block')
    ${ELEMENT}=    Find Element    xpath=//android.view.View[@class='_highlighter-box_88g86_381']
    Log    Found element: ${ELEMENT}

Login Admin TTPlaner On pixel 9 Emulator
    Open Application TT-Planer pn Google Pixel 9
    Input Text    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.de
    ${Value}=    read_password
    Input Text    xpath=//*[@hint='PASSWORT:']    ${Value}
    Click Button    Einloggen

Login Gast TTPlaner On pixel 9 Emulator
    Open Application TT-Planer pn Google Pixel 9
    Input Text    xpath=//*[@hint='E-MAIL ADRESSE:']    info@matthias-schmotz.de
    ${Value}=    read_password
    Input Text    xpath=//*[@hint='PASSWORT:']    ${Value}
    Click Button    Einloggen

Login Mitglied TTPlaner On pixel 9 Emulator
    Open Application TT-Planer pn Google Pixel 9
    Input Text    xpath=//*[@hint='E-MAIL ADRESSE:']    matthias@matthias-schmotz.eu
    ${Value}=    read_password
    Input Text    xpath=//*[@hint='PASSWORT:']    ${Value}
    Click Button    Einloggen

Login Trainer TTPlaner On pixel 9 Emulator
    Open Application TT-Planer pn Google Pixel 9
    Input Text    xpath=//*[@hint='E-MAIL ADRESSE:']    funtestic@matthias-schmotz.de
    ${Value}=    read_password
    Input Text    xpath=//*[@hint='PASSWORT:']    ${Value}
    Click Button    Einloggen