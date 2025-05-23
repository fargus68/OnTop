*** Settings ***
#Library    AppiumLibrary
Library    Collections
Library    String
Library    ScrollIntoView_Direct.py
Library    Resources/Utils/DriverSingletonAdapter.py    WITH NAME    Mobile_Mgmt
Resource    Resources/Utils/Mobile_Mgmt.resource

*** Keywords ***

*** Test Cases ***
Test scroll_into_view
    Mobile_Mgmt.Open Application Tt Planer On Google Pixel 9
    ${session-id}=    Mobile_Mgmt.Get Session Id
    ${full-url}=    Catenate    SEPARATOR=    http://127.0.0.1:4723/session/    ${session-id}
    ${xpath}=    Convert To String    //android.widget.Button[@text="Speichern"]
    #swipe by percent    50     50     50    70    100
    #swipe   100    700    100    3500    100
    #scroll_into_view    ${full-url}    ${session-id}    ${xpath}

Test scroll_into_view
    Mobile_Mgmt.Open Application Tt Planer On Google Pixel 9
    ${session-id}=    Mobile_Mgmt.Get Session Id
    ${full-url}=    Catenate    SEPARATOR=    http://127.0.0.1:4723/session/    ${session-id}
    ${xpath}=    Convert To String    //android.widget.Button[@text="Speichern"]
    #swipe by percent    50     50     50    70    100
    #swipe   100    700    100    3500    100
    #Scroll Page Down    ${full-url}    ${session-id}    ${xpath}

Test scroll to the top
    Setup AUT Pixel9Pro_API35 NoWaitForLoginScreen
    #Mobile_Mgmt.Open Application Tt Planer On Google Pixel 9
    #${driver}=    Mobile_Mgmt.Get Driver
    #Mobile_Mgmt.Get Session Id
    #Mobile_Mgmt.Get Session Info
    #Scroll To Top    ${driver}
    Scroll To Top    dummy

