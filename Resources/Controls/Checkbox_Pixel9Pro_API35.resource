*** Settings ***
Library    String
#Library    AppiumLibrary
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper
Library    ../../Libraries/checkboxHelperCheckstate.py

*** Variables ***

*** Keywords ***
Checkbox specific get checkbox state
    [Arguments]    ${Selector}
    ${CheckboxState}=    checkboxHelperCheckstate.Get Checkbox State    ${Selector}
    RETURN    ${CheckboxState}

Checkbox specific click
    [Arguments]    ${Selector}
    #AppiumLibrary.Click Element    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()

Checkbox specific check
    [Arguments]    ${Selector}
    #AppiumLibrary.Click Element    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()

Checkbox specific uncheck
    [Arguments]    ${Selector}
    #AppiumLibrary.Click Element    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()