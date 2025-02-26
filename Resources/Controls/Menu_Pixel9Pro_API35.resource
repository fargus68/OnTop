*** Settings ***
Library    String
Library    AppiumLibrary

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
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.TextView[@text=""]
    AppiumLibrary.Click Element    xpath=//android.widget.TextView[@text=""]
    Capture Page Screenshot
    AppiumLibrary.Wait Until Element Is Visible    ${Selector}
    Capture Page Screenshot
    AppiumLibrary.Click Element    ${Selector}