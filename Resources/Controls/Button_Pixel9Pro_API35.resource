*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Button specific click
    [Arguments]    ${Selector}
    AppiumLibrary.Click Element    ${Selector}