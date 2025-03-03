*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Checkbox specific get checkbox state
    [Arguments]    ${Selector}
    ${CheckboxState}=    Get Checkbox State    ${Selector}
    RETURN    ${CheckboxState}

Checkbox specific check
    [Arguments]    ${Selector}
    Check Checkbox    ${Selector}

Checkbox specific uncheck
    [Arguments]    ${Selector}
    Uncheck Checkbox    ${Selector}

#ToDo: obviously checkbox handling gets complicated on mobile