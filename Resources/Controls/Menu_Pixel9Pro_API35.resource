*** Settings ***
Library    String
Library    AppiumLibrary
Library    ../../Libraries/sessionHelperAppium.py
Library    ../../Libraries/ScrollIntoView.py
Resource    ../../Resources/Utils/Mobile_Mgmt.resource

*** Variables ***

*** Keywords ***
Menu specific get text
    [Arguments]    ${Selector}
    ${MenuContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${MenuContent}

Menu specific click
    [Arguments]    ${Selector}
    #AppiumLibrary.Click Element    //android.webkit.WebView/android.view.View[1]//android.widget.TextView[@text=""]
    #AppiumLibrary.Click Element    xpath=//android.widget.Spinner

    BuiltIn.Sleep    1s

    ${result} =    Run Keyword And Ignore Error    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.TextView[@text=""]
    Run Keyword If    '${result}[0]' == 'FAIL'    scroll_to_top
    #Run Keyword If    '${result}[0]' == 'FAIL'    Sleep    2s
    #Run Keyword If    '${result}[0]' == 'FAIL'    sessionHelperAppium.Open Session
    #Run Keyword If    '${result}[0]' == 'FAIL'    Sleep    2s
    #Open Application TT-Planer on Google Pixel 9
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.TextView[@text=""]
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@text=""]
    Capture Page Screenshot
    AppiumLibrary.Wait Until Element Is Visible    ${Selector}
    Capture Page Screenshot
    AppiumLibrary.Click Element    ${Selector}