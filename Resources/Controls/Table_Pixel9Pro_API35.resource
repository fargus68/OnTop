*** Settings ***
Library    String
Library    AppiumLibrary

*** Variables ***

*** Keywords ***
Table specific get text
    [Arguments]    ${Selector}
    ${TableContent}=    AppiumLibrary.Get Text    ${Selector}
    RETURN    ${TableContent}

Table specific set text
    [Arguments]    ${Selector}    ${Value}
    AppiumLibrary.Input Text    ${Selector}    ${Value}