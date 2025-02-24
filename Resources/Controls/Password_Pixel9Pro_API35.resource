*** Settings ***
Library    AppiumLibrary
Library    String

*** Variables ***

*** Keywords ***
Password specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    Get Text    ${Selector}
    RETURN    ${TextboxContent}

Password specific set text
    [Arguments]    ${Selector}    ${Value}
    Input Text    ${Selector}    ${Value}