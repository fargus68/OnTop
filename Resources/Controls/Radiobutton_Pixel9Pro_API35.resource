*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Radiobutton specific get checkbox state
    [Arguments]    ${Selector}
    #ToDo: später ausprogrammieren, wenn in TT-Planer gefunden oder mobile VAriante vehicle insurance
    ${CheckboxState}=    checkboxHelperCheckstate.Get Checkbox State    ${Selector}
    RETURN    ${CheckboxState}

Radiobutton specific click
    [Arguments]    ${Selector}
    AppiumLibrary.Click Element    ${Selector}