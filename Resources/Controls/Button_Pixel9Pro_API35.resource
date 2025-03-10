*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Button specific click
    [Arguments]    ${Selector}
    AppiumLibrary.Wait Until Element Is Visible    ${Selector}
    AppiumLibrary.Click Element    ${Selector}