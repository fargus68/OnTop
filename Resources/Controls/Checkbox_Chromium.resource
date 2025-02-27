*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Checkbox specific get checkbox state
    [Arguments]    ${Selector}
    ${CheckboxState}=    Browser.Get Checkbox State    ${Selector}
    RETURN    ${CheckboxState}

Checkbox specific check
    [Arguments]    ${Selector}
    Browser.Check Checkbox    ${Selector}

Checkbox specific uncheck
    [Arguments]    ${Selector}
    Browser.Uncheck Checkbox    ${Selector}