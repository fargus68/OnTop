*** Settings ***
Library    Browser
Library    String

*** Variables ***

*** Keywords ***
Label specific get text
    [Arguments]    ${Selector}
    ${LabelContent}=    Browser.Get Text    ${Selector}
    RETURN    ${LabelContent}