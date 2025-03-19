*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Radiobutton specific get checkbox state
    [Arguments]    ${Selector}
    ${CheckboxState}=    Browser.Get Checkbox State    ${Selector}
    RETURN    ${CheckboxState}

Radiobutton specific click
    [Arguments]    ${Selector}
    #Browser.Check Checkbox    ${Selector}
    #Problems with id-selector in insurant data
    Browser.Click    ${Selector}