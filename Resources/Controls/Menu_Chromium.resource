*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Menu specific get text
    [Arguments]    ${Selector}
    ${MenuContent}=    Browser.Get Text    ${Selector}
    RETURN    ${MenuContent}

Menu specific click
    [Arguments]    ${Selector}
    Browser.Click    ${Selector}