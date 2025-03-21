*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Button specific get attribute names
    [Arguments]    ${Selector}
    Get Attribute Names    ${Selector}

Button specific click
    [Arguments]    ${Selector}
    Browser.Click    ${Selector}