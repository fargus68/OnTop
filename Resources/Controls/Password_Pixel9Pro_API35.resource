*** Settings ***
Library    AppiumLibrary
Library    String

*** Variables ***

*** Keywords ***
Password specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${TextboxContent}

Password specific set text
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Input Text    ${Selector}    ${Value}