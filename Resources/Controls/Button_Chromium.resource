*** Settings ***
Library    String
Library    Browser

*** Variables ***

*** Keywords ***
Button specific click
    [Arguments]    ${Selector}
    Click    ${Selector}