*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Link specific get text
    #ToDo not tested yet
    [Arguments]    ${Selector}
    ${LinkContent}=    Get Text    ${Selector}
    RETURN    ${LinkContent}

Link specific click
    [Arguments]    ${Selector}
    Click Element    ${Selector}