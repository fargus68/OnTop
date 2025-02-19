*** Settings ***
Library    AppiumLibrary
Library    ../../Libraries/PasswordSafe.py

*** Keywords ***
Open Application TT-Planer pn Google Pixel 9
    Open Application    http://127.0.0.1:4723
    ...                 platformName=Android
    ...                 deviceName=emulator-5554
    ...                 appPackage=org.chromium.webapk.a62c68cebaf69977d_v2
    ...                 appActivity=org.chromium.webapk.shell_apk.h2o.H2OOpaqueMainActivity
    ...                 automationName=UIAutomator2
    ...                 noReset=true

*** Test Cases ***
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