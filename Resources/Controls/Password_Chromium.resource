*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Password specific get text
    [Arguments]    ${Selector}
    ${TextboxContent}=    Get Text    ${Selector}
    RETURN    ${TextboxContent}

Password specific set text
    [Arguments]    ${Selector}    ${Value}
    Type Text    ${Selector}    ${Value}    0.01    False