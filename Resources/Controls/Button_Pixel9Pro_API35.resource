*** Settings ***
Library    String
Library    ../../Libraries/elementHelperAppium.py    WITH NAME    ElementHelper

*** Variables ***

*** Keywords ***
Button specific get attribute names
    [Arguments]    ${Selector}
    Log    Not implemented yet!

Button specific click
    [Arguments]    ${Selector}
    ${element}=    ElementHelper.Search Element    ${Selector}
    Evaluate    $element.click()