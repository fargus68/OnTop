*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Button specific click
    [Arguments]    ${Selector}
    Click Element    ${Selector}