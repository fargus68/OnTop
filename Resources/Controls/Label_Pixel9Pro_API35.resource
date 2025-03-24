*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Label specific get text
    [Arguments]    ${Selector}
    ${LabelContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${LabelContent}