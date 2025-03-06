*** Settings ***
Library    String
Library    AppiumLibrary
Library    ../../Libraries/checkboxHelperCheckstate.py

*** Variables ***

*** Keywords ***
Checkbox specific get checkbox state
    [Arguments]    ${Selector}
    ${CheckboxState}=    checkboxHelperCheckstate.Get Checkbox State    ${Selector}
    RETURN    ${CheckboxState}

Checkbox specific click
    [Arguments]    ${Selector}
    AppiumLibrary.Click Element    ${Selector}

Checkbox specific check
    [Arguments]    ${Selector}
    AppiumLibrary.Click Element    ${Selector}

Checkbox specific uncheck
    [Arguments]    ${Selector}
    AppiumLibrary.Click Element    ${Selector}