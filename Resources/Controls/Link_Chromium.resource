*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Link specific get text
    [Arguments]    ${Selector}
    ${LinkContent}=    Get Text    ${Selector}
    RETURN    ${LinkContent}

Link specific click
    [Arguments]    ${Selector}
    Click    ${Selector}