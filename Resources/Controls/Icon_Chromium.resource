*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Icon specific get text
    [Arguments]    ${Selector}
    ${IconContent}=    Get Text    ${Selector}
    RETURN    ${IconContent}

Icon specific click
    [Arguments]    ${Selector}
    Click    ${Selector}